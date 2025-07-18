
set(_compiler_id_pp_test "defined(__BORLANDC__) && (__clang_major__ < 15)")

set(_compiler_id_version_compute "
  /* __BORLANDC__ = 0xVRR */
# define @PREFIX@COMPILER_VERSION_MAJOR @MACRO_HEX@(__BORLANDC__>>8)
# define @PREFIX@COMPILER_VERSION_MINOR @MACRO_HEX@(__BORLANDC__ & 0xFF)")
