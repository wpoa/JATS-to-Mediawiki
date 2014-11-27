<!-- ============================================================= -->
<!--  MODULE:    utilitity for other templates                     -->
<!--                                                               -->
<!--                                                               -->
<!-- ============================================================= -->
<!--                                                               -->
<!DOCTYPE xsl:stylesheet [
<!ENTITY cnn '
			<xsl:if xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="string($debug-mode) = &apos;yes&apos; and not(name(.) = &apos;&apos;)">
				<xsl:comment>
					<xsl:value-of select="name(.)"/>
				</xsl:comment>
			</xsl:if>
	'>
<!ENTITY xcattr 'xclass="{name(.)}"'>

]>

<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:pmc='http://www.pubmedcentral.gov/pmc'
  xmlns:ptpmc="http://www.pubmedcentral.gov/ptpmc"
  xmlns:pf="http://www.pubmedcentral.gov/pf"
  xmlns:func="http://exslt.org/functions"
  xmlns:exslt="http://exslt.org/common"
  xmlns:str="http://exslt.org/strings"
  xmlns:i18n="http://www.ncbi.nlm.nih.gov/i18n"
  extension-element-prefixes="ptpmc func exslt str pf i18n"
  exclude-result-prefixes="xlink ptpmc func exslt str">

<!-- ######################################################        -->
<xsl:param name="ini-ncbi-site" select="'http://www.ncbi.nlm.nih.gov'"/>
<xsl:param name="ncbi-site">
   <xsl:choose>
      <xsl:when test="$ini-ncbi-site = '/'"/>
      <xsl:otherwise>
         <xsl:value-of select="$ini-ncbi-site"/>
      </xsl:otherwise>
   </xsl:choose>
</xsl:param>
<xsl:param name="redirect-auth-token" select="'no'"/>
<xsl:param name="article-id"/>
<xsl:param name="article-instance-id"/>


<xsl:variable name="redirect-param-NA" select="'N%2FA'"/>

<!-- FROM: PageType        -->
<xsl:variable name="redirect-from-type-archive" select="'Archive'"/>
<xsl:variable name="redirect-from-type-article" select="'Article'"/>
<xsl:variable name="redirect-from-type-cited" select="'Cited%20TOC'"/>
<xsl:variable name="redirect-from-type-toc" select="'TOC'"/>
<xsl:variable name="redirect-from-type-entrez" select="'Entrez'"/>
<xsl:variable name="redirect-from-type-frontpage" select="'Journal%20List'"/>
<xsl:variable name="redirect-from-type-homepage" select="'Journal%20Home'"/>

<!-- FROM: PageLayout        -->
<xsl:variable name="redirect-from-layout-banner" select="'Banner'"/>
<xsl:variable name="redirect-from-layout-footer" select="'Footer'"/>
<xsl:variable name="redirect-from-layout-logo" select="'Logo'"/>
<xsl:variable name="redirect-from-layout-citation-ref" select="'CitationRef'"/>
<xsl:variable name="redirect-from-layout-body" select="'Body'"/>
<xsl:variable name="redirect-from-layout-navigation" select="'Navigation'"/>
<xsl:variable name="redirect-from-layout-front-matter" select="'Front%20Matter'"/>
<xsl:variable name="redirect-from-layout-sub-article-front-matter" select="'SubArticle%20Front%20Matter'"/>
<xsl:variable name="redirect-from-layout-docsum" select="'DocSum'"/>

<xsl:variable name="punc-to-be-translated-chars" select="',./?;:[]{}()-=+!*'"/>
<xsl:variable name="punc-to-be-translated-to" select="'..................'"/>
<xsl:variable name="refids"/>
<xsl:variable name="redirect-to-s1-external" select="'External'"/>
<xsl:variable name="redirect-to-s2-article" select="'Article'"/>
<xsl:variable name="redirect-to-s2-publink" select="'Publink'"/>
<xsl:variable name="redirect-to-s2-other" select="'Other'"/>
<xsl:variable name="redirect-to-s2-link" select="'Link'"/>
<xsl:variable name="redirect-to-s2-resource" select="'Resource'"/>
<xsl:variable name="redirect-to-s2-term" select="'Term'"/>
<xsl:variable name="redirect-to-s2-search" select="'Search'"/>
<xsl:variable name="redirect-to-s2-crosslink" select="'Crosslink'"/>
<xsl:variable name="redirect-to-s2-pubmed" select="'PubMed'"/>
<xsl:variable name="redirect-to-s3-abstract" select="'Abstract'"/>
<xsl:variable name="redirect-to-s3-fulltext" select="'FullText'"/>
<xsl:variable name="redirect-to-s3-pdf" select="'PDF'"/>
<xsl:variable name="redirect-to-s3-supp-mat" select="'Supplementary%20Materials'"/>
<xsl:variable name="redirect-to-s3-free-acc" select="'Free%20Access'"/>
<xsl:variable name="redirect-to-s3-rest-acc" select="'Restricted%20Access'"/>
<xsl:variable name="redirect-to-s3-doi" select="'DOI'"/>
<xsl:variable name="redirect-to-s3-uri" select="'URI'"/>
<xsl:variable name="redirect-to-s3-self-uri" select="'Self%20URI'"/>
<xsl:variable name="redirect-to-s3-url" select="'URL'"/>
<xsl:variable name="redirect-to-s3-ftp" select="'FTP'"/>
<xsl:variable name="redirect-to-s3-uniprot" select="'Uniprot'"/>
<xsl:variable name="redirect-to-s3-embl-align" select="'Embl%20Align'"/>
<xsl:variable name="redirect-to-s3-webcite" select="'Web%20Cite'"/>
<xsl:variable name="redirect-to-s3-ncbi-sra" select="'NCBI:sra'"/>
<xsl:variable name="redirect-to-s3-ebi-biomodels" select="'EBI%20Biomodels'"/>
<xsl:variable name="redirect-to-s3-ebi-pride" select="'EBI%20PRIDE'"/>
<xsl:variable name="redirect-to-s3-taxonomy" select="'Taxonomy'"/>
<xsl:variable name="redirect-to-s3-nucleo" select="'Nucleotide'"/>
<xsl:variable name="redirect-to-s3-protein" select="'Protein'"/>
<xsl:variable name="redirect-to-s3-struct" select="'Structure'"/>
<xsl:variable name="redirect-to-s3-geo-data" select="'GEO%20DataSets'"/>
<xsl:variable name="redirect-to-s3-unists" select="'Unists'"/>
<xsl:variable name="redirect-to-s3-omim" select="'Omim'"/>
<xsl:variable name="redirect-to-s3-nihpa-man" select="'NIHPA%20Author%20Manuscripts'"/>
<xsl:variable name="redirect-to-s3-springer" select="'Springer%20Open%20Choice%20Articles'"/>
<xsl:variable name="redirect-to-s3-blackwell" select="'Blackwell%20Online%20Open'"/>
<xsl:variable name="redirect-to-s3-open-acc" select="'Open%20Access%20Articles'"/>
<xsl:variable name="redirect-to-s3-wt-man" select="'Wellcome%20Trust%20Author%20Manuscripts'"/>
<xsl:variable name="redirect-to-s3-3d-domain" select="'3D%20Domains'"/>
<xsl:variable name="redirect-to-s3-books" select="'Books'"/>
<xsl:variable name="redirect-to-s3-cancer-chromo" select="'Cancer%20Chromosomes'"/>
<xsl:variable name="redirect-to-s3-domain" select="'Domains'"/>
<xsl:variable name="redirect-to-s3-gene" select="'Gene'"/>
<xsl:variable name="redirect-to-s3-genome" select="'Genome'"/>
<xsl:variable name="redirect-to-s3-genome-proj" select="'Genome%20Project'"/>
<xsl:variable name="redirect-to-s3-gensat" select="'GENSAT'"/>
<xsl:variable name="redirect-to-s3-homologene" select="'HomoloGene'"/>
<xsl:variable name="redirect-to-s3-popset" select="'Popset'"/>
<xsl:variable name="redirect-to-s3-probeset" select="'Probeset'"/>
<xsl:variable name="redirect-to-s3-pubchem-ba" select="'PubChem%20BioAssay'"/>
<xsl:variable name="redirect-to-s3-pubchem-comp" select="'PubChem%20Compound'"/>
<xsl:variable name="redirect-to-s3-pubchem-sub" select="'PubChem%20Substance'"/>
<xsl:variable name="redirect-to-s3-snp" select="'SNP'"/>
<xsl:variable name="redirect-to-s3-refseq" select="'RefSeq'"/>
<xsl:variable name="redirect-to-s3-refseq-rsg" select="'RefSeq%20Gene'"/>
<xsl:variable name="redirect-to-s3-record" select="'Record'"/>
<xsl:variable name="redirect-to-s3-linkout" select="'Linkout'"/>
<xsl:variable name="redirect-to-s3-auth-search" select="'Author%20Search'"/>
<xsl:variable name="redirect-to-s3-rel-records" select="'Related%20Records'"/>
<xsl:variable name="redirect-to-s3-this-journal" select="'This%20Journal'"/>
<xsl:variable name="redirect-to-s3-this-issue" select="'This%20Issue'"/>
<xsl:variable name="redirect-to-s3-all-pmc" select="'All%20PMC'"/>
<xsl:variable name="redirect-to-s3-pdb" select="'PDB'"/>
<xsl:variable name="redirect-to-s3-genbank" select="'GenBank'"/>
<xsl:variable name="redirect-to-s3-ebi-arrayexpress" select="'EBI%20Array%20Express'"/>
<xsl:variable name="redirect-to-s3-ebi-ena" select="'EBI%20Ena'"/>
<xsl:variable name="redirect-to-s3-bmrb" select="'Bmrb'"/>
<xsl:variable name="redirect-to-s3-geneweaver-geneset" select="'GeneWeaver'"/>
<xsl:variable name="pi-report" select="/processing-instruction('report')"/>
<xsl:variable name="doi-resolver-url" select="'http://dx.doi.org/'"/>
<xsl:variable name="pi-internal-qa" select="string(/processing-instruction('internal-qa'))"/>
<xsl:variable name="pi-art-id"   select="/processing-instruction('artid')"/>
<xsl:variable name="pi-iid"             select="/processing-instruction('iid')"/>
<xsl:variable name="pi-domain-id"       select="/processing-instruction('domainid')"/>
<xsl:variable name="pi-origin" select="/node()/processing-instruction('origin')"/>
<xsl:variable name="redirect-to-s1-entrez" select="'Entrez'"/>

<xsl:variable name="page-redirect-from-type">
	<xsl:choose>
	<xsl:when test="string($apply-render) = $rendertype-archive"><xsl:value-of select="$redirect-from-type-archive"/></xsl:when>
	<xsl:when test="string($apply-render) = $rendertype-abstract
		or string($apply-render) = $rendertype-fulltext
		or string($apply-render) = $rendertype-figure
		or string($apply-render) = $rendertype-table
		or string($apply-render) = $rendertype-publink
		or string($apply-render) = $rendertype-summary
		or string($apply-render) = $rendertype-cover
		or string($apply-render) = $rendertype-scanned-browse
		or string($apply-render) = $rendertype-scanned-summary"><xsl:value-of select="$redirect-from-type-article"/></xsl:when>
	<xsl:when test="string($apply-render) = $rendertype-toc"><xsl:value-of select="$redirect-from-type-toc"/></xsl:when>
	<xsl:when test="string($apply-render) = $rendertype-cited"><xsl:value-of select="$redirect-from-type-cited"/></xsl:when>
	<xsl:when test="string($apply-render) = $rendertype-frontpage"><xsl:value-of select="$redirect-from-type-frontpage"/></xsl:when>
	<xsl:when test="string($apply-render) = $rendertype-homepage"><xsl:value-of select="$redirect-from-type-homepage"/></xsl:when>
	<xsl:when test="string($apply-render) = $rendertype-entrez-toc"><xsl:value-of select="$redirect-from-type-entrez"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="$redirect-param-NA"/></xsl:otherwise>
	</xsl:choose>
</xsl:variable>
<xsl:variable name="pi-apply-render" select="/processing-instruction('apply-render')"/>
<xsl:variable name="apply-render">
  <xsl:choose>
    <xsl:when test="string(/issue-admin/@issue-admin-type) = 'cover' and not (/processing-instruction('scanned') = 'yes')">
      <xsl:value-of select="$rendertype-cover"/>
    </xsl:when>
    <xsl:when test="/issue-admin[not(@issue-admin-type = 'cover') or (@issue-admin-type = 'cover' and /processing-instruction('scanned') = 'yes')]">
      <xsl:value-of select="$rendertype-exception"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$pi-apply-render"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<xsl:variable name="rendertype-abstract"    select="'abstract-article'"/>
<xsl:variable name="rendertype-fulltext"    select="'fulltext-article'"/>
<xsl:variable name="rendertype-figure"      select="'figure'"/>
<xsl:variable name="rendertype-table"       select="'table'"/>
<xsl:variable name="rendertype-box"         select="'box'"/>
<xsl:variable name="rendertype-def-item"    select="'def-item'"/>
<xsl:variable name="rendertype-toc"         select="'toc'"/>
<xsl:variable name="rendertype-entrez-toc"  select="'portal-toc'"/>
<xsl:variable name="rendertype-entrez-toc-citation"  select="'portal-toc-citation'"/>
<xsl:variable name="rendertype-entrez-toc-citation-inline"  select="'portal-toc-citation-inline'"/>
<xsl:variable name="rendertype-previewer-toc"  select="'previewer-toc'"/>
<xsl:variable name="rendertype-cited"       select="'cited'"/>
<xsl:variable name="rendertype-archive"     select="'archive'"/>
<xsl:variable name="rendertype-publink"     select="'publink'"/>
<xsl:variable name="rendertype-scanned-browse"   select="'scanned-browse'"/>
<xsl:variable name="rendertype-scanned-summary"  select="'scanned-summary'"/>
<xsl:variable name="rendertype-cover"       select="'cover'"/>
<xsl:variable name="rendertype-homepage"    select="'homepage'"/>
<xsl:variable name="rendertype-summary"     select="'pdf-only'"/>
<xsl:variable name="rendertype-exception"   select="'exception'"/>
<xsl:variable name="rendertype-searchresult" select="'searchresult'"/>
<xsl:variable name="rendertype-frontpage"   select="'frontpage'"/>
<xsl:variable name="rendertype-booklist"   select="'booklist'"/>
<xsl:variable name="rendertype-bookfilters"   select="'book-filter-list'"/>
<xsl:variable name="rendertype-booksearch"   select="'booksearch'"/>
<!-- books related -->
<xsl:variable name="rendertype-book-navigation" select="'book-navigation'"/>
<xsl:variable name="rendertype-pdf-only" select="'pdf-only'"/>
<xsl:variable name="pi-holding"         select="string(/processing-instruction('holding'))"/>
<xsl:variable name="tocrender-script" select="concat('tocrender.', $pmc-script-extension)"/>
<xsl:variable name="redirect-script" select="''"/>

<xsl:variable name="holding-site-path">
  <xsl:choose>
    <xsl:when test="$pi-holding = 'ukpmc'">
      <xsl:value-of select="$ukpmc-holding-site"/>
    </xsl:when>
    <xsl:when test="$pi-holding = 'capmc'">
      <xsl:value-of select="concat($capmc-holding-site, 'pmcc/')"/>
    </xsl:when>
    <xsl:otherwise/>
  </xsl:choose>
</xsl:variable>


<xsl:variable name="holding-articlerender-script">
  <xsl:choose>
    <xsl:when test="$pi-holding = 'ukpmc'">
      <xsl:value-of select="concat($ukpmc-holding-site, 'articlerender.cgi')"/>
    </xsl:when>
    <xsl:when test="$pi-holding = 'capmc'">
      <xsl:value-of select="concat($capmc-holding-site, 'articlerender.cgi')"/>
    </xsl:when>
    <xsl:otherwise/>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="holding-bookrender-script">
  <xsl:choose>
    <xsl:when test="$pi-holding = 'ukpmc'">
      <xsl:value-of select="concat($ukpmc-holding-site, 'br.cgi')"/>
    </xsl:when>
    <xsl:when test="$pi-holding = 'capmc'">
      <xsl:value-of select="concat($capmc-holding-site, 'br.cgi')"/>
    </xsl:when>
    <xsl:otherwise/>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="holding-pagerender-script">
  <xsl:choose>
    <xsl:when test="$pi-holding = 'ukpmc'">
      <xsl:value-of select="concat($ukpmc-holding-site, 'pagerender.cgi')"/>
    </xsl:when>
    <xsl:when test="$pi-holding = 'capmc'">
      <xsl:value-of select="concat($capmc-holding-site, 'pagerender.cgi')"/>
    </xsl:when>
    <xsl:otherwise/>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="holding-picrender-script">
  <xsl:choose>
    <xsl:when test="$pi-holding = 'ukpmc'">
      <xsl:value-of select="concat($ukpmc-holding-site, 'picrender.cgi')"/>
    </xsl:when>
    <xsl:when test="$pi-holding = 'capmc'">
      <xsl:value-of select="concat($capmc-holding-site, 'picrender.cgi')"/>
    </xsl:when>
    <xsl:otherwise/>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="holding-redirect-script">
<xsl:choose>
    <xsl:when test="$pi-holding = 'ukpmc'">
      <xsl:value-of select="concat($ukpmc-holding-site, '')"/> <!--redirect3.cgi-->
    </xsl:when>
    <xsl:when test="$pi-holding = 'capmc'">
      <xsl:value-of select="concat($capmc-holding-site, '')"/> <!--redirect3.cgi-->
    </xsl:when>
    <xsl:otherwise/>
  </xsl:choose>
</xsl:variable>
<!-- holding ends -->

<xsl:variable name="ukpmc-holding-site" select="'http://ukpmc.ac.uk/'"/>
<xsl:variable name="capmc-holding-site" select="'http://pubmedcentralcanada.ca/'"/>
<xsl:variable name="pmc-script-extension" select="'fcgi'"/>
<xsl:variable name="articlerender-script" select="concat('articlerender.', $pmc-script-extension)"/>
<xsl:variable name="pagerender-script" select="concat('pagerender.', $pmc-script-extension)"/>
<xsl:variable name="picrender-script" select="concat('picrender.', $pmc-script-extension)"/>
<xsl:param name="article-id-type" select="''"/>
<xsl:param name="ini-debug-mode" select="'no'"/>
<xsl:variable name="debug-mode" select="$ini-debug-mode"/>
<xsl:variable name="pubmed-retrieve-base-url" select="$ini-pubmed-base-path"/>
<xsl:variable name="redirect-to-s1-cont-prov" select="'Content%20Provider'"/>
<xsl:param name="ini-pubmed-base-path" select="concat($ncbi-site, '/pubmed/')"/>
















<!-- ######################################################        -->
    <!-- TEMPLATE: utils-put-missing-period
	     CALLED BY (at least):
		     common-modules/article/back.xsl
			 common-modules/article/body.xsl
			 common-modules/article/article-section-content.xsl
			 common-modules/article/back-ref-list/refs.xsl
			 common-modules/article/affiliations.xsl
			 common-modules/article/back-ref-section.xsl
         NOTES:
		     Appends punctuation if and only if and of these is true:
                 >8 long, 8th char from end is "@", and ends in final punct.
			         This appears to be to catch entities that were escaped
					 before reaching XSLT in fcgi apps, which look like:
					     @#xNNNNN;
                 The string is empty.
				 The string does not end in final punct.
				 The force flag is on.
      -->
<xsl:template name="utils-put-missing-period">
	<xsl:param name="input-str"/>
	<xsl:param name="render-string" select="'yes'"/>
	<xsl:param name="punct-char" select="'.'"/>
    <xsl:param name="enforce-missing-period" select="'no'"/>

	<xsl:if test="$render-string = 'yes'"><xsl:copy-of select="$input-str"/></xsl:if>
	<xsl:variable name="ns-input-str" select="translate(normalize-space($input-str), $punc-to-be-translated-chars, $punc-to-be-translated-to)"/>
	<xsl:variable name="ns-len"       select="string-length($ns-input-str)"/>
	<xsl:variable name="last-char"    select="substring($ns-input-str, $ns-len)"/>

	<xsl:choose>
            <xsl:when test="$ns-len=0"/>
			<xsl:when test="$ns-len &gt; 8
                            and $last-char = '.'
                            and substring($ns-input-str, $ns-len - 8, 1) = '@'
							and not(substring($ns-input-str, $ns-len - 8) = '@#x000a0.')">
						<xsl:value-of select="$punct-char"/>
			</xsl:when>
            <xsl:when test="not($last-char = '.')">
                <xsl:value-of select="$punct-char"/>
            </xsl:when>
            <xsl:when test="$enforce-missing-period != 'no'">
                <xsl:value-of select="$punct-char"/>
            </xsl:when>

			<!-- otherwise: don't append the punctuation -->
			<xsl:otherwise/>
	</xsl:choose>
</xsl:template>


<!-- ######################################################        -->
<xsl:template name="utils-generate-id-attr">
	<xsl:param name="prefix" select="concat('__', name())"/>
	<xsl:attribute name="id">
		<xsl:call-template name="utils-generate-id-attr-value">
			<xsl:with-param name="prefix" select="$prefix"/>
		</xsl:call-template>
	</xsl:attribute>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="utils-generate-id-attr-value">
	<xsl:param name="prefix" select="concat('__', name())"/>

	<xsl:variable name="_id" select="@*[local-name(.) = 'id'][1]"/>

	<xsl:choose>
		<xsl:when test="$_id">
			<xsl:value-of select="$_id"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$prefix"/><xsl:value-of select="generate-id()"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!-- ######################################################        -->
<xsl:template name="utils-class-name-attr">
	<xsl:if test="string-length(name()) &gt; 0">
		<xsl:attribute name="class">
			<xsl:value-of select="name()"/>
		</xsl:attribute>
	</xsl:if>
</xsl:template>



<!-- ######################################################        -->
<xsl:template name="ext-link" match="ext-link">
	<xsl:choose>
		<xsl:when test="count(processing-instruction()) &gt; 0
						and string-length(@xlink:href) = 0">
			&lt;div&gt;
			<xsl:call-template name="ext-link-v2"/>
			&lt;/div&gt;
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="ext-link-v1"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="ext-link-v1-build-href-ref">
	<xsl:param name="term_id" select="@xlink:href"/>
	<xsl:param name="content" select="node()"/>
	<xsl:param name="self" select="."/>
	<xsl:param name="ref-info-only" select="'no'"/>
	<xsl:param name="ext-link-type" select="@ext-link-type"/>

    <xsl:variable name="_redirect-layout-source">
    	<xsl:call-template name="redirect-layout-source"/>
    </xsl:variable>

	<xsl:if test="string-length($term_id) &gt; 0">
		<xsl:choose>

			<xsl:when test="$ext-link-type='uri' or $ext-link-type='url' or $ext-link-type='ftp'">
				<!-- Standard HTTP URL -->

			<xsl:call-template name="redirect-url">
				<xsl:with-param name="reftype" select="'extlink'"/>
				<xsl:with-param name="url">
					<xsl:variable name="_url">
						<xsl:choose>
							<xsl:when test="$term_id"><xsl:value-of select="$term_id"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="$content"/></xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<xsl:if test="not (starts-with($_url, 'http://')
										or starts-with($_url, 'https://')
										or starts-with($_url, 'ftp://')
										or starts-with($_url, 'gopher://'))">
						<xsl:text>http://</xsl:text>
					</xsl:if>

					<xsl:value-of select="normalize-space($_url)"/>
				</xsl:with-param>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
				<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-link"/>
				<xsl:with-param name="redirect-to-sub3">
					<xsl:choose>
						<xsl:when test="$ext-link-type='uri'"><xsl:value-of select="$redirect-to-s3-uri"/></xsl:when>
						<xsl:when test="$ext-link-type='url'"><xsl:value-of select="$redirect-to-s3-url"/></xsl:when>
						<xsl:when test="$ext-link-type='ftp'"><xsl:value-of select="$redirect-to-s3-ftp"/></xsl:when>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>

		<xsl:when test="$ext-link-type='doi'">
			<!-- Standard HTTP URL -->
			<xsl:call-template name="redirect-url">
				<xsl:with-param name="reftype" select="'extlink-doi'"/>
				<xsl:with-param name="url" select="concat($doi-resolver-url, $term_id)"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
				<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-link"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-doi"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>
	    <xsl:when test="$ext-link-type='emblalign'">
	        <!-- Standard FTP URL -->
	        <xsl:call-template name="redirect-url">
	            <xsl:with-param name="reftype" select="'extlink-emblalign'"/>
	            <xsl:with-param name="url" select="concat('ftp://ftp.ebi.ac.uk/pub/databases/embl/align/', $term_id, '.dat')"/>
	            <xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
	            <xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
	            <xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
	            <xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-embl-align"/>
	            <xsl:with-param name="ref-info-only" select="$ref-info-only"/>
	        </xsl:call-template>
	    </xsl:when>
	    <!-- commented on Sergey Krasnov request on May 8, 2008
	    <xsl:when test="$ext-link-type='uniprot'">
	        <xsl:call-template name="redirect-url">
	            <xsl:with-param name="reftype" select="'extlink-uniprot'"/>
	            <xsl:with-param name="url" select="concat('http://www.pir.uniprot.org/cgi-bin/upEntry?id=', $term_id)"/>
	            <xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
	            <xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
	            <xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
	            <xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-uniprot"/>
	        </xsl:call-template>
	    </xsl:when>
	    -->
	       <xsl:when test="$ext-link-type='webcite'">
	           <!-- Standard FTP URL -->
	           <xsl:call-template name="redirect-url">
	               <xsl:with-param name="reftype" select="'extlink-webcite'"/>
	               <xsl:with-param name="url" select="concat('http://www.webcitation.org/', $term_id)"/>
	               <xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
	               <xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
	               <xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
	               <xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-webcite"/>
	               <xsl:with-param name="ref-info-only" select="$ref-info-only"/>
	           </xsl:call-template>
	       </xsl:when>
		<xsl:when test="$ext-link-type='NCBI:sra'">
		  <xsl:call-template name="redirect-url">
		    <xsl:with-param name="reftype" select="'extlink-ncbi:sra'"/>
		    <xsl:with-param name="url" select="concat($ncbi-site, '/sra?term=', $term_id)"/>
		    <xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
                    <xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
                    <xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
                    <xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-ncbi-sra"/>
                    <xsl:with-param name="ref-info-only" select="$ref-info-only"/>
                  </xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='biomodels'">
                  <xsl:call-template name="redirect-url">
                    <xsl:with-param name="reftype" select="'extlink-biomodels'"/>
                    <xsl:with-param name="url" select="concat('http://www.ebi.ac.uk/biomodels-main/', $term_id)"/>
                    <xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
                    <xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
                    <xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
                    <xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-ebi-biomodels"/>
                    <xsl:with-param name="ref-info-only" select="$ref-info-only"/>
                  </xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='pride' and string-length(translate($term_id, '012345678', '')) = 0">
		  <xsl:call-template name="redirect-url">
			<xsl:with-param name="reftype" select="'extlink-pride'"/>
			<xsl:with-param name="url" select="concat('http://www.ebi.ac.uk/pride/experiment.do?experimentAccessionNumber=', $term_id)"/>
			<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
			<xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
			<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
			<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-ebi-pride"/>
			<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
		  </xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='entrez-taxonomy' or $ext-link-type = 'NCBI:taxonomy'">
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/Taxonomy/Browser/wwwtax.cgi?</xsl:text>
				<xsl:choose>
					<xsl:when test="$term_id='0' or $term_id=''">
						<xsl:text>name=</xsl:text><xsl:value-of select="translate($content,' ', '+')"/>
					</xsl:when>
					<xsl:when test="$term_id &gt; '0'">
						<xsl:text>id=</xsl:text><xsl:value-of select="$term_id"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="'extlink-entrez-taxonomy'"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-taxonomy"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='entrez-protein' or $ext-link-type = 'NCBI:protein'">
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/protein/</xsl:text>
				<xsl:value-of select="$content"/><xsl:text/>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="'extlink-entrez-protein'"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-protein"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='entrez-protein-range'">
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/protein/?term=</xsl:text>
				<xsl:value-of select="$term_id"/>[pacc]<xsl:text/>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="'extlink-entrez-protein-range'"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-protein"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='entrez-nucleotide' or $ext-link-type = 'NCBI:nucleotide'">
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/nuccore/</xsl:text>
				<xsl:value-of select="$content"/>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="'extlink-entrez-nucleotide'"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-nucleo"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='entrez-nucleotide-range'">
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/nuccore/?term=</xsl:text>
				<xsl:value-of select="$term_id"/>[pacc]<xsl:text/>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="'extlink-entrez-nucleotide-range'"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-nucleo"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='entrez-structure' or $ext-link-type='NCBI:structure'">
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/Structure/mmdb/mmdbsrv.cgi?form=6&amp;db=t&amp;Dopt=s&amp;uid=</xsl:text>
				<xsl:value-of select="$term_id"/>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="concat('extlink-',  $ext-link-type)"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-struct"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='entrez-geo' or $ext-link-type='NCBI:geo'">
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/geo/query/acc.cgi?acc=</xsl:text>
				<xsl:value-of select="$term_id"/>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="concat('extlink-',  $ext-link-type)"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-geo-data"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='entrez-unists'">
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/unists/?term=</xsl:text>
				<xsl:value-of select="$term_id"/>[Marker+name]<xsl:text/>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="concat('extlink-',  $ext-link-type)"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-unists"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='entrez-omim' or $ext-link-type='omim'">
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/omim/</xsl:text>
	            <xsl:value-of select="$term_id"/>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="concat('extlink-',  $ext-link-type)"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-omim"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
		</xsl:when>
		<!-- PMC-18536 begins -->
		<xsl:when test="$ext-link-type='NCBI:gene'">
			<xsl:value-of select="pf:redirect-entrez-term-url(
				'gene', $term_id, concat('extlink-',  $ext-link-type),
				$_redirect-layout-source,
				$redirect-to-s3-gene, $ref-info-only)"/>
		</xsl:when>
		<xsl:when test="$ext-link-type='NCBI:pubchem-bioassay'">
			<xsl:value-of select="pf:redirect-entrez-term-url(
				'pcassay', $term_id, concat('extlink-',  $ext-link-type),
				$_redirect-layout-source,
				$redirect-to-s3-pubchem-ba, $ref-info-only)"/>
		</xsl:when>
		<xsl:when test="$ext-link-type='NCBI:pubchem-compound'">
			<xsl:value-of select="pf:redirect-entrez-term-url(
				'pccompound', $term_id, 
				concat('extlink-',  $ext-link-type), 
				$_redirect-layout-source,
				$redirect-to-s3-pubchem-comp, $ref-info-only)"/>
		</xsl:when>
		<xsl:when test="$ext-link-type='NCBI:pubchem-substance'">
			<xsl:value-of select="pf:redirect-entrez-term-url(
				'pcsubstance', $term_id, 
				concat('extlink-',  $ext-link-type), 
				$_redirect-layout-source,
				$redirect-to-s3-pubchem-sub, $ref-info-only)"/>
		</xsl:when>
		<xsl:when test="$ext-link-type='NCBI:refseq'">
			<xsl:value-of select="pf:redirect-entrez-term-url(
				'RefSeq', $term_id, 
				concat('extlink-',  $ext-link-type), 
				$_redirect-layout-source,
				$redirect-to-s3-refseq, $ref-info-only)"/>
		</xsl:when>
		<xsl:when test="$ext-link-type='NCBI:refseq_gene'">
			<xsl:value-of select="pf:redirect-entrez-term-url(
				'refseq/rsg', $term_id, 
				concat('extlink-',  $ext-link-type), 
				$_redirect-layout-source,
				$redirect-to-s3-refseq-rsg, $ref-info-only)"/>
		</xsl:when>
		<xsl:when test="$ext-link-type='PDB'">
			<xsl:call-template name="redirect-url">
				<xsl:with-param name="reftype" select="'extlink-pdb'"/>
				<xsl:with-param name="url" select="concat('http://www.pdb.org/', $term_id)"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
				<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-pdb"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			  </xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='UniProt'">
			<xsl:call-template name="redirect-url">
				<xsl:with-param name="reftype" select="'extlink-uniprot'"/>
				<xsl:with-param name="url" select="concat('http://www.uniprot.org/', $term_id)"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
				<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-uniprot"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			  </xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='DDBJ/EMBL/GenBank' or $ext-link-type = 'genbank' or $ext-link-type = 'GenBank'">
			<xsl:value-of select="pf:redirect-entrez-term-url(
				'nucleotide', $term_id, 
				concat('extlink-',  $ext-link-type), 
				$_redirect-layout-source,
				$redirect-to-s3-genbank, $ref-info-only)"/>
		</xsl:when>
		<xsl:when test="$ext-link-type='EBI:arrayexpress'">
			<xsl:call-template name="redirect-url">
				<xsl:with-param name="reftype" select="'extlink-ebi-arrayexpress'"/>
				<xsl:with-param name="url" select="concat('http://www.ebi.ac.uk/arrayexpress/', $term_id)"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
				<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-ebi-arrayexpress"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			  </xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='EBI:ena'">
			<xsl:call-template name="redirect-url">
				<xsl:with-param name="reftype" select="'extlink-ebi-ena'"/>
				<xsl:with-param name="url" select="concat('http://www.ebi.ac.uk/ena/data/view/', $term_id)"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
				<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-ebi-ena"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			  </xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='bmrb'">
			<xsl:call-template name="redirect-url">
				<xsl:with-param name="reftype" select="'extlink-bmrb'"/>
				<xsl:with-param name="url" select="concat('http://www.bmrb.wisc.edu/data_library/summary/index.php?bmrbId=', $term_id)"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
				<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-bmrb"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			  </xsl:call-template>
		</xsl:when>
		<xsl:when test="$ext-link-type='geneweaver:geneset'">
			<xsl:call-template name="redirect-url">
				<xsl:with-param name="reftype" select="'extlink-geneweaver-geneset'"/>
				<xsl:with-param name="url" select="concat('http://geneweaver.org/index.php?action=manage&amp;cmd=viewgeneset&amp;gs_id=', $term_id)"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-external"/>
				<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-resource"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-geneweaver-geneset"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			  </xsl:call-template>
		</xsl:when>
		<!-- PMC-18536 ends -->
	    <xsl:when test="string($pi-internal-qa) = 'yes' and $ext-link-type='entrez-snp-rs'">
	        <!--Entrez SNP-RS link -->
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/snp/?term=</xsl:text>
				<xsl:value-of select="$term_id"/>[uid]<xsl:text/>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="concat('extlink-',  $ext-link-type)"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-snp"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
	    </xsl:when>
	    <xsl:when test="string($pi-internal-qa) = 'yes' and $ext-link-type='entrez-snp-rs-range'">
	        <!--Entrez SNP-RS-range link -->
			<xsl:variable name="_url">
				<xsl:value-of select="$ncbi-site"/>
				<xsl:text>/snp/?term=</xsl:text>
				<xsl:value-of select="$term_id"/>[rs]<xsl:text/>
			</xsl:variable>
			<xsl:call-template name="redirect-entrez-term-url">
				<xsl:with-param name="reftype" select="concat('extlink-',  $ext-link-type)"/>
				<xsl:with-param name="url" select="$_url"/>
				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-snp"/>
				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
			</xsl:call-template>
	    </xsl:when>
	    
	    <xsl:when test="string($pi-internal-qa) = 'yes' and $ext-link-type='entrez-snp-ss'">
	        <!--Entrez SNP-SS link -->
	   			<xsl:variable name="_url">
	   				<xsl:value-of select="$ncbi-site"/>
	   				<xsl:text>/snp/?report=RSR&amp;term=</xsl:text>
	   				<xsl:value-of select="$term_id"/>
	   			</xsl:variable>
	   			<xsl:call-template name="redirect-entrez-term-url">
	   				<xsl:with-param name="reftype" select="concat('extlink-',  $ext-link-type)"/>
	   				<xsl:with-param name="url" select="$_url"/>
	   				<xsl:with-param name="redirect-from-layout" select="$_redirect-layout-source"/>
	   				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-snp"/>
	   				<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
	   			</xsl:call-template>
	   	    </xsl:when>

	   		<xsl:when test="$ext-link-type='pmc' and $term_id > 0">
	   			<xsl:if test="$ref-info-only = 'no'">
		   			<xsl:call-template name="links-article-href">
						<xsl:with-param name="article-id" select="$term_id"/>
						<xsl:with-param name="article-id-type" select="'pubmedid'"/>
					</xsl:call-template>
				</xsl:if>
	   		</xsl:when>
	   		<xsl:when test="$ext-link-type='article' and $term_id> 0">
	   			<xsl:if test="$ref-info-only = 'no'">
		   			<xsl:call-template name="links-article-href">
						<xsl:with-param name="article-id" select="concat('PMC', $term_id)"/>
						<xsl:with-param name="article-id-type" select="'accid'"/>
<!-- PMCACCID: probably I can do nothing about it if it is coming from NXML, not from term patching procedure -->
					</xsl:call-template>
				</xsl:if>
	   		</xsl:when>
	   	    <xsl:when test="/book-part">
	   	    	<xsl:if test="$ref-info-only = 'no'">
	   	        	<xsl:apply-templates select="$content" mode="book-part"/>
	   	        </xsl:if>
	   	    </xsl:when>
		    <!-- revision 1.26
			date: 2008/07/15 21:35:31;  author: kolotev;  state: Exp;  lines: +3 -3
			pdb and a few other ext-link-types processing was removed on Sergey Krasnov request. July 15, 2008
		    -->
		    <xsl:when test="$ext-link-type = 'pdb'">
				<xsl:text>~~~EXT-LINK-TYPE-UNSUPPORTED~~~</xsl:text>
		    </xsl:when>
	   	    <xsl:otherwise>
			<xsl:if test="$ref-info-only = 'no'">~~~UNKNOWN-EXT-LINK-TYPE~~~</xsl:if>
		    </xsl:otherwise>
	   	</xsl:choose>
   </xsl:if>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="ext-link-v1">
	<xsl:param name="term_id" select="@xlink:href"/>
	<xsl:param name="content" select="node()"/>
	<xsl:param name="self" select="."/>

    <!-- href -->
    <xsl:variable name="_href">
    	<xsl:call-template name="ext-link-v1-build-href-ref">
			<xsl:with-param name="term_id" select="$term_id"/>
			<xsl:with-param name="content" select="$content"/>
			<xsl:with-param name="self" select="$self"/>
		</xsl:call-template>
    </xsl:variable>

	<!-- ref -->
    <xsl:variable name="_ref">
    	<xsl:call-template name="ext-link-v1-build-href-ref">
			<xsl:with-param name="term_id" select="$term_id"/>
			<xsl:with-param name="content" select="$content"/>
			<xsl:with-param name="self" select="$self"/>
			<xsl:with-param name="ref-info-only" select="'yes'"/>
		</xsl:call-template>
    </xsl:variable>

    <!-- Display text -->

    <xsl:variable name="_display-text">
    	<xsl:choose>
    		<xsl:when test="string-length($content) &gt; 0"><xsl:apply-templates select="$content"/></xsl:when> <!-- use enclosed text -->
    		<xsl:when test="@ext-link-type='pmc' or @ext-link-type='article'"></xsl:when> <!-- If no enclosed text in a pmc link, ignore it -->
    		<xsl:when test="@ext-link-type='webcite'">&lt;i&gt;webcite&lt;/i&gt;</xsl:when> <!-- If no enclosed text in a pmc link, ignore it -->
    		<xsl:otherwise><xsl:value-of select="$term_id"/></xsl:otherwise> <!-- otherwise use the 'access' attribute -->
    	</xsl:choose>
    </xsl:variable>


	<xsl:choose>

		<xsl:when test="string-length($_display-text) = 0"/>
		<!-- at some point the captions for figures and tables were linked
			to the new popup page, but now only  label us being linked
			and there is (more..) link for long ones, the next xsl:when case commented because
			we want to see links inside caption  if they exist -->
		<!-- <xsl:when test="($pi-apply-render = $rendertype-fulltext and count(ancestor::caption) != 0)">
			<xsl:value-of select="$_display-text"/>
		</xsl:when>
		-->
		<!-- a special case, PMC does not want link for DOI if it is in ref-list section, ask Ed Sequeira and Dr. Lipman about it. -->
		<xsl:when test="ancestor::ref-list
						and string-length($_display-text) &gt; 0
						and (@ext-link-type = 'doi')">

				<xsl:copy-of select="$_display-text"/>

		</xsl:when>
	<xsl:when test="starts-with ($_href, '~~~EXT-LINK-TYPE-UNSUPPORTED~~~')">

			<xsl:copy-of select="$_display-text"/>

	</xsl:when>
		<xsl:when test="
			not(starts-with($_href, '~~~UNKNOWN-EXT-LINK-TYPE~~~'))
			and string-length($_href) > 0
			">

			<xsl:variable name="pmc-tagrid-class">
				<xsl:apply-templates select="@pmc:tagrid" mode="gen-class-attr-value"/>
			</xsl:variable>

			<xsl:text>[</xsl:text>
			<xsl:value-of select="$_href" />
			<xsl:text>&#160;</xsl:text>

				<xsl:if test="string-length($pmc-tagrid-class) &gt; 0">
					<xsl:attribute name="class">
						<xsl:value-of select="$pmc-tagrid-class"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:call-template name="redirect-ref-attr">
					<xsl:with-param name="ref" select="$_ref"/>
				</xsl:call-template>
				<xsl:apply-templates select="@pmc:tagrid" mode="gen-id-attr"/>
				<xsl:copy-of select="$_display-text"/>
			<xsl:text>]</xsl:text>
		</xsl:when>
		<xsl:when test="count(pmc:tag) &gt; 0">
			<xsl:copy-of select="$_display-text"/>
		</xsl:when>
		<xsl:otherwise>

				<xsl:copy-of select="$_display-text"/>

				<xsl:call-template name="utils-show-warning">
					<xsl:with-param name="msg">
						<!-- raw ext-link -->

							<xsl:choose>
								<xsl:when test="string-length($term_id) = 0">
									<xsl:text>Essential information is missing [check $term_id value]</xsl:text>

								</xsl:when>
								<xsl:otherwise>
									<xsl:text>this type of ext-link is not implemented yet</xsl:text>
								</xsl:otherwise>
							</xsl:choose>

							&lt;br/&gt;
							<xsl:for-each select="@*">
								[@<xsl:value-of select="name()"/> = <xsl:value-of select="."/>]&lt;br/&gt;
							</xsl:for-each>
							<xsl:for-each select="processing-instruction()">
								[PI: <xsl:value-of select="name()"/> = <xsl:value-of select="."/>]&lt;br/&gt;
							</xsl:for-each>
							&lt;strong&gt;&lt;a href="#" title="not implemented yet"&gt;&lt;strong&gt;EXT-LINK:&lt;/strong&gt;&lt;/a&gt; <xsl:apply-templates select="$content"/>&lt;/strong&gt;

					</xsl:with-param>
				</xsl:call-template>

		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="back-ref-citation-pub-id">
	<xsl:param name="id" select="@id"/>

	<xsl:variable name="_pmid">
		<xsl:call-template name="back-ref-citation-pmid-lookup">
			<xsl:with-param name="id" select="$id" />
		</xsl:call-template>
	</xsl:variable>

	<xsl:if test="number($_pmid) &gt; 0">
		<xsl:text> </xsl:text>
		<xsl:call-template name="back-ref-pmid-link">
			<xsl:with-param name="pmid" select="$_pmid"/>
		</xsl:call-template>
		 <!-- linkout functionality was suppressed as Sergey Krasnov requested on Apr 19, 2010 -->
		<!--xsl:call-template name="back-ref-full-text-link">
			<xsl:with-param name="pmid" select="$_pmid"/>
		</xsl:call-template-->
	</xsl:if>

	<xsl:for-each select="ancestor-or-self::*[pub-id[@pub-id-type = 'doi']][1]">
	<xsl:call-template name="back-ref-crossref-link">
	<xsl:with-param name="doi" select="pub-id[@pub-id-type = 'doi']"/>
	</xsl:call-template>
	</xsl:for-each>


</xsl:template>


<!-- ######################################################        -->
<xsl:template name="redirect-url">
	<xsl:param name="reftype" select="'other'"/>
	<xsl:param name="url" select="''"/>
	<xsl:param name="redirect-add-options" select="''"/>
	<xsl:param name="redirect-from-type" select="$page-redirect-from-type"/>
	<xsl:param name="redirect-from-layout" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub1" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub2" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub3" select="$redirect-param-NA"/>
	<xsl:param name="_holding"/>
	<xsl:param name="ref-info-only" select="'no'"/>

	<xsl:variable name="_redirect-script">
		<xsl:call-template name="links-lookup-for-redirect-script">
			<xsl:with-param name="_holding" select="$_holding"/>
		</xsl:call-template>
	</xsl:variable>

        <xsl:variable name="_redirect-auth-stat-params">
   		<xsl:call-template name="redirect-auth-stat-params">
			<xsl:with-param name="reftype" select="$reftype"/>
			<xsl:with-param name="url" select="$url"/>
			<xsl:with-param name="redirect-add-options" select="$redirect-add-options"/>
			<xsl:with-param name="redirect-from-type" select="$redirect-from-type"/>
			<xsl:with-param name="redirect-from-layout" select="$redirect-from-layout"/>
			<xsl:with-param name="redirect-to-sub1" select="$redirect-to-sub1"/>
			<xsl:with-param name="redirect-to-sub2" select="$redirect-to-sub2"/>
			<xsl:with-param name="redirect-to-sub3" select="$redirect-to-sub3"/>
			<xsl:with-param name="_holding" select="$_holding"/>
			<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
   		</xsl:call-template>
	</xsl:variable>

	<xsl:call-template name="redirect-url-pack-params">
		<xsl:with-param name="redirect-script" select="$_redirect-script"/>
		<xsl:with-param name="redirect-auth-stat-params" select="$_redirect-auth-stat-params"/>
		<xsl:with-param name="redirect-url" select="$url"/>
		<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
	</xsl:call-template>

</xsl:template>

<xsl:template name="redirect-auth-stat-params">
	<xsl:param name="reftype" select="'other'"/>
	<xsl:param name="url" select="''"/>
	<xsl:param name="redirect-add-options" select="''"/>
	<xsl:param name="redirect-from-type" select="$page-redirect-from-type"/>
	<xsl:param name="redirect-from-layout" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub1" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub2" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub3" select="$redirect-param-NA"/>
	<xsl:param name="_holding"/>
	<xsl:param name="ref-info-only" select="'no'"/>

   <xsl:if test="$redirect-auth-token = 'yes'">
   		<xsl:call-template name="redirect-get-auth-param"/>
   </xsl:if>

	<xsl:if test="not (string($reftype) = '')">&amp;reftype=<xsl:value-of select="$reftype"/></xsl:if>

	<!-- article id processing -->
	<xsl:variable name="_artid">
		<xsl:choose>
			<xsl:when test="/article"><xsl:value-of select="$pi-art-id"/></xsl:when>
			<xsl:when test="/toc and number(ancestor::tocentry/@artid) > 0"><xsl:value-of select="ancestor::tocentry/@artid"/></xsl:when>
			<xsl:when test="string($apply-render) = $rendertype-cited"><xsl:value-of select="/toc/cited/@artid"/></xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:variable>

	<!-- issue id processing -->
	<xsl:variable name="_iid">
		<xsl:choose>
			<xsl:when test="$pi-iid"><xsl:value-of select="$pi-iid"/></xsl:when>
			<xsl:when test="/toc and number(/toc/@iid) > 0"><xsl:value-of select="/toc/@iid"/></xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:variable>

	<!-- journal/domain id processing -->
	<xsl:variable name="_domain-id">
		<xsl:choose>
			<xsl:when test="$pi-domain-id"><xsl:value-of select="$pi-domain-id"/></xsl:when>
			<xsl:when test="/toc and number(/toc/@journal) > 0"><xsl:value-of select="/toc/@journal"/></xsl:when>
			<xsl:when test="string($apply-render) = $rendertype-cited"><xsl:value-of select="/toc/cited/@journal"/></xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:variable>

	<xsl:if test="not (string($redirect-add-options) = '')">&amp;<xsl:value-of select="$redirect-add-options"/></xsl:if>

	<xsl:variable name="_redirect-from">
		<xsl:call-template name="redirect-concat-params">
			<xsl:with-param name="sub1" select="$redirect-from-type"/>
			<xsl:with-param name="sub2" select="$redirect-from-layout"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="_redirect-to">
		<xsl:call-template name="redirect-concat-params">
			<xsl:with-param name="sub1" select="$redirect-to-sub1"/>
			<xsl:with-param name="sub2" select="$redirect-to-sub2"/>
			<xsl:with-param name="sub3" select="$redirect-to-sub3"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:if test="number($_artid)">&amp;article-id=<xsl:value-of select="$_artid"/></xsl:if>
	<xsl:if test="number($_iid)">&amp;issue-id=<xsl:value-of select="$_iid"/></xsl:if>
	<xsl:if test="number($_domain-id)">&amp;journal-id=<xsl:value-of select="$_domain-id"/></xsl:if>
	<xsl:if test="not (string($_redirect-from) = '')">&amp;FROM=<xsl:value-of select="$_redirect-from"/></xsl:if>
	<xsl:if test="not (string($_redirect-to) = '')">&amp;TO=<xsl:value-of select="$_redirect-to"/></xsl:if>

	<!-- new rendering-type param  -->
	<!-- -->
	<xsl:choose>
		<xsl:when test="/article/processing-instruction('nihms')
				or $pi-origin = 'nihms'
				or $pi-origin = 'ukpmcpa'">&amp;rendering-type=nihms</xsl:when>

		<xsl:when test="string($apply-render) = $rendertype-publink">&amp;rendering-type=publink</xsl:when>
		<xsl:otherwise>&amp;rendering-type=normal</xsl:otherwise>
	</xsl:choose>
	<!-- -->
	<!-- end of new rendering-type param  -->
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="redirect-entrez-url">
	<xsl:param name="reftype" select="'other'"/>
	<xsl:param name="url" select="''"/>
	<xsl:param name="redirect-add-options" select="''"/>
	<xsl:param name="redirect-from-type" select="$page-redirect-from-type"/>
	<xsl:param name="redirect-from-layout" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub2" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub3" select="$redirect-param-NA"/>
	<xsl:param name="ref-info-only" select="'no'"/>
	<xsl:call-template name="wrap-url-in-redirect-if-necessary">
		<xsl:with-param name="reftype" select="$reftype"/>
		<xsl:with-param name="url" select="$url"/>
		<xsl:with-param name="redirect-add-options" select="$redirect-add-options"/>
		<xsl:with-param name="redirect-from-type" select="$redirect-from-type"/>
		<xsl:with-param name="redirect-from-layout" select="$redirect-from-layout"/>
		<xsl:with-param name="redirect-to-sub1" select="$redirect-to-s1-entrez"/>
		<xsl:with-param name="redirect-to-sub2" select="$redirect-to-sub2"/>
		<xsl:with-param name="redirect-to-sub3" select="$redirect-to-sub3"/>
		<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
	</xsl:call-template>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="redirect-entrez-term-url">
	<xsl:param name="reftype" select="'other'"/>
	<xsl:param name="url" select="''"/>
	<xsl:param name="redirect-add-options" select="''"/>
	<xsl:param name="redirect-from-type" select="$page-redirect-from-type"/>
	<xsl:param name="redirect-from-layout" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub3" select="$redirect-param-NA"/>
	<xsl:param name="ref-info-only" select="'no'"/>
	<xsl:call-template name="redirect-entrez-url">
		<xsl:with-param name="reftype" select="$reftype"/>
		<xsl:with-param name="url" select="$url"/>
		<xsl:with-param name="redirect-add-options" select="$redirect-add-options"/>
		<xsl:with-param name="redirect-from-type" select="$redirect-from-type"/>
		<xsl:with-param name="redirect-from-layout" select="$redirect-from-layout"/>
		<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-term"/>
		<xsl:with-param name="redirect-to-sub3" select="$redirect-to-sub3"/>
		<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
	</xsl:call-template>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="redirect-layout-source">
	<xsl:choose>
   		<xsl:when test="ancestor::back and ancestor::ref"><xsl:value-of select="$redirect-from-layout-citation-ref"/></xsl:when>
   		<xsl:when test="ancestor::body"><xsl:value-of select="$redirect-from-layout-body"/></xsl:when>
   		<xsl:when test="ancestor::front"><xsl:value-of select="$redirect-from-layout-front-matter"/></xsl:when>
   		<xsl:otherwise><xsl:value-of select="$redirect-from-layout-body"/></xsl:otherwise>
   	</xsl:choose>
</xsl:template>

<xsl:template name="redirect-ref-attr">
	<xsl:param name="ref" select="''"/>
	<xsl:if test="string-length($ref) &gt; 0">
		<xsl:attribute name="ref"><xsl:value-of select="$ref"/></xsl:attribute>
	</xsl:if>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="redirect-get-auth-param">
	<xsl:value-of select="'&amp;auth={__AUTH_HASH__}'"/>
</xsl:template>

<!-- ######################################################        -->
<xsl:template match="uri" name="uri">
	<xsl:variable name="_schema">
		<xsl:choose>
			<xsl:when test="starts-with(@xlink:href, 'www.')">http://</xsl:when>
			<xsl:when test="starts-with(@xlink:href, 'ftp.')">ftp://</xsl:when>
			<xsl:when test="starts-with(@xlink:href, 'gopher.')">gopher://</xsl:when>
			<xsl:when test="starts-with(@xlink:href, 'wais.')">wais://</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="contains(@xlink:href, '://') or not($_schema = '')">
			<xsl:text>[</xsl:text>
			<xsl:value-of select="concat($_schema, @xlink:href)" />
			<xsl:text>&#160;</xsl:text>
				<xsl:apply-templates/>
			<xsl:text>]</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<!-- ######################################################        -->
<xsl:template name="ext-link-v2">

	<xsl:choose>
		<xsl:when test="(@ext-link-type='entrez-protein-range'
							or @ext-link-type='entrez-nucleotide-range')
						and (processing-instruction('beg_text') 
								and processing-instruction('end_text'))">	
			<xsl:call-template name="ext-link-v1">
				<xsl:with-param name="term_id" select="concat(processing-instruction('beg_text'), ':', processing-instruction('end_text'))"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@ext-link-type='entrez-geo' or @ext-link-type='entrez-unists' or @ext-link-type='NCBI:geo'">	
			<xsl:call-template name="ext-link-v1">
				<xsl:with-param name="term_id" select="processing-instruction('term_text')"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="@ext-link-type='entrez-taxonomy' or @ext-link-type='NCBI:taxonomy'">	
			<xsl:call-template name="ext-link-v1">
				<xsl:with-param name="term_id" select="processing-instruction('term_id')"/>
				<xsl:with-param name="content" select="processing-instruction('term_text')"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="processing-instruction('term_id')">	
			<xsl:call-template name="ext-link-v1">
				<xsl:with-param name="term_id" select="processing-instruction('term_id')"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="ext-link-v1"/>
		</xsl:otherwise>
	</xsl:choose>


</xsl:template>


<!-- ######################################################        -->
<xsl:template name="links-article-href">
	<xsl:param name="article-instance-id"/>
	<xsl:param name="article-id"/>
	<xsl:param name="article-id-type" select="''"/>
	<xsl:param name="pmc-accession-id"/>
	<xsl:param name="pmc-accession-id-ver"/>
	<xsl:param name="rendertype"/>
	<xsl:param name="report"/>
	<xsl:param name="id"/>
	<xsl:param name="href-extra"/>
	<xsl:param name="scanned" select="number(0)"/>
	<xsl:param name="cited" select="number(0)"/>
	<xsl:param name="holding" select="$pi-holding"/>
	<xsl:param name="_holding" select="ancestor-or-self::*[@holding][1]/@holding"/>

	<xsl:call-template name="links-article-href-v1">
		<xsl:with-param name="article-instance-id" select="$article-instance-id"/>
		<xsl:with-param name="article-id" select="$article-id"/>
		<xsl:with-param name="article-id-type" select="$article-id-type"/>
		<xsl:with-param name="pmc-accession-id" select="$pmc-accession-id"/>
		<xsl:with-param name="pmc-accession-id-ver" select="$pmc-accession-id-ver"/>
		<xsl:with-param name="rendertype" select="$rendertype"/>
		<xsl:with-param name="report" select="$report"/>
		<xsl:with-param name="id" select="$id"/>
		<xsl:with-param name="href-extra" select="$href-extra"/>
		<xsl:with-param name="scanned" select="$scanned"/>
		<xsl:with-param name="cited" select="$cited"/>
		<xsl:with-param name="holding" select="$holding"/>
		<xsl:with-param name="_holding" select="$_holding"/>
	</xsl:call-template>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="links-article-href-v1">
	<xsl:param name="article-instance-id"/>
	<xsl:param name="article-id"/>
	<xsl:param name="article-id-type" select="''"/>
	<xsl:param name="pmc-accession-id"/>
	<xsl:param name="pmc-accession-id-ver"/>
	<xsl:param name="rendertype"/>
	<xsl:param name="report"/>
	<xsl:param name="id"/>
	<xsl:param name="href-extra"/>
	<xsl:param name="scanned" select="number(0)"/>
	<xsl:param name="cited" select="number(0)"/>
    <xsl:param name="holding" select="$pi-holding"/>
    <xsl:param name="_holding" select="ancestor-or-self::*[@holding][1]/@holding"/>


	<xsl:variable name="_href">
		<xsl:choose>
			<xsl:when test="$cited &gt; 0">
				<xsl:value-of select="$tocrender-script"/>
			</xsl:when>
			<xsl:when test="$scanned &gt; 0">
				<xsl:call-template name="links-lookup-for-pagerender-script">
					<xsl:with-param name="holding" select="$holding"/>
					<xsl:with-param name="_holding" select="$_holding"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="links-lookup-for-articlerender-script">
					<xsl:with-param name="holding" select="$holding"/>
					<xsl:with-param name="_holding" select="$_holding"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>?</xsl:text>
		<xsl:call-template name="links-process-manuscript-id-type">
			<xsl:with-param name="article-id-type" select="$article-id-type"/>
			<xsl:with-param name="article-instance-id" select="$article-instance-id"/>
			<xsl:with-param name="article-id" select="$article-id"/>
		</xsl:call-template>
		<xsl:if test="$cited &gt; 0">
			<xsl:value-of select="'&amp;action=cited'"/>
		</xsl:if>
		<xsl:if test="$rendertype">
			<xsl:value-of select="concat('&amp;rendertype=', $rendertype)"/>
		</xsl:if>
		<xsl:if test="string-length($report)">
			<xsl:value-of select="concat('&amp;report=', $report)"/>
		</xsl:if>
		<xsl:if test="$id">
			<xsl:value-of select="concat('&amp;id=', $id)"/>
		</xsl:if>
	</xsl:variable>

	<xsl:call-template name="links-concat-href-and-href-extra">
		<xsl:with-param name="href" select="$_href"/>
		<xsl:with-param name="href-extra" select="$href-extra"/>
	</xsl:call-template>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="links-article">
	<xsl:param name="article-instance-id"/>
	<xsl:param name="article-id"/>
	<xsl:param name="article-id-type" select="''"/>
	<xsl:param name="pmc-accession-id"/>
	<xsl:param name="pmc-accession-id-ver"/>
	<xsl:param name="href-extra"/>
	<xsl:param name="scanned" select="number(0)"/>
	<xsl:param name="cited" select="number(0)"/>
    <xsl:param name="holding" select="$pi-holding"/>
    <xsl:param name="_holding" select="@holding"/>
	<xsl:param name="id"/>
	<xsl:param name="name"/>
	<xsl:param name="class"/>
	<xsl:param name="style"/>
	<xsl:param name="target"/>
	<xsl:param name="content"/>

	<xsl:call-template name="links-link">
		<xsl:with-param name="id" select="$id"/>
		<xsl:with-param name="name" select="$name"/>
		<xsl:with-param name="class" select="$class"/>
		<xsl:with-param name="style" select="$style"/>
		<xsl:with-param name="target" select="$target"/>
		<xsl:with-param name="href">
			<xsl:call-template name="links-article-href">
				<xsl:with-param name="article-instance-id" select="$article-instance-id"/>
				<xsl:with-param name="article-id" select="$article-id"/>
				<xsl:with-param name="article-id-type" select="$article-id-type"/>
				<xsl:with-param name="pmc-accession-id" select="$pmc-accession-id"/>
				<xsl:with-param name="pmc-accession-id-ver" select="$pmc-accession-id-ver"/>
				<xsl:with-param name="href-extra" select="$href-extra"/>
				<xsl:with-param name="scanned" select="$scanned"/>
				<xsl:with-param name="cited" select="$cited"/>
				<xsl:with-param name="holding" select="$holding"/>
				<xsl:with-param name="_holding" select="$_holding"/>
			</xsl:call-template>
		</xsl:with-param>
		<xsl:with-param name="content" select="$content"/>
	</xsl:call-template>

</xsl:template>

<!-- ######################################################        -->
<xsl:template name="links-lookup-for-redirect-script">
    <xsl:param name="holding" select="$pi-holding"/>
    <xsl:param name="_holding" select="@holding"/>
    <xsl:choose>
        <xsl:when test="string-length($holding) &gt; 0 and $_holding = 'yes'">
            <xsl:value-of select="$holding-redirect-script"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$redirect-script"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>
<!-- ######################################################        -->
<xsl:template name="links-lookup-for-articlerender-script">
    <xsl:param name="holding" select="$pi-holding"/>
    <xsl:param name="_holding" select="@holding"/>
    <xsl:choose>
        <xsl:when test="string-length($holding) &gt; 0 and $_holding = 'yes'">
            <xsl:value-of select="$holding-articlerender-script"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$articlerender-script"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="links-lookup-for-pagerender-script">
    <xsl:param name="holding" select="$pi-holding"/>
    <xsl:param name="_holding" select="@holding"/>

    <xsl:choose>
        <xsl:when test="string-length($holding) &gt; 0 and $_holding = 'yes'">
            <xsl:value-of select="$holding-pagerender-script"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$pagerender-script"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="links-lookup-for-picrender-script">
    <xsl:param name="holding" select="$pi-holding"/>
    <xsl:param name="_holding" select="@holding"/>
    <xsl:choose>
        <xsl:when test="string-length($holding) &gt; 0 and $_holding = 'yes'">
            <xsl:value-of select="$holding-picrender-script"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$picrender-script"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- ######################################################        -->
<xsl:template name="links-link">
	<xsl:param name="id"/>
	<xsl:param name="name"/>
	<xsl:param name="class"/>
	<xsl:param name="style"/>
	<xsl:param name="href"/>
	<xsl:param name="href-extra"/>
	<xsl:param name="content"/>
	<xsl:param name="target"/>

	<xsl:variable name="_href">
		<xsl:call-template name="links-concat-href-and-href-extra">
			<xsl:with-param name="href" select="$href"/>
			<xsl:with-param name="href-extra" select="$href-extra"/>
		</xsl:call-template>
	</xsl:variable>

	&lt;a&gt;
		<xsl:if test="string-length($id) &gt; 0">
			<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="string-length($name) &gt; 0">
			<xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="string-length($class) &gt; 0">
			<xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="string-length($style) &gt; 0">
			<xsl:attribute name="style"><xsl:value-of select="$style"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="string-length($_href) &gt; 0">
			<xsl:attribute name="href"><xsl:value-of select="$_href"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="string-length($target) &gt; 0">
			<xsl:attribute name="target"><xsl:value-of select="$target"/></xsl:attribute>
		</xsl:if>
		<xsl:if test="$content">
			<xsl:copy-of select="$content"/>
		</xsl:if>
	&lt;/a&gt;
</xsl:template>

<!-- Capitalize a string -->
  <xsl:template name="capitalize">
     <xsl:param name="str"/>
     <xsl:value-of select="translate($str, 
             'abcdefghjiklmnopqrstuvwxyz',
        'ABCDEFGHJIKLMNOPQRSTUVWXYZ')"/>
  </xsl:template>        

 <!-- ######################################################        -->
  <!-- Helper template to return month name from number -->
  <xsl:template name="dates-month-number-to-month-name">
    <xsl:param name="month"/>
    <xsl:call-template name="i18n-get-month-name">
      <xsl:with-param name="numMonth" select="$month"/>
    </xsl:call-template>
  </xsl:template>

<!-- ######################################################        -->
<xsl:template name="links-concat-href-and-href-extra">
	<xsl:param name="href"/>
	<xsl:param name="href-extra"/>

	<xsl:variable name="_href-1">
		<xsl:if test="string-length($href) &gt; 0">
			<xsl:value-of select="$href"/>
			<xsl:if test="string-length($href-extra) &gt; 0">
				<xsl:choose>
					<xsl:when test="starts-with($href-extra, '#')">
						<xsl:value-of select="$href-extra"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="not (
										starts-with($href-extra, '&amp;')
										or starts-with($href-extra, '{CGI}')
										or starts-with($href-extra, '?')
									    )
										and not (
											substring($href, string-length($href), 1) = '?'
											or substring($href, string-length($href), 5) = '{CGI}'
											or substring($href, string-length($href), 1) = '&amp;'
											  )">{CGI}</xsl:if>
						<xsl:value-of select="$href-extra"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:variable>

	<xsl:variable name="_href">
		<xsl:call-template name="utils-str-subst">
			<xsl:with-param name="text">
				<xsl:call-template name="utils-str-subst">
					<xsl:with-param name="text" select="$_href-1"/> 
					<xsl:with-param name="replace" select="'?'"/>
					<xsl:with-param name="with" select="'{CGI}'"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="replace" select="'&amp;'"/>
			<xsl:with-param name="with" select="'{CGI}'"/>
		</xsl:call-template>
	</xsl:variable>


	<xsl:call-template name="utils-str-subst">
		<xsl:with-param name="text">
			<xsl:choose>
				<xsl:when test="contains($_href, '{CGI}')">
					<xsl:value-of select="concat(substring-before($_href, '{CGI}'),
											'?',
											substring-after($_href, '{CGI}'))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$_href"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
		<xsl:with-param name="replace" select="'{CGI}'"/>
		<xsl:with-param name="with" select="'&amp;'"/>
	</xsl:call-template>

</xsl:template>

<!-- ######################################################        -->
<xsl:template name="links-process-manuscript-id-type">
	<xsl:param name="article-id-type" select="$article-id-type"/>
	<xsl:param name="article-instance-id" select="$article-instance-id"/>
	<xsl:param name="article-id" select="$article-id"/>
	<xsl:param name="pmc-accession-id"/>
	<xsl:param name="pmc-accession-id-ver"/>
    <xsl:param name="blob" select="false()"/>
	<xsl:param name="blobtype" select="'bin'"/>
<!-- 
<xsl:text/>@1=<xsl:value-of select="$article-id-type"/>
<xsl:text/>@2=<xsl:value-of select="$article-id"/>
<xsl:text/>@3=<xsl:value-of select="$article-instance-id"/>
<xsl:text/>@4=<xsl:value-of select="$pmc-accession-id"/>
<xsl:text/>@5=<xsl:value-of select="$pmc-accession-id-ver"/>
<xsl:text/>@6=<xsl:value-of select="$blobtype"/>#<xsl:text/>
-->
	<xsl:choose>
		<xsl:when test="$article-id-type = 'target-manuscript' and string-length($article-id) &gt; 0">
			<xsl:value-of select="concat('mid=', $article-id)"/>
		</xsl:when>
		<xsl:when test="$article-id-type = 'target-manuscript' and string-length($article-instance-id) &gt; 0">
			<xsl:value-of select="concat('artinstid=', $article-instance-id)"/>
		</xsl:when>
		<!--xsl:when test="$article-id-type = 'manuscript'
						and ($pi-requested-by = 'artinstid'
								or number($pi-final-publisher-artid) &gt; 0)
						and string-length($article-instance-id) > 0">
			<xsl:value-of select="concat('artinstid=', $article-instance-id)"/>
		</xsl:when-->
		<!--xsl:when test="$article-id-type = 'manuscript'
						and ($pi-requested-by = 'mid')
						and string-length($article-instance-id) > 0">
			<xsl:value-of select="concat('artinstid=', $article-instance-id)"/>
		</xsl:when-->
		<xsl:when test="$article-id-type = 'manuscript' and string-length($article-id)">
			<xsl:choose>
				<xsl:when test="boolean($blob) and $blobtype = 'pdf'">
					<xsl:value-of select="concat('mid=', $article-id)"/>
				</xsl:when>
				<xsl:when test="boolean($blob)">
					<xsl:value-of	select="concat('artinstid=', pf:mid2artinstid($article-id))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of	select="concat('mid=', $article-id)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:when test="$article-id-type = 'accid-ver' and string-length($article-id)">
			<xsl:value-of select="concat('accid=', $article-id)"/>
		</xsl:when>
		<xsl:when test="$article-id-type = 'accid-ver' and string-length($article-instance-id)">
			<xsl:value-of select="concat('accid=', $article-instance-id)"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat($article-id-type, '=', $article-id)"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="wrap-url-in-redirect-if-necessary">
	<xsl:param name="url" select="''"/>
	<xsl:param name="reftype" select="'other'"/>
	<xsl:param name="redirect-add-options" select="''"/>
	<xsl:param name="redirect-from-layout" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub1" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub2" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub3" select="$redirect-param-NA"/>
	<xsl:param name="ref-info-only" select="'no'"/>

	<xsl:choose>
		<xsl:when test="string-length($url) > 0">
			<xsl:choose>
				<xsl:when test="contains($url, 'http://') or contains($url, 'https://') or $ref-info-only = 'yes'">
					<xsl:call-template name="redirect-url">
						<xsl:with-param name="reftype" select="$reftype"/>
						<xsl:with-param name="url" select="$url"/>
						<xsl:with-param name="redirect-add-options" select="$redirect-add-options"/>
						<xsl:with-param name="redirect-from-layout" select="$redirect-from-layout"/>
						<xsl:with-param name="redirect-to-sub1" select="$redirect-to-sub1"/>
						<xsl:with-param name="redirect-to-sub2" select="$redirect-to-sub2"/>
						<xsl:with-param name="redirect-to-sub3" select="$redirect-to-sub3"/>
						<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
					</xsl:call-template>
				</xsl:when>
                <xsl:otherwise><xsl:value-of select="$url"/></xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise/>
	</xsl:choose>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="redirect-concat-params">
	<xsl:param name="sub1" select="$redirect-param-NA"/>
	<xsl:param name="sub2" select="$redirect-param-NA"/>
	<xsl:param name="sub3" select="''"/>

	<xsl:value-of select="concat($sub1, '|', $sub2)"/>
	<xsl:if test="not (string($sub3) = '')">|<xsl:value-of select="$sub3"/></xsl:if>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="redirect-url-pack-params">
	<xsl:param name="redirect-script"/>
	<xsl:param name="redirect-auth-stat-params"/>
	<xsl:param name="redirect-url"/>
	<xsl:param name="ref-info-only" select="'no'"/>
	<xsl:choose>
		<xsl:when test="$ref-info-only = 'no'">
			<!--xsl:value-of select="concat($redirect-script, '?&amp;', $redirect-auth-stat-params, '&amp;&amp;', $redirect-url)"/-->
			<xsl:value-of select="$redirect-url"/>
		</xsl:when>
		<xsl:otherwise/>
	</xsl:choose>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="utils-str-subst">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="with"/>
    <xsl:param name='disable-output-escaping'>no</xsl:param>

    <xsl:choose>
	<xsl:when test="string-length($replace) = 0 and $disable-output-escaping = 'yes'">
	    <xsl:value-of select="$text" disable-output-escaping='yes'/>
	</xsl:when>

	<xsl:when test="string-length($replace) = 0">
	    <xsl:value-of select="$text"/>
	</xsl:when>

	<xsl:when test="contains($text, $replace)">

	    <xsl:variable name="before" select="substring-before($text, $replace)"/>
	    <xsl:variable name="after" select="substring-after($text, $replace)"/>

	    <xsl:choose>
		<xsl:when test="$disable-output-escaping = 'yes'">
		    <xsl:value-of select="$before" disable-output-escaping="yes"/>
		    <xsl:value-of select="$with" disable-output-escaping="yes"/>
		</xsl:when>
		<xsl:otherwise>
		    <xsl:value-of select="$before"/>
		    <xsl:value-of select="$with"/>
		</xsl:otherwise>
	    </xsl:choose>
	    <xsl:call-template name="utils-str-subst">
		<xsl:with-param name="text" select="$after"/>
		<xsl:with-param name="replace" select="$replace"/>
		<xsl:with-param name="with" select="$with"/>
		<xsl:with-param name="disable-output-escaping" select="$disable-output-escaping"/>
	    </xsl:call-template>
	</xsl:when>

	<xsl:when test='$disable-output-escaping = "yes"'>
	    <xsl:value-of select="$text" disable-output-escaping="yes"/>
	</xsl:when>

	<xsl:otherwise>
	    <xsl:value-of select="$text"/>
	</xsl:otherwise>
    </xsl:choose>
</xsl:template>

 <!--#############################################################################-->
  <xsl:template name="i18n-format-message">
    <xsl:param name="strMessageId"/>
    <xsl:param name="setArguments"/>
    <xsl:param name="strLanguageId" select="''"/>
    <xsl:variable name="strContentLanguageId">
      <xsl:choose>
        <xsl:when test="boolean($strLanguageId)">
          <xsl:value-of select="$strLanguageId"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="i18n-get-content-language"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <i18n:format-message id="{$strMessageId}" xml:lang="{$strContentLanguageId}">
      <xsl:copy-of select="$setArguments"/>
    </i18n:format-message>
  </xsl:template>

<!-- ######################################################        -->
<xsl:template name="utils-show-warning">
	<xsl:param name="msg" select="''"/>
	<xsl:if test="string($debug-mode) = 'yes'">
		<xsl:call-template name="utils-show-msg">
			<xsl:with-param name="msg" select="$msg"/>
			<xsl:with-param name="class" select="'msg-warning'"/>
			<xsl:with-param name="keyword" select="'WARNING'"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="utils-show-msg">
	<xsl:param name="msg" select="''"/>
	<xsl:param name="class" select="''"/>
	<xsl:param name="keyword" select="''"/>

	<xsl:if test="string($debug-mode) = 'yes' or string($pi-internal-qa) = 'yes'">

			<xsl:text/>&lt;<xsl:value-of select="$keyword"/>&#160;[context=<xsl:text/>
			<xsl:call-template name="utils-node-path"/>
			<xsl:text>]:&#160;</xsl:text>
			<xsl:copy-of select="$msg"/>&gt;

	</xsl:if>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="back-ref-citation-pmid-lookup">
	<xsl:param name="id" select="@id" />
	<xsl:variable name="_pmid-pi">
		<xsl:if test="not(string($id) = '')">
		<!-- 
		<xsl:value-of select="key('pi-key', concat('refpmid_', $id))" />
		-->
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="_pmid">
		<xsl:choose>
			<xsl:when test='not(string ($_pmid-pi) = "")'>
				<xsl:value-of select='$_pmid-pi' />
			</xsl:when>
			<xsl:when test="name() = 'pub-id' and @pub-id-type='pmid'">
				<xsl:value-of select="text()" />
			</xsl:when>
			<xsl:when
				test="not(string(id($id)/node()/pub-id[@pub-id-type='pmid'][1]) = '')"
			>
				<xsl:value-of select="id($id)/node()/pub-id[@pub-id-type='pmid'][1]/text()" />
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:variable>

	<xsl:value-of select="$_pmid"/>
</xsl:template>

<!-- ######################################################        -->
<xsl:template name="back-ref-pmid-link">
	<xsl:param name="pmid"/>

 	<xsl:if test="number($pmid) &gt; 0">

		<xsl:variable name="__pubmed-url" select="concat($pubmed-retrieve-base-url, number($pmid))"/>

		<xsl:variable name="_pubmed-url">
			<xsl:call-template name="redirect-entrez-pubmed-url">
				<xsl:with-param name="reftype" select="'pubmed'"/>
				<xsl:with-param name="url" select="$__pubmed-url"/>
				<xsl:with-param name="redirect-from-layout" select="$redirect-from-layout-citation-ref"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-record"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="_pubmed-ref">
			<xsl:call-template name="redirect-entrez-pubmed-url">
				<xsl:with-param name="reftype" select="'pubmed'"/>
				<xsl:with-param name="url" select="$_pubmed-url"/>
				<xsl:with-param name="redirect-from-layout" select="$redirect-from-layout-citation-ref"/>
				<xsl:with-param name="redirect-to-sub3" select="$redirect-to-s3-record"/>
				<xsl:with-param name="ref-info-only" select="'yes'"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:text> </xsl:text>

			<xsl:variable name="pmid-label" select="'PubMed'"/>
			<xsl:choose>
				<xsl:when test="$pi-report = 'printable'">
					<xsl:if test="@pub-id-type = 'pmid'">[<xsl:value-of select="$pmid-label"/>: <xsl:value-of select="$pmid"/>]</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>[</xsl:text>
						<xsl:value-of select="$_pubmed-url" />
						<xsl:text>&#160;</xsl:text>
							<xsl:call-template name="redirect-ref-attr">
								<xsl:with-param name="ref" select="$_pubmed-ref"/>
							</xsl:call-template>
							<xsl:value-of select="$pmid-label"/>
						<xsl:text>]</xsl:text>
				</xsl:otherwise>
			</xsl:choose>

	</xsl:if>
</xsl:template>
<!-- ######################################################        -->
<xsl:template name="back-ref-crossref-link">
	<xsl:param name="doi"/>
	<xsl:param name="label"/>
	<xsl:param name="redirect-from-layout" select="$redirect-from-layout-citation-ref"/>
	<xsl:param name="redirect-to-sub1" select="$redirect-to-s1-cont-prov"/>
	<xsl:param name="redirect-to-sub2" select="$redirect-to-s2-crosslink"/>
	<xsl:param name="redirect-to-sub3" select="$redirect-to-s3-doi"/>

 	<xsl:if test="string-length($doi) &gt; 0">
	    <xsl:variable name="_doi-url">
		<xsl:value-of select="$doi-resolver-url"/>
		<xsl:call-template name="extension-full-escape-url">
			<xsl:with-param name="str" select="$doi"/>
		</xsl:call-template>
	    </xsl:variable>
    
	    <xsl:variable name="_crossref-url">
		    <xsl:call-template name="wrap-url-in-redirect-if-necessary">
		    <xsl:with-param name="url" select="$_doi-url"/>
		    <xsl:with-param name="reftype" select="'other'"/>
		    <xsl:with-param name="redirect-from-layout" select="$redirect-from-layout"/>
		    <xsl:with-param name="redirect-to-sub1" select="$redirect-to-sub1"/>
		    <xsl:with-param name="redirect-to-sub2" select="$redirect-to-sub2"/>
		    <xsl:with-param name="redirect-to-sub3" select="$redirect-to-sub3"/>
		    <xsl:with-param name="ref-info-only" select="'no'"/>
		    </xsl:call-template>
	    </xsl:variable>
	    <xsl:variable name="_crossref-ref">
		    <xsl:call-template name="wrap-url-in-redirect-if-necessary">
		    <xsl:with-param name="url" select="$_doi-url"/>
		    <xsl:with-param name="reftype" select="'other'"/>
		    <xsl:with-param name="redirect-from-layout" select="$redirect-from-layout"/>
		    <xsl:with-param name="redirect-to-sub1" select="$redirect-to-sub1"/>
		    <xsl:with-param name="redirect-to-sub2" select="$redirect-to-sub2"/>
		    <xsl:with-param name="redirect-to-sub3" select="$redirect-to-sub3"/>
		    <xsl:with-param name="ref-info-only" select="'yes'"/>
		    </xsl:call-template>
	    </xsl:variable>
    
	    <xsl:text> </xsl:text>
	    <xsl:choose>
			<xsl:when test="string-length($label) &gt; 0">
				<xsl:text>[</xsl:text>
				<xsl:value-of select="$_crossref-url" />
				<xsl:text>&#160;</xsl:text>
					<xsl:call-template name="redirect-ref-attr">
						<xsl:with-param name="ref" select="$_crossref-ref"/>
					</xsl:call-template>
					<xsl:copy-of select="$label"/>
				<xsl:text>]</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not ($pi-report = 'printable')">

						<xsl:text>[</xsl:text>
						<xsl:value-of select="$_crossref-url" />
						<xsl:text>&#160;</xsl:text>
							<xsl:call-template name="redirect-ref-attr">
								<xsl:with-param name="ref" select="$_crossref-ref"/>
							</xsl:call-template>
							<xsl:text>Cross Ref</xsl:text>
						<xsl:text>]</xsl:text>

				</xsl:if>
			</xsl:otherwise>
	    </xsl:choose>
	</xsl:if>
</xsl:template>
<!-- ######################################################        -->

  <!--#############################################################################-->
  <xsl:template name="i18n-get-ancestor-language">
    <xsl:value-of select="ancestor-or-self::*[@xml:lang][1]/@xml:lang"/>
  </xsl:template>

  <!--#############################################################################-->
  <xsl:template name="i18n-get-content-language">
    <xsl:choose>
      <xsl:when test="generate-id(.) = generate-id(/)">
        <xsl:for-each select="/article | /issue-admin">
          <xsl:call-template name="i18n-get-ancestor-language"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="i18n-get-ancestor-language"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--#############################################################################-->
  <xsl:template name="i18n-get-month-name">
    <xsl:param name="numMonth"/>
    <xsl:choose>
      <xsl:when test="string(number($numMonth)) != 'NaN'">
        <xsl:call-template name="i18n-format-message">
          <xsl:with-param name="strMessageId" select="concat('NLS.LOCALE.SMONTHNAME', string(number($numMonth)))"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise><xsl:copy-of select="$numMonth"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!-- ######################################################        -->
<xsl:template name="utils-node-path">
	<xsl:text>/</xsl:text>
	<xsl:for-each select="ancestor-or-self::*">
		<xsl:value-of select="name()"/>/<xsl:text/>
	</xsl:for-each>
</xsl:template>


<!-- ######################################################        -->
<xsl:template name="redirect-entrez-pubmed-url">
	<xsl:param name="reftype" select="'other'"/>
	<xsl:param name="url" select="''"/>
	<xsl:param name="redirect-add-options" select="''"/>
	<xsl:param name="redirect-from-type" select="$page-redirect-from-type"/>
	<xsl:param name="redirect-from-layout" select="$redirect-param-NA"/>
	<xsl:param name="redirect-to-sub3" select="$redirect-param-NA"/>
	<xsl:param name="ref-info-only" select="'no'"/>
	<xsl:call-template name="redirect-entrez-url">
		<xsl:with-param name="reftype" select="$reftype"/>
		<xsl:with-param name="url" select="$url"/>
		<xsl:with-param name="redirect-add-options" select="$redirect-add-options"/>
		<xsl:with-param name="redirect-from-type" select="$redirect-from-type"/>
		<xsl:with-param name="redirect-from-layout" select="$redirect-from-layout"/>
		<xsl:with-param name="redirect-to-sub2" select="$redirect-to-s2-pubmed"/>
		<xsl:with-param name="redirect-to-sub3" select="$redirect-to-sub3"/>
		<xsl:with-param name="ref-info-only" select="$ref-info-only"/>
	</xsl:call-template>
</xsl:template>

<!-- ######################################################        -->
<!-- fake template to make xalan happy, when I need to call this template -->
<xsl:template name="extension-full-escape-url">
	<xsl:param name="str"/>
	<xsl:copy-of select="$str"/>
</xsl:template>

</xsl:stylesheet>
