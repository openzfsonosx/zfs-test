dnl #
dnl # Detect Linux (or not)
dnl #
AC_DEFUN([ZFS_AC_SYSTEM], [
	AC_MSG_CHECKING([if OS is Linux])
	_uname=$(uname -o)
	AS_IF([test "${_uname}" = "GNU/Linux"], [
			LINUX="yes"

			ZONENAME="echo global"
			AC_SUBST(ZONENAME)
		])
	AC_MSG_RESULT([$LINUX])

	AC_SUBST(LINUX)
])
