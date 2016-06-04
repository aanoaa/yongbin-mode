package Yongbinize;

use strict;
use warnings;
use Lingua::KO::Hangul::Util qw/decomposeSyllable composeSyllable/;

require Exporter;

our @ISA    = qw/Exporter/;
our @EXPORT = qw/yongbinize/;

## JUNGSEONG: 0x1161 .. 0x1175
## [0x1162] : ᅢ
## [0x1166] : ᅦ
my %AE_E_MAP = ( 0x1162 => 0x1166, 0x1166 => 0x1162 );

sub yongbinize {
    my $text = shift;
    return '' unless $text;

    my @chars = split //, $text;
    my @new_chars;
    for my $char (@chars) {
        my @jamo = split //, decomposeSyllable($char);
        for (@jamo) {
            my $code = unpack 'U*', $_;
            $code = $AE_E_MAP{$code} if $AE_E_MAP{$code};
            $_ = pack 'U*', $code;
        }

        push @new_chars, composeSyllable( join '', @jamo );
    }

    return join '', @new_chars;
}

=encoding utf8

=head1 NAME

Yongbinize - swap `ㅔ` and `ㅐ`

=head1 SYNOPSIS

    use Yongbinize;
    print yongbinize('안녕하세요');    # 안녕하새요

=head1 COPYRIGHT

The MIT License (MIT)

Copyright (c) 2016 Hyungsuk Hong

=cut

1;
