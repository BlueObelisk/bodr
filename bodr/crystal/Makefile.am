
EXTRA_DIST = \
	$(spacegroups_BIBXML) \
	$(xml_DATA)

CLEANFILES = \
	*_biblio.bxml \
	*_biblio.html

MAINTAINERCLEANFILES = \
	Makefile.in


spacegroups_BIBXML = \
	space-groups.bibxml

vpath %.xsl $(top_srcdir)/bibtexml-xslt


SUFFIXES = .html .bxml


space-groups_biblio.bxml : $(spacegroups_BIBXML)
	echo "<bx:file xmlns:bx='http://bibtexml.sf.net/'>" > $@
	cat $^ >> $@
	echo "</bx:file>" >> $@

.bxml.html:
	$(XSLTPROC) $(XSLTPROC_FLAGS) $(top_srcdir)/bibtexml-xslt/html-harvard.xsl $< > $@


xmldir = ${pkgdatadir}
xml_DATA = space-groups.xml

docsdir = ${docdir}/biblio
docs_DATA = space-groups_biblio.html

