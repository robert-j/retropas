#
# This is a Makefile
#

all:  foo bar

!include $(TOPDIR)

!ifdef FOO
!   ifdef BAR   # comment
!   endif
!endif

!if _NMAKE_VER  # comment
!endif

.suffixes:  a lot $(VAR)
.silent:  yep
.silent   # must not be recognized

!if defined($(FOO)) && exist(file)
!endif
