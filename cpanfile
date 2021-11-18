requires 'Encode';
requires 'Getopt::EX::Hashed', '1.02';
requires 'Getopt::EX::Long';
requires 'Pod::Usage';
requires 'Text::ANSI::Tabs';
requires 'perl', '5.014';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
};

on test => sub {
    requires 'Test::More', '0.98';
};
