
EXTRA_DIST = \
	$(xml_DATA)

MAINTAINERCLEANFILES = \
	Makefile.in

XMLLINT_FLAGS_XSD = --noout --schema $(top_srcdir)/schemas/cml25.xsd
XMLLINT_FLAGS_SCHEMATRON = --noout --schematron $(top_srcdir)/schemas/isotopes.schematron

xmldir = ${pkgdatadir}
xml_DATA = isotopes.xml

check-local:
if HAVE_XMLLINT
	$(XMLLINT) $(XMLLINT_FLAGS_XSD) $(srcdir)/$(xml_DATA)
	$(XMLLINT) $(XMLLINT_FLAGS_SCHEMATRON) $(srcdir)/$(xml_DATA)
else
	@echo "Warning: Cannot check the XML files because 'xmllint' is missing."
endif

