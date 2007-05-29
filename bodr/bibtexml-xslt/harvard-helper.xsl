<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:bibtex="http://bibtexml.sf.net/"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="text()">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

  <xsl:template name="author">
    <xsl:apply-templates select="bibtex:author|bibtex:editor"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="bibtex:year"/>
    <xsl:text>, </xsl:text>
  </xsl:template>

  <xsl:template match="bibtex:chapter">
    <xsl:text>`</xsl:text>
    <xsl:choose>
      <xsl:when test="bibtex:title">
	<xsl:value-of select="bibtex:title"/>
	<xsl:if test="bibtex:subtitle">
	  <xsl:text>: </xsl:text>
	  <xsl:value-of select="bibtex:subtitle"/>
	</xsl:if>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>' in </xsl:text>
  </xsl:template>


  <xsl:template name="publisher">
    <xsl:apply-templates select="bibtex:edition"/>
    <xsl:apply-templates
	select="bibtex:publisher|bibtex:organization|bibtex:institution"/>
    <xsl:apply-templates select="bibtex:address"/>
  </xsl:template>

  <xsl:template match="
         bibtex:publisher|bibtex:organization|bibtex:institution|
	 bibtex:edition|bibtex:address">
    <xsl:text>, </xsl:text>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="bibtex:pages">
    <xsl:choose>
      <xsl:when test="contains(.,'-')">
	<xsl:text>, pp.</xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>, p.</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="bibtex:volume">
    <xsl:text>, vol.</xsl:text>
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="bibtex:number">
    <xsl:text>, no.</xsl:text>
    <xsl:apply-templates />
  </xsl:template>

  <!-- why does this not work?
  <xsl:template match="bibtex:first|bibtex:middle">
    <xsl:value-of select="substring(.,0,2)" />
    <xsl:text>.</xsl:text>
  </xsl:template>
  -->

  <xsl:template match="bibtex:person">
    <xsl:choose>
      <xsl:when test="bibtex:last">
	<xsl:apply-templates select="bibtex:last"/>
	<xsl:text>, </xsl:text>
	<xsl:choose>
	  <xsl:when test="bibtex:initials">
	    <xsl:apply-templates select="bibtex:initials"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:if test="bibtex:first">
	      <xsl:value-of select="substring(bibtex:first,0,2)" />
	      <xsl:text>.</xsl:text>
	    </xsl:if>
	    <xsl:if test="bibtex:middle">
	      <xsl:value-of select="substring(bibtex:middle,0,2)" />
	      <xsl:text>.</xsl:text>
	    </xsl:if>
	    <!--
		<xsl:apply-templates select="bibtex:first"/>
		<xsl:apply-templates select="bibtex:middle"/>
	    -->
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates/>
      </xsl:otherwise>      
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="position()=last()-1">
	<xsl:text> &amp; </xsl:text>
      </xsl:when>
      <xsl:when test="not(position()=last())">
	<xsl:text>, </xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="editor-add-text">
    <xsl:if test="name()='bibtex:editor'">
      <xsl:choose>
	<xsl:when test="count(bibtex:person)>1">
	  <xsl:text> (eds)</xsl:text>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text> (ed.)</xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <xsl:template match="bibtex:editor">
    <!--  Conflicts with rule in html-linkify.  -->
    <xsl:apply-templates/>
    <xsl:call-template name="editor-add-text"/>
  </xsl:template>

  <xsl:template match="bibtex:doi|bibtex:isbn|bibtex:issn|bibtex:lccn">
    <xsl:text>, </xsl:text>
    <xsl:value-of select='substring-after(name(.),"bibtex:")'/>
    <xsl:text>:</xsl:text>
    <xsl:apply-templates />
  </xsl:template>


</xsl:stylesheet>
