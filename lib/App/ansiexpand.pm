package App::ansiexpand;
our $VERSION = "1.05";

use 5.014;
use warnings;

use open IO => 'utf8', ':std';
use Encode;
use Pod::Usage;
use Data::Dumper;
use List::Util qw(max);
use Text::ANSI::Tabs qw(ansi_expand ansi_unexpand);

our $DEFAULT_UNEXPAND;

use Getopt::EX::Hashed 1.05; {

    Getopt::EX::Hashed->configure(DEFAULT => [ is => 'rw' ]);

    has unexpand  => ' u  !   ' , default => $DEFAULT_UNEXPAND;
    has all       => ' a      ' , default => 1;
    has zap       => ' z      ' ;
    has minimum   => ' x  :1  ' ;
    has ambiguous => '    =s  ' , any => [ qw(wide narrow) ];
    has tabstop   => ' t  =i  ' , min => 1;
    has tabhead   => '    =s  ' ;
    has tabspace  => '    =s  ' ;
    has tabstyle  => ' ts :s  ' ;
    has help      => ' h      ' ;
    has version   => ' v      ' ;

    has [ qw(+minimum +tabstop +tabhead +tabspace +tabstyle) ] => sub {
	my($name, $val) = ("$_[0]", $_[1]);
	if ($name eq 'tabstyle' and $val eq '') {
	    list_tabstyle();
	    exit;
	}
	$_->$name = $val;
	Text::ANSI::Tabs->configure($name => $val);
    };

    has '+help' => sub {
	pod2usage
	    -verbose  => 99,
	    -sections => [ qw(SYNOPSIS VERSION) ];
    };

    has '+version' => sub {
	print "Version: $VERSION\n";
	exit;
    };

    has ARGV => default => [];
    has '<>' => sub {
	if ($_[0] =~ /^-([0-9]+)$/x) {
	    $_->tabstop = $1 or die "$_[0]: invalid tabstop\n";
	    Text::ANSI::Tabs->configure(tabstop => $1);
	} else {
	    if ($_[0] =~ /^-{1,2}+(.+)/) {
		warn "Unknown option: $1\n";
		pod2usage();
	    }
	    push @{$_->ARGV}, $_[0];
	}
    };

} no Getopt::EX::Hashed;

sub run {
    my $app = shift;
    local @ARGV = map { utf8::is_utf8($_) ? $_ : decode('utf8', $_)  } @_;

    use Getopt::EX::Long qw(:DEFAULT ExConfigure Configure);
    ExConfigure BASECLASS => [ __PACKAGE__, 'Getopt::EX' ];
    Configure qw(bundling pass_through);
    $app->getopt || pod2usage();
    @ARGV = @{$app->ARGV};

    my $action = $app->unexpand ? \&ansi_unexpand : \&ansi_expand;

    local $/ = $app->zap ? undef : $/;
    while (<>) {
	print $action->($_);
    }

    return 0;
}

sub list_tabstyle {
    my %style = %Text::ANSI::Fold::TABSTYLE;
    my $max = max map length, keys %style;
    for my $name (sort keys %style) {
	my($head, $space) = @{$style{$name}};
	my $tab = $head . $space x 7;
	printf "%*s %s\n", $max, $name, $tab x 3;
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

ansiexpand, ansiunexpand - ANSI sequence aware tab expand/unexpand command

=head1 VERSION

Version 1.05

=head1 DESCRIPTION

Documentation is included in the script file.

=head1 AUTHOR

Kazumasa Utashiro

=head1 LICENSE

Copyright 2021-2024 Kazumasa Utashiro.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

