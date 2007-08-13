<?xml version="1.0"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
                xmlns:bibtex="http://bibtexml.sf.net/"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="xml"
              indent="yes"
              doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
              media-type="application/xhtml+xml"/>

  <xsl:include href="extended.xsl"/>
  <xsl:include href="harvard-helper.xsl"/>
  <xsl:include href="html-common.xsl"/>


  <xsl:template match="bibtex:entry" name="bibtex-entry">
    <p>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:apply-templates />
      <xsl:apply-templates select="*/bibtex:doi|*/bibtex:isbn|*/bibtex:issn|
                                   */bibtex:lccn|*/bibtex:url" />
      <xsl:apply-templates select="*/bibtex:pages"/>
      <xsl:text>.</xsl:text>
    </p>
  </xsl:template>

  <xsl:template match="bibtex:book|bibtex:booklet|bibtex:proceedings">
    <!--
        Berkman, R. I. 1994, Find It Fast: How to Uncover Expert
        Information on Any Subject, HarperPerennial, New York.

        Moir, A. & Jessel, D. 1991, Brain Sex: The Real Difference
        Between Men and Women, Mandarin, London.

        Cheek, J., Doskatsch, I., Hill, P. & Walsh, L. 1995, Finding
        Out : Information Literacy For the 21st century, MacMillan
        Education Australia, South Melbourne.

        Robinson, W. F. & Huxtable, C. R. R. (eds) 1988,
        Clinicopathologic Principles For Veterinary Medicine,
        Cambridge University Press, Cambridge.

        Sjostrand, S. (ed.) 1993, Institutional Change: Theory and
        Empirical Findings, M.E. Sharpe, Armonk, N.Y.

        Australian Government Publishing Service 1994, Style Manual
        For Authors, Editors and Printers, 5th edn, AGPS, Canberra.

        McTaggart, D., Findlay, C. & Parkin, M. 1995, Economics, 2nd
        edn, Addison-Wesley, Sydney.
    -->
    <xsl:call-template name="author"/>
    <xsl:apply-templates select="bibtex:chapter"/>
    <em>
      <xsl:apply-templates select="bibtex:title"/>
    </em>
    <xsl:call-template name="publisher"/>
  </xsl:template>

  <xsl:template match="bibtex:inbook">
    <!--
        Bernstein, D. 1995, 'Transportation planning' in The Civil
        Engineering Handbook, ed. W.F.Chen, CRC Press, Boca Raton.
    -->
    <xsl:choose>
      <xsl:when test="bibtex:chapter/bibtex:author">
        <xsl:apply-templates select="bibtex:chapter/bibtex:author"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="bibtex:year"/>
        <xsl:text>, </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="author"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="bibtex:chapter"/>
    <em>
      <xsl:apply-templates select="bibtex:title"/>
    </em>
    <xsl:if test="bibtex:chapter/bibtex:author">
      <xsl:text>, </xsl:text>
      <xsl:apply-templates select="bibtex:editor|bibtex:author"/>
    </xsl:if>
    <xsl:call-template name="publisher"/>
  </xsl:template>

  <xsl:template match="bibtex:article">
    <!--
        Huffman, L. M. 1996, 'Processing whey protein for use as a
        food ingredient', Food Technology, vol. 50, no. 2, pp. 49-52.

        Bohrer, S., Zielke, T. & Freiburg, V. 1995, `Integrated
        obstacle detection framework for intelligent cruise control on
        motorways', IEEE Intelligent Vehicles Symposium, Detroit, MI,
        Piscataway, pp. 276-281.

        Simpson, L. 1997, `Tasmania's railway goes private`,
        Australian Financial Review, 13 Oct., p. 10.

        Weibel, S. 1995, `Metadata : the foundations of resource
        description', D-lib Magazine, [Online] Available at:
        http://www.dlib.org/dlib/July95/07weibel.html

        ASTEC 1994, The Networked Nation, Available at:
        http://astec.gov.au/astec/net_nation/contents.html
    -->
    <xsl:call-template name="author"/>
    <xsl:text>'</xsl:text>
      <xsl:apply-templates select="bibtex:title"/>
    <xsl:text>' in </xsl:text>
    <em>
      <xsl:apply-templates select="bibtex:journal"/>
    </em>
    <xsl:apply-templates select="bibtex:volume"/>
    <xsl:apply-templates select="bibtex:number"/>
  </xsl:template>

  <xsl:template match="bibtex:incollection|
                       bibtex:inproceedings|bibtex:conference">
    <!--
        Simons, R. C. 1996, Boo!: Culture, Experience and the Startle
        Reflex, Series in Affective Science, Oxford University Press,
        New York.

        Bohrer, S., Zielke, T. & Freiburg, V. 1995, `Integrated
        obstacle detection framework for intelligent cruise control on
        motorways', IEEE Intelligent Vehicles Symposium, Detroit, MI,
        Piscataway, pp. 276-281.
    -->
    <xsl:call-template name="author"/>
    <xsl:text>'</xsl:text>
      <xsl:apply-templates select="bibtex:title"/>
    <xsl:text>' in </xsl:text>
    <em>
      <xsl:apply-templates select="bibtex:booktitle"/>
    </em>
    <xsl:call-template name="publisher"/>
  </xsl:template>

  <xsl:template match="bibtex:manual|bibtex:techreport|
                       bibtex:mastersthesis|bibtex:phdthesis|
                       bibtex:unpublished|bibtex:misc">
    <xsl:call-template name="author"/>
    <em>
      <xsl:apply-templates select="bibtex:title"/>
    </em>
    <xsl:apply-templates select="bibtex:edition"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select='substring-after(name(.),"bibtex:")'/>
    <xsl:apply-templates select="bibtex:publisher|bibtex:organization|
                                 bibtex:institution"/>
  </xsl:template>

</xsl:stylesheet>
