
EXTRA_DIST = \
	$(crystalstructures_BIBXML) \
	$(elements_BIBXML) \
	$(crystal_DATA) \
	$(element_DATA)

CLEANFILES = \
	*_biblio.bxml \
	*_biblio.html

MAINTAINERCLEANFILES = \
	Makefile.in

XMLLINT_FLAGS_XSD = --noout --schema $(top_srcdir)/schemas/cml25.xsd
XMLLINT_FLAGS_SCHEMATRON = --noout --schematron $(top_srcdir)/schemas/elements.schematron

crystalstructures_BIBXML = \
	crystalstructures.bibxml

elements_BIBXML = \
	boilingpoint.bibxml \
	crystalstructures.bibxml \
	dates.bibxml \
	electron-affinity.bibxml \
	electroneg-pauling.bibxml \
	electronic-configuration.bibxml \
	exact-masses.bibxml \
	ionization.bibxml \
	mass.bibxml \
	meltingpoint.bibxml \
	names.bibxml \
	radii-covalent.bibxml \
	radii-vdw.bibxml \
	symbols.bibxml


vpath %.pl  $(top_srcdir)/scripts
vpath %.rb  $(top_srcdir)/scripts
vpath %.xsl $(top_srcdir)/bibtexml-xslt


SUFFIXES = .html .bxml


crystaldir = ${pkgdatadir}
crystal_DATA = crystalstructures.xml

elementdir = ${pkgdatadir}
element_DATA = elements.xml

docsdir = ${docdir}/biblio
docs_DATA = elements_biblio.html crystalstructures_biblio.html

crystalstructures_biblio.bxml : $(crystalstructures_BIBXML)
	echo "<bx:file xmlns:bx='http://bibtexml.sf.net/'>" > $@
	cat $^ >> $@
	echo "</bx:file>" >> $@

elements_biblio.bxml : $(elements_BIBXML)
	echo "<bx:file xmlns:bx='http://bibtexml.sf.net/'>" > $@
	cat $^ >> $@
	echo "</bx:file>" >> $@

.bxml.html:
	$(XSLTPROC) $(XSLTPROC_FLAGS) $(top_srcdir)/bibtexml-xslt/html-harvard.xsl $< > $@


check-local:
if HAVE_XMLLINT
	$(XMLLINT) $(XMLLINT_FLAGS_XSD) $(srcdir)/$(crystal_DATA)
	$(XMLLINT) $(XMLLINT_FLAGS_SCHEMATRON) $(srcdir)/$(element_DATA)
else
	@echo "Warning: Cannot check the XML files because 'xmllint' is missing."
endif

