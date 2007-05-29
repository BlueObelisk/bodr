dnl @synopsis MP_PROG_XMLLINT
dnl
dnl @summary Determine if we can use the 'xmllint' program.
dnl
dnl This is a simple macro to define the location of xmllint (which can
dnl be overridden by the user) and special options to use.
dnl
dnl @category InstalledPackages
dnl @author Daniel Leidert <daniel.leidert@wgdd.de>
dnl @version $Date$
dnl @license AllPermissive
AC_DEFUN([MP_PROG_XMLLINT],[
AC_REQUIRE([PKG_PROG_PKG_CONFIG])
AC_ARG_VAR(
	[XMLLINT],
	[The 'xmllint' binary with path. Use it to define or override the location of 'xmllint'.]
)
AC_PATH_PROG([XMLLINT], [xmllint])
if test -z $XMLLINT ; then
	AC_MSG_WARN(['xmllint' was not found. We cannot validate the XML sources.]) ;
fi
AC_SUBST([XMLLINT])
AM_CONDITIONAL([HAVE_XMLLINT], [test -n $XMLLINT])

AC_ARG_VAR(
	[XMLLINT_FLAGS],
	[More options, which should be used along with 'xmllint', like e.g. '--nonet'.]
)
AC_SUBST([XMLLINT_FLAGS])
AC_MSG_CHECKING([for optional xmllint options to use...])
AC_MSG_RESULT([$XMLLINT_FLAGS])
]) # MP_PROG_XMLLINT


dnl @synopsis MP_PROG_XSLTPROC
dnl
dnl @summary Determine if we can use the 'xsltproc' program.
dnl
dnl This is a simple macro to define the location of xsltproc (which can
dnl be overridden by the user) and special options to use.
dnl
dnl @category InstalledPackages
dnl @author Daniel Leidert <daniel.leidert@wgdd.de>
dnl @version $Date$
dnl @license AllPermissive
AC_DEFUN([MP_PROG_XSLTPROC],[
AC_ARG_VAR(
	[XSLTPROC],
	[The 'xsltproc' binary with path. Use it to define or override the location of 'xsltproc'.]
)
AC_PATH_PROG([XSLTPROC], [xsltproc])
if test -z $XSLTPROC ; then
	AC_MSG_WARN(['xsltproc' was not found! You will not be able to update the manpage.]) ;
fi
AC_SUBST([XSLTPROC])
AM_CONDITIONAL([HAVE_XSLTPROC], [test -n $XSLTPROC])

AC_ARG_VAR(
	[XSLTPROC_FLAGS],
	[More options, which should be used along with 'xsltproc', like e.g. '--nonet'.]
)
AC_SUBST([XSLTPROC_FLAGS])
AC_MSG_CHECKING([for optional xsltproc options to use...])
AC_MSG_RESULT([$XSLTPROC_FLAGS])
]) # MP_PROG_XSLTPROC

