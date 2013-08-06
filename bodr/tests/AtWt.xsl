<?xml version="1.0"?>
<!--
 * This stylesheet simply compares our elements database with
 * the Atomic Weight table by the IUPAC.
 *
 * Run it with: 
 * 
 *     xsltproc -''-html AtWt.xsl http://www.chem.qmul.ac.uk/iupac/AtWt/
 *
 * to debug add: -''-param verbose 1
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:cml="http://www.xml-cml.org/schema"
                xmlns:xml="http://www.w3.org/XML/1998/namespace" 
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
                xmlns:bo="http://www.blueobelisk.org/dict/terminology" 
                xmlns:boUnits="http://www.blueobelisk.org/dict/units" 
                xmlns:units="http://www.xml-cml.org/units/units" 
                xmlns:siUnits="http://www.xml-cml.org/units/siUnits" 
                xmlns:bibx="http://bibtexml.sf.net/" 
                version="1.0">

<xsl:strip-space elements="*"/>

<xsl:param name="verbose" select="false()"/>

<!--
 * Just catch the first table. We don't need to parse both tables,
 * which just differ in order.
-->
<!-- Table 2007: /descendant::table[1]-->
<!-- Table 2011: /descendant::table[2]-->
<xsl:template match="/">
	<xsl:apply-templates select="/descendant::table[3]"/>
</xsl:template>

<!--
 * Parse the table line by line, going up in the Element number.
 * Don't process the table "header".  
-->
<xsl:template match="table">
	<xsl:apply-templates select="tr[number(td[1]) = true()]">
		<xsl:sort data-type="number" order="ascending" select="td[1]"/>
	</xsl:apply-templates>
</xsl:template>

<!--
 * The basic table layout is: 
 *
 * | No || Symbol || Name || Atomic Weight || Notes |
 *
 * Interesting are only the first 4. We don't care about the notes.
 * The 'Atomic Wt' column can have values with the error value appended
 * inside parenthesis and the values can be surrounded by square
 * brackets. So we need to remove the square brackets and the error
 * value for the atomic weight and extract the error value from
 * inside the parenthesis. If there are no parenthesis, there is no
 * error value.
-->
<xsl:template match="tr">
	<xsl:choose>
		<!-- There *is* an error value inside parenthsis. -->
		<xsl:when test="contains(td[4], '(') and
		                string-length(substring-before(td[4], '('))">

			<xsl:call-template name="compare.AtWt.BODR.tables">
				<xsl:with-param name="iupac.ElementNo" select="normalize-space(td[1])"/>
				<xsl:with-param name="iupac.ElementSy" select="normalize-space(td[2])"/>
				<xsl:with-param name="iupac.Element" select="normalize-space(translate(td[3],'&#x00A0;',' '))"/>
				<xsl:with-param name="iupac.Mass"
				                select="normalize-space(translate(substring-before(td[4], '('), '[]', ''))"/>
				<xsl:with-param name="iupac.Error"
				                select="normalize-space(substring-after(substring-before(td[4], ')'), '('))"/>
			</xsl:call-template>

		</xsl:when>
		<!-- There is *no* error value. -->
		<xsl:otherwise>
			<xsl:call-template name="compare.AtWt.BODR.tables">
				<xsl:with-param name="iupac.ElementNo" select="normalize-space(td[1])"/>
				<xsl:with-param name="iupac.ElementSy" select="normalize-space(td[2])"/>
				<xsl:with-param name="iupac.Element" select="normalize-space(translate(td[3],'&#x00A0;',' '))"/>
				<xsl:with-param name="iupac.Mass"
				                select="normalize-space(translate(td[4], '[]', ''))"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!--
 * The following template gets: Element number, symbol and name, mass
 * and error value (if any) as extracted from the IUPAC table.
 *
 * Based on the Element number it extracts the same information from
 * our elements database and compares the values. If there is a difference,
 * it errors out with a note, which difference we have.
-->
<xsl:template name="compare.AtWt.BODR.tables">
	<xsl:param name="iupac.ElementNo"/>
	<xsl:param name="iupac.ElementSy"/>
	<xsl:param name="iupac.Element"/>
	<xsl:param name="iupac.Mass"/>
	<xsl:param name="iupac.Error" select="'novalue'"/>

	<xsl:variable name="bodr.node"
	              select="document('elements/elements.xml')//cml:atom[child::cml:scalar[attribute::dictRef='bo:atomicNumber']=$iupac.ElementNo]"/>
	<xsl:variable name="bodr.Element"
	              select="$bodr.node/cml:label[@dictRef='bo:name']/@value"/>
	<xsl:variable name="bodr.ElementSy"
	              select="$bodr.node/cml:label[@dictRef='bo:symbol']/@value"/>
	<xsl:variable name="bodr.Mass"
	              select="$bodr.node/cml:scalar[@dictRef='bo:mass']"/>
	<xsl:variable name="bodr.Error">
		<xsl:choose>
			<xsl:when test="$bodr.node/cml:scalar[@dictRef='bo:mass']/@errorValue">
				<xsl:value-of select="$bodr.node/cml:scalar[@dictRef='bo:mass']/@errorValue"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'novalue'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:if test="$verbose">
		<xsl:message>DEBUG ElementNo. <xsl:value-of select="$iupac.ElementNo"/>
  Name   &lt;<xsl:value-of select="$iupac.Element"/>&gt; <xsl:value-of select="$bodr.Element"/>
  Symbol &lt;<xsl:value-of select="$iupac.ElementSy"/>&gt; <xsl:value-of select="$bodr.ElementSy"/>
  Mass   &lt;<xsl:value-of select="$iupac.Mass"/>&gt; <xsl:value-of select="$bodr.Mass"/>
  Error  &lt;<xsl:value-of select="$iupac.Error"/>&gt; <xsl:value-of select="$bodr.Error"/>
		</xsl:message>
	</xsl:if>

	<xsl:if test="not($iupac.Element = $bodr.Element)
	              or not($iupac.ElementSy = $bodr.ElementSy)
	              or not($iupac.Mass = $bodr.Mass)
	              or not($iupac.Error = $bodr.Error)">
		<xsl:message terminate="no">
ERROR: We differ from the IUPAC AtWt table.
<xsl:choose>
<xsl:when test="not($iupac.Element = $bodr.Element)">
element (IUPAC): <xsl:value-of select="$iupac.Element"/>
element (BODR): <xsl:value-of select="$bodr.Element"/>
</xsl:when>
<xsl:when test="not($iupac.ElementSy = $bodr.ElementSy)">
element:  <xsl:value-of select="$iupac.Element"/>
element symbol (IUPAC): <xsl:value-of select="$iupac.ElementSy"/>
element symbol (BODR): <xsl:value-of select="$bodr.ElementSy"/>
</xsl:when>
<xsl:when test="not($iupac.Mass = $bodr.Mass)">
element:  <xsl:value-of select="$iupac.Element"/>
mass (IUPAC): <xsl:value-of select="$iupac.Mass"/>
mass (BODR): <xsl:value-of select="$bodr.Mass"/>
</xsl:when>
<xsl:when test="not($iupac.Error = $bodr.Error)">
element:  <xsl:value-of select="$iupac.Element"/>
error value (IUPAC): <xsl:value-of select="$iupac.Error"/>
error value (BODR): <xsl:value-of select="$bodr.Error"/>
</xsl:when>
<!-- Last case: We had an error, but the values were all correct??? -->
<xsl:otherwise>
Oops. This shouldn't happen. Something went wrong.
</xsl:otherwise>
</xsl:choose>

Exiting. Fix the database.
</xsl:message>
	</xsl:if>
</xsl:template>

<xsl:template match="*"/>

</xsl:stylesheet>
                
