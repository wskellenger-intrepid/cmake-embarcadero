
set(_compiler_id_pp_test "defined(__BORLANDC__) && defined(__CODEGEARC_VERSION__) && (__clang_major__ < 15)")

set(_compiler_id_version_compute "
# define @PREFIX@COMPILER_VERSION_MAJOR @MACRO_HEX@(__CODEGEARC_VERSION__>>24 & 0x00FF)
# define @PREFIX@COMPILER_VERSION_MINOR @MACRO_HEX@(__CODEGEARC_VERSION__>>16 & 0x00FF)
# define @PREFIX@COMPILER_VERSION_PATCH @MACRO_DEC@(__CODEGEARC_VERSION__     & 0xFFFF)")
