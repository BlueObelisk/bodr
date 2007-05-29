<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:bibtex="http://bibtexml.sf.net/">

  <!--
      The following adds support for BibTeXML extended schema

      This style sheet is reusing code (it is imported
      by bibtex.xsl and strict-bibtexml.xsl):

         <xsl:include href="extended.xsl"/>

  -->

  <xsl:strip-space elements="*"/>
  <xsl:template match="text()">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

  <xsl:template match="bibtex:person">
    <xsl:apply-templates/>
    <xsl:if test="not(position()=last())">
      <xsl:text> and </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="bibtex:person/*">
    <xsl:apply-templates/>
    <xsl:if test="not(position()=last())">
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="bibtex:title/bibtex:title|
		       bibtex:chapter/bibtex:title">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="bibtex:title/bibtex:subtitle|
		       bibtex:chapter/bibtex:subtitle">
    <xsl:text>: </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="bibtex:chapter/bibtex:pages">
    <xsl:text>, pp. </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="bibtex:keyword">
    <xsl:apply-templates/>
    <xsl:if test="not(position()=last()-1)">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>


  <xsl:template name="bibtexml-latex-warning">
    <xsl:text disable-output-escaping="yes"><![CDATA[
%%% BibTeX-file {
%%%    author	 = "",
%%%    filename  = "",
%%%    date      = "",
%%%    version   = "",
%%%    address   = "",
%%%    URL       = "",
%%%    email     = "",
%%%    codetable = "UTF-8",
%%%    supported = "yes|no",
%%%    docstring = "",
%%%    keywords  = "",
%%% }
%%%
%%%    Bibliography text for LaTeX inclusion
%%%    --  output encoding is UTF-8, you need to
%%%    --  convert non-ascii characters to latex control sequences
%%%    --  escape reserved latex characters
%%%    --  review according to the citation style recommendation
%%%    --  edit the above metadata
%%%
%%%    Generated using tools from http://bibtexml.sf.net/
%%%    License: http://creativecommons.org/licenses/GPL/2.0/

]]></xsl:text>
  </xsl:template>


</xsl:stylesheet>
