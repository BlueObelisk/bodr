
EXTRA_DIST = AtWt.xsl

MAINTAINERCLEANFILES = Makefile.in

VPATH += $(srcdir)
VPATH += $(top_srcdir)/elements/

XSLTPROC_FLAGS += --path "$(VPATH)"

check-local:
	$(XSLTPROC) $(XSLTPROC_FLAGS) --html $(srcdir)/AtWt.xsl http://www.chem.qmul.ac.uk/iupac/AtWt/
