AC_INIT([bodr],[10],[http://www.blueobelisk.org/])
AM_INIT_AUTOMAKE([-Wall])

AC_PROG_INSTALL
#AC_PROG_INTLTOOL

# ALL_LINGUAS="de nl"
# AC_SUBST(ALL_LINGUAS)
# AM_GLIB_GNU_GETTEXT
# GETTEXT_PACKAGE=AC_PACKAGE_NAME
# AC_SUBST(GETTEXT_PACKAGE)
# AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE, "$GETTEXT_PACKAGE",[Package name for internationalization])

# AC_PATH_PROG(PKG_CONFIG, pkg-config, "no")  
# AC_SUBST(PKG_CONFIG)

MP_PROG_XMLLINT
MP_PROG_XSLTPROC
if test -z $XSLTPROC ; then
	AC_MSG_ERROR([Missing xsltproc!]) ;
fi
AC_PATH_PROG([PERL], [perl])
if test -z $PERL ; then
	AC_MSG_WARN([Missing Perl could prevent distributed perl scripts from running!]) ;
fi
PERL_MODULES="diagnostics"
dnl The scripts further use XML::Tidy, XML::Simple, Data::Dumper
for MODULE in $PERL_MODULES; do
	AC_MSG_CHECKING(for Perl module $MODULE)
	$PERL "-M$MODULE" -e exit > /dev/null 2>&1
	if test $? -ne 0; then
		AC_MSG_RESULT(missing);
		AC_MSG_ERROR(The Perl module $MODULE could not be found.)
	else
		AC_MSG_RESULT(found);
	fi
done


if test "$prefix" = "NONE"; then
        prefix=/usr/local
fi

if test -z "$docdir" ; then
	AC_SUBST(
		[docdir],
		[${datadir}'/doc/${PACKAGE}']
	)
fi

AC_CONFIG_FILES([
	bodr.pc
	Makefile
	bibtexml-xslt/Makefile
	dicts/Makefile
	crystal/Makefile
	elements/Makefile
	isotopes/Makefile
	schemas/Makefile
	scripts/Makefile
	tests/Makefile
])
AC_OUTPUT
