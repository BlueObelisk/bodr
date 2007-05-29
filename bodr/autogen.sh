#!/bin/sh

## all initial declarations, overwrite them using e.g. 'ACLOCAL=aclocal-1.7 AUTOMAKE=automake-1.7 ./autogen.sh'
ACLOCAL=${ACLOCAL:-aclocal}
AUTOCONF=${AUTOCONF:-autoconf}
AUTOMAKE=${AUTOMAKE:-automake}
#INTLTOOLIZE=${INTLTOOLIZE:-intltoolize}

## check, if all binaries exist and fail with error 1 if not
if [ -z `which $ACLOCAL` ] ; then echo "Error. ACLOCAL=$ACLOCAL not found." >&2 && exit 1 ; fi
if [ -z `which $AUTOCONF` ] ; then echo "Error. AUTOCONF=$AUTOCONF not found." >&2 && exit 1 ; fi
if [ -z `which $AUTOMAKE` ] ; then echo "Error. AUTOMAKE=$AUTOMAKE not found." >&2 && exit 1 ; fi
#if [ -z `which $INTLTOOLIZE` ] ; then echo "Error. INTLTOOLIZE=$INTLTOOLIZE not found." >&2 && exit 1 ; fi

## find where automake is installed and get the version
AUTOMAKE_PATH=${AUTOMAKE_PATH:-`which $AUTOMAKE | sed 's|\/bin\/automake.*||'`}
AUTOMAKE_VERSION=`$AUTOMAKE --version | grep automake | awk '{print $4}' | awk -F. '{print $1"."$2}'`

## automake files we need to have inside our source
if [ $AUTOMAKE_VERSION = "1.7" ] ; then
        AUTOMAKE_FILES="missing mkinstalldirs install-sh"
else
        AUTOMAKE_FILES="missing install-sh"
fi

## our help output - if autogen.sh was called with -h|--help or unkbown option
autogen_help() {
	echo
	echo "./autogen.sh: Produces all files necessary to build the bodr project files."
	echo "              The files are linked by default, if you run it without an option."
	echo
	echo "    -v        Be more verbose about every step (debugging)."
	echo "    -f FILE   Output everything to FILE (debugging). Useful for debug output."
	echo "    -c        Copy files instead to link them."
	echo "    -h        Print this message."
	echo
	echo "  You can overwrite the automatically determined location of aclocal (>= 1.7),"
	echo "  automake (>= 1.7), autoconf using:"
	echo
	echo "    ACLOCAL=/foo/bin/aclocal-1.8 AUTOMAKE=automake-1.8 ./autogen.sh"
	echo
}

## check if $AUTOMAKE_FILES were copied to our source
## link/copy them if not - necessary for e.g. gettext, which seems to always need mkinstalldirs
autogen_if_missing() {
	for file in $AUTOMAKE_FILES ; do
		if [ ! -e "$file" ] ; then
			if [ -n "$VERBOSE" ]; then
				echo "DEBUG: $COPYACTION -f $AUTOMAKE_PATH/share/automake-$AUTOMAKE_VERSION/$file ." >&2
			fi
			$COPYACTION -f $AUTOMAKE_PATH/share/automake-$AUTOMAKE_VERSION/$file .
		fi
	done
}

## link/copy the necessary files to our source to prepare for a build
autogen() {
	#$INTLTOOLIZE $DEBUG -f $COPYOPTION
	$ACLOCAL $VERBOSE
	$AUTOMAKE --gnu -a $VERBOSE $COPYOPTION
	autogen_if_missing
	$AUTOCONF $DEBUG $VERBOSE
}

## the main function
COPYACTION="ln -s"
while getopts "chvf:" options; do
	case "$options" in
		h)
			autogen_help
			exit 0
		;;
		c)
			COPYACTION="cp"
			COPYOPTION="-c"
		;;
		f)
			OUTPUTFILE=$OPTARG
		;;
		v)
			DEBUG="--debug"
			VERBOSE="--verbose"
		;;
	esac
done

if [ -n "$OUTPUTFILE" ]; then
	exec &>$OUTPUTFILE
fi
autogen

## ready to rumble
echo "Run ./configure with the appropriate options, then make and enjoy."

exit 0

