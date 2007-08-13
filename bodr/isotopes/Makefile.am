
EXTRA_DIST = \
	$(isotopes_SRCS) \
	$(xml_DATA)

MAINTAINERCLEANFILES = \
	Makefile.in

XMLLINT_FLAGS_XSD = --noout --schema $(top_srcdir)/schemas/cml23.xsd
XMLLINT_FLAGS_SCHEMATRON = --noout --schematron $(top_srcdir)/schemas/isotopes.schematron

isotopes_SRCS = \
	abundances.txt \
	decay.txt \
	halflife.txt \
	isotopes.txt \
	magmoment.txt \
	spin.txt


vpath %.pl $(top_srcdir)/scripts


xmldir = ${pkgdatadir}
xml_DATA = isotopes.xml


isotopes.xml : isotopes.pl $(isotopes_SRCS)
	 $< > $@


check-local:
if HAVE_XMLLINT
	$(XMLLINT) $(XMLLINT_FLAGS_XSD) $(srcdir)/$(xml_DATA)
	$(XMLLINT) $(XMLLINT_FLAGS_SCHEMATRON) $(srcdir)/$(xml_DATA)
else
	@echo "Warning: Cannot check the XML files because 'xmllint' is missing."
endif

