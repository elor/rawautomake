##########################################################################
# debug compilation support
##########################################################################

AC_MSG_CHECKING([whether to build with debug information])
AC_ARG_ENABLE([debug],
    [AS_HELP_STRING([--enable-debug],
        [enable debug data generation (def=no)])],
    [debugit="$enableval"],
    [debugit=no])
AC_MSG_RESULT([$debugit])

if test x"$debugit" = x"yes"; then
    AC_DEFINE([DEBUGENABLED],[],[Debug Mode])
    CXXFLAGS="$AM_CXXFLAGS -g -pedantic -Wall -Wextra -Werror -O0"
#    CXXFLAGS="$AM_CXXFLAGS -g -pedantic -Wall -Wextra -Werror -Wno-write-strings -O0"
else
    AC_DEFINE([DEBUGDISABLED],[],[No-debug Mode])
    CXXFLAGS="$AM_CXXFLAGS -O2"
fi

AC_SUBST([CXXFLAGS])
##########################################################################
