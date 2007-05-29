<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:cml="http://www.xml-cml.org/schema">

  <xsl:output method="text"/>

  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>

   <xsl:template match="text()"/>

  <xsl:template match="cml:atom">
    <xsl:value-of select="cml:label[@dictRef='bo:symbol']/@value"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="cml:scalar[@dictRef='bo:exactMass']"/>
    <xsl:text>
</xsl:text>
  </xsl:template>

</xsl:stylesheet>
