<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:bibtex="http://bibtexml.sf.net/"
		xmlns="http://www.w3.org/1999/xhtml"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <head>
        <title>References</title>
        <link href="default.css" type="text/css" rel="stylesheet"/>
	<meta name="creator"
	      content="Generated using tools from BibTeXML.sf.net"/>
	<link rel="copyright"
	      href="http://creativecommons.org/licenses/GPL/2.0/" />
	<link rel="author"
	      href="http://bibtexml.sourceforge.net/" />
	<link rel="alternate"
	      type="application/rss+xml"
	      title="BibTeXML RSS-feed, updates and blog"
	      href="http://bibtexml.sourceforge.net/rss.xml" />
      </head>
      <body>
	<div class="bibtexml-output">
	  <h2>References</h2>

	  <xsl:apply-templates/>
	  <xsl:call-template name="license"/>

	</div>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="license">
    <p id="bibtexml-reference">
      <xsl:text>Bibliography list generated using </xsl:text>
      <a href="http://bibtexml.sf.net/" >BibTeXML</a>
    </p>
  </xsl:template>


</xsl:stylesheet>
