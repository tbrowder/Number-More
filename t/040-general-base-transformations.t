use v6;
use Test;

use Number::More :ALL;

plan 49;

my $prefix = True;
my $UC     = True;

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

    $tnum-out .= lc if $bo > 15; # default for our code, default for Perl 6 routine is upper case

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
        $out = '0x' ~ uc $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$prefix, :$UC), $out, $out;
        $out = uc $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$UC), $out, $out;
    }
    elsif $bo > 16 {
        my $out = uc $tnum-out;
        is rebase($tnum-in, $bi, $bo, :$UC), $out, $out;
    }
}

