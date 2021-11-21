requires 'Encode';
requires 'Getopt::EX::Hashed', '1.03';
requires 'Getopt::EX::Long';
requires 'Pod::Usage';
requires 'Text::ANSI::Tabs', '0.07';
requires 'perl', '5.014';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
};

on test => sub {
    requires 'Test::More', '0.98';
    requires 'Text::ParseWords';
};