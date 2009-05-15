
SUBDIRS = bibtexml-xslt dicts crystal elements isotopes schemas scripts tests

AUTOMAKE_OPTIONS = dist-bzip2

DISTCLEANFILES = \
	$(pkgconfig_DATA) \
	intltool-extract \
	intltool-merge \
	intltool-update

MAINTAINERCLEANFILES = \
	aclocal.m4 \
	configure \
	config.guess \
	config.sub \
	install-sh \
	intltool-extract.in \
	intltool-merge.in \
	intltool-update.in \
	missing \
	mkinstalldirs \
	Makefile.in

# if the generated archives should be removed too, add the following
# filename to the maintainer-clean target too:
# @PACKAGE@-@VERSION@.tar.{bz2,gz}


docsdir = ${docdir}
docs_DATA = AUTHORS THANKS ChangeLog COPYING README

pkgconfigdir = ${datadir}/pkgconfig
pkgconfig_DATA = bodr.pc
