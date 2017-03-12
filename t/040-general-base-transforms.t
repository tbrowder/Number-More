use v6;
use Test;

use Number::More :ALL;

plan 54;

my $prefix = True;
my $LC     = True;

my $base = 10;
for 10..35 -> $dec {
    ++$base;
    my $bo = $base;
    my $bi = 10;

    # use Perl 6 routines directly
    my ($tnum-in, $tnum-out);
    if $bi eq '10' {
        $tnum-in  = $dec;
        $tnum-out = $dec.base: $bo;
    }
    elsif $bo eq '10' {
        $tnum-in  = $dec.base: $bi;
        $tnum-out = $dec;
    }
    else {
        $tnum-in  = $dec.base: $bi;
        $tnum-out = $dec.base: $bo;
    }

    is rebase($tnum-in, $bi, $bo), $tnum-out, $tnum-out;
    if $bo eq '2' {
        my $out = '0b' ~ $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$prefix), $out, $out;
    }
    elsif $bo eq '8' {
        my $out = '0o' ~ $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$prefix), $out, $out;
    }
    elsif $bo eq '16' {
        my $out = '0x' ~ $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$prefix), $out, $out;
        $out = '0x' ~ lc $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$prefix, :$LC), $out, $out;
        $out = lc $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$LC), $out, $out;
    }
    elsif $bo > 10 {
        my $out = lc $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$LC), $out, $out;
    }
}
