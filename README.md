-*- text -*-

c4sh, configure for shell

c4sh is a preprocessor and M4 macro library for the
generation of target-specific shell scripts. Shells in circulation
today use differing syntax to achieve largely the same task,
exporting variables into the environment, performing arithmetic,
control flow expressions, handling whitespace, just to name a few.

Many try to make their shell script POSIX compliant, but this is not
sufficient to cover the csh family. Some argue that only compliant shells
such as bash and zsh should be considered for modern scripting, but
many companies use tools which mandate the use of a different shell.
