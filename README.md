[![Actions Status](https://github.com/kaz-utashiro/App-ansiexpand/workflows/test/badge.svg)](https://github.com/kaz-utashiro/App-ansiexpand/actions) [![MetaCPAN Release](https://badge.fury.io/pl/App-ansiexpand.svg)](https://metacpan.org/release/App-ansiexpand)
# NAME

ansiexpand, ansiunexpand - ANSI sequences aware tab expand/unexpand command

# SYNOPSIS

    ansiexpand [ option ] file ...

    ansiunexpand [ option ] file ...

# VERSION

Version 0.01

# DESCRIPTION

**ansiexpand** is an [expand(1)](http://man.he.net/man1/expand) compatible command utilizing
[Text::ANSI::Tabs](https://metacpan.org/pod/Text::ANSI::Tabs) module, which enables to handle ANSI terminal
sequences and Unicode wide characters.

This is a command line interface for [Text::ANSI::Tabs](https://metacpan.org/pod/Text::ANSI::Tabs) module, which
uses [Text::ANSI::Fold](https://metacpan.org/pod/Text::ANSI::Fold) module as a backend.  Consult them for
implementation detail.

# OPTIONS

- **--tabstop**=#, **-t**#

    Set tab stop width.  Unlike [expand(1)](http://man.he.net/man1/expand), takes only single value.

- **--tabhead**=_char_
- **--tabspace**=_char_

    Set tab head and following space character.  If it is longer than
    single character, it is considered as a Unicode name.

- **--tabstyle**=_style_, **--ts**=_style_

    Set tab style.  Try `--tabstyle=shade` for example.  See
    [Text::ANSI::Fold](https://metacpan.org/pod/Text::ANSI::Fold) for detail.

- **--ambiguous**=`wide`|`narrow`

    Set the width of Unicode ambiguous characters.  Default is `narrow`.

# FILES

- `~/.ansiexpandrc`, `~/.ansiunexpandrc`

    Start-up file.
    See [Getopt::EX::Module](https://metacpan.org/pod/Getopt::EX::Module) for format.

# INSTALL

## CPANMINUS

    $ cpanm App::ansiexpand
    or
    $ curl -sL http://cpanmin.us | perl - App::ansiexpand

# SEE ALSO

[App::ansiexpand](https://metacpan.org/pod/App::ansiexpand), [https://github.com/kaz-utashiro/App-ansiexpand](https://github.com/kaz-utashiro/App-ansiexpand)

[Text::ANSI::Tabs](https://github.com/kaz-utashiro/Text-ANSI-Tabs)

[Text::ANSI::Fold](https://github.com/kaz-utashiro/Text-ANSI-Fold)

# AUTHOR

Kazumasa Utashiro

# LICENSE

Copyright 2021 Kazumasa Utashiro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
