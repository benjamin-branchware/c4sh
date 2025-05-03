divert(-1)dnl
m4_ifndef(`TARGET_SHELL', `define(`TARGET_SHELL', `sh')')dnl Define a default if not set

define(`_CHECK_SHELL_TYPE', `ifelse(TARGET_SHELL, `sh', `bourne',
                                    TARGET_SHELL, `bash', `bourne',
                                    TARGET_SHELL, `ksh', `bourne',
                                    TARGET_SHELL, `zsh', `bourne',
                                    TARGET_SHELL, `csh', `c',
                                    TARGET_SHELL, `tcsh', `c',
                                    TARGET_SHELL, `fish', `fish',
                                    `unknown')')dnl

define(`_SHEBANG', `ifelse(TARGET_SHELL, `sh', `#!/bin/sh',
                           TARGET_SHELL, `bash', `#!/bin/bash',
                           TARGET_SHELL, `ksh', `#!/bin/ksh',
                           TARGET_SHELL, `zsh', `#!/bin/zsh',
                           TARGET_SHELL, `csh', `#!/bin/csh',
                           TARGET_SHELL, `tcsh', `#!/bin/tcsh',
                           TARGET_SHELL, `fish', `#!/bin/fish',
                           `#!/bin/false')')dnl

define(`_EXPORT', `ifelse(_CHECK_SHELL_TYPE, `bourne', `export $1='$2'`,
                          _CHECK_SHELL_TYPE, `c', `setenv $1 '$2'`,
                          _CHECK_SHELL_TYPE, `fish', `set -x $1 '$2'`,
                          `m4exit(1)')')dnl

define(`_IF', `ifelse(_CHECK_SHELL_TYPE, `bourne',
`if $1; then
  $2
ifelse(`$3', `', `', `else
  $3
')fi',
                         _CHECK_SHELL_TYPE, `c',
`if $1 then
  $2
ifelse(`$3', `', `', `else
  $3
')endif',
                          _CHECK_SHELL_TYPE, `fish',
`if $1
  $2
ifelse(`$3', `', `', `else
  $3
')end',
                        `m4exit(1)')')dnl

dnl ==============================================
dnl Generic Error Handler for Comparison Macros
dnl ==============================================
define(`_M4_COMPARE_ERROR', `errprint(`Error: (',TARGET_SHELL,`) Unsupported target shell for M4 comparison macro $1.'
)m4exit(1)')dnl

dnl ==============================================
dnl Portable Comparison Macros
dnl ==============================================

dnl String Equality: STR_EQ(string1, string2)
define(`_STR_EQ', `ifelse(_CHECK_SHELL_TYPE, `bourne', `$1 = $2',
                          _CHECK_SHELL_TYPE, `c', `$1 == $2',
                          `_M4_COMPARE_ERROR(`STR_EQ')')')dnl

define(`_TEST', `ifelse(_CHECK_SHELL_TYPE(), `bourne', `[ $1 ]',
                        _CHECK_SHELL_TYPE(), `c', `( $1 )',
                        `errprint(`ERROR: Unknown TARGET_SHELL for _TEST.'
)m4exit(1)')')dnl

divert(0)dnl
