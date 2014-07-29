import sys, os, traceback, re
import argparse
import requests
from bs4 import BeautifulSoup
import wget
import urllib
import tarfile
from subprocess import call
import glob

'''
Helper functions
'''

# Unicode handling
# (decode to unicode early, use unicode everywhere, encode late to string such as when
# writing to disk or print)

# Use this function to decode early
def to_unicode_or_bust( obj, encoding='utf-8-sig'):
    if isinstance(obj, basestring):
        if not isinstance(obj, unicode):
            obj = unicode(obj, encoding)
        return obj
# use .encode('utf-8') to encode late

'''
Main function
'''

def main():
    try:

        # parse command line options
        try:
            # standard flags
            parser = argparse.ArgumentParser(description='Command-line interface to jats-to-mediawiki.xslt, a script to manage conversion of articles (documents) from JATS xml format to MediaWiki markup, based on DOI or PMCID')
            parser.add_argument('-t', '--tmpdir', default='tmp/', help='path to temporary directory for purposes of this script')
            parser.add_argument('-x', '--xmlcatalogfiles',
            default='dtd/catalog-test-jats-v1.xml', help='path to xml catalog files for xsltproc')

            # includes arbitrarily long list of keywords, or an input file
            parser.add_argument('-i', '--infile', nargs='?', type=argparse.FileType('r'), default=sys.stdin, help='path to input file', required=False)
            parser.add_argument('-o', '--outfile', nargs='?', type=argparse.FileType('w'), default=sys.stdout, help='path to output file', required=False)
            parser.add_argument('-a', '--articleids', nargs='+', default=None, help='an article ID or article IDs, either as DOIs or PMCIDs')

            args = parser.parse_args()

#            print args #debug

        except:
            print 'Unable to parse options, use the --help flag for usage information'
            sys.exit(-1)

        # Handle and convert input values
        tmpdir = args.tmpdir
        xmlcatalogfiles = args.xmlcatalogfiles
        infile = args.infile
        outfile = args.outfile
        articleids = []
        # add articleids if passed as option values
        if args.articleids:
            articleids.extend([to_unicode_or_bust(articleid) for articleid in args.articleids])
        # add articleids from file or STDIN
        if not sys.stdin.isatty() or infile.name != "<stdin>":
            articleids.extend([to_unicode_or_bust(line.strip()) for line in infile.readlines()])
        # De-duplicate by converting to set (unique) then back to list again
        articleids = list(set(articleids))

        # set environment variable for xsltproc and jats dtd
        try:
            cwd = to_unicode_or_bust(os.getcwd())
            if xmlcatalogfiles.startswith("/"):
                os.environ["XML_CATALOG_FILES"] = xmlcatalogfiles
            else:
                os.environ["XML_CATALOG_FILES"] = cwd + to_unicode_or_bust("/") + to_unicode_or_bust(xmlcatalogfiles)
        except:
            print 'Unable to set XML_CATALOG_FILES environment variable'
            sys.exit(-1)

        # create temporary directory for zips
        tmpdir = cwd + "/" + to_unicode_or_bust(tmpdir)
        try:
            if not os.path.exists(tmpdir):
                os.makedirs(tmpdir)
        except:
            print 'Unable to find or create temporary directory'
            sys.exit(-1)
        # print "\n" + os.environ.get('XML_CATALOG_FILES') + "\n" #debug

        # separate DOIs and PMCIDs
        articledois = [i for i in articleids if re.match('^10*', i)]
        articlepmcids = [i for i in articleids if re.match('^PMC', i)]

        articlepmcidsfromdois = []

        # Send DOIs through PMC ID converter API:
        # http://www.ncbi.nlm.nih.gov/pmc/tools/id-converter-api/
        if articledois:

            articledois = ",".join(articledois)
            idpayload = {'ids' : articledois, 'format' : 'json'}
            idconverter = requests.get('http://www.pubmedcentral.nih.gov/utils/idconv/v1.0/', params=idpayload)
            print idconverter.text
            records = idconverter.json()['records']
            if records:
                articlepmcidsfromdois = [i['pmcid'] for i in records]

        # Extend PMCIDs with those from converted DOIs
        articlepmcids.extend(articlepmcidsfromdois)

        # De-duplicate with set to list conversion
        articlepmcids = list(set(articlepmcids))

        print "\nArticle IDs to convert:\n" #debug
        print articlepmcids #debug

        # Main loop to grab the archive file, get the .nxml file, and convert
        for articlepmcid in articlepmcids:

            # @TODO make flag an alternative to .tar.gz archive download
            # use instead the regular API for xml document
            # http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pmc&id=PMC2953622
            # unclear if this front-facing XML is updated frequently
            # I recall from plos that updates are made via packaged archives

            # request archive file location
            archivefilepayload = {'id' : articlepmcid}
            archivefilelocator = requests.get('http://www.pubmedcentral.nih.gov/utils/oa/oa.fcgi', params=archivefilepayload)
            record = BeautifulSoup(archivefilelocator.content)

            # parse response for archive file location
            archivefileurl = record.oa.records.record.find(format='tgz')['href']

            # download the file
            print "\nDownloading file..."
            archivefilename = wget.filename_from_url(archivefileurl)
            urllib.urlretrieve(archivefileurl, archivefilename)

             # @TODO For some reason, wget hangs and doesn't finish, using
             # urllib.urlretrieve() instead for this for now.
#            archivefile = wget.download(archivefileurl, wget.bar_thermometer)

            # open the archive
            archivedirectoryname, archivefileextension = archivefilename.split('.tar.gz')
            print archivedirectoryname
            tfile = tarfile.open(archivefilename, 'r:gz')
            tfile.extractall('.')


            # run xsltproc
            # @TODO use list comprehension instead
            for n in glob.glob(archivedirectoryname + "/*.nxml"):
                nxmlfilepath = n
            print "\nConverting... "
            print nxmlfilepath
            fullnxmlfilepath = cwd + "/" + nxmlfilepath
            xsltoutputfile = open(articlepmcid + ".xml.mw", 'w')
            xsltcommand = call(['xsltproc', 'jats-to-mediawiki.xsl', fullnxmlfilepath], stdout=xsltoutputfile)
            print "\nReturning results..."
            if xsltcommand == 0:
                print xsltoutputfile.name + "\n"
            else:
                print "xslt conversion: failure"
                sys.exit(-1)

    except KeyboardInterrupt:
        print "Killed script with keyboard interrupt, exiting..."
    except Exception:
        traceback.print_exc(file=sys.stdout)
    sys.exit(0)

if __name__ == "__main__":
    main()
