
EXTRA_DIST = \
	$(isotopes_BIBXML) \
	$(xml_DATA)

CLEANFILES = \
	*_biblio.bxml \
	*_biblio.html

MAINTAINERCLEANFILES = \
	Makefile.in

XMLLINT_FLAGS_XSD = --noout --schema $(top_srcdir)/schemas/cml25.xsd
XMLLINT_FLAGS_SCHEMATRON = --noout --schematron $(top_srcdir)/schemas/isotopes.schematron

vpath %.xsl $(top_srcdir)/bibtexml-xslt

SUFFIXES = .html .bxml

docsdir = ${docdir}/biblio
docs_DATA = isotopes_biblio.html

isotopes_BIBXML = \
	isotopes.bibxml

xmldir = ${pkgdatadir}
xml_DATA = isotopes.xml

isotopes_biblio.bxml : $(isotopes_BIBXML)
	echo "<bx:file xmlns:bx='http://bibtexml.sf.net/'>" > $@
	cat $^ >> $@
	echo "</bx:file>" >> $@

.bxml.html:
	$(XSLTPROC) $(XSLTPROC_FLAGS) $(top_srcdir)/bibtexml-xslt/html-harvard.xsl $< > $@

check-local:
if HAVE_XMLLINT
	$(XMLLINT) $(XMLLINT_FLAGS_XSD) $(srcdir)/$(xml_DATA)
	$(XMLLINT) $(XMLLINT_FLAGS_SCHEMATRON) $(srcdir)/$(xml_DATA)
else
	@echo "Warning: Cannot check the XML files because 'xmllint' is missing."
endif

