use v6;
use Test;

use Number::More :ALL;

plan 1360;

my $prefix = True;
my $UC     = True;

# a random set of decimal inputs
my $nrands =  1; # num loops
my $ntests =  1; # per loop
my $total-tests = $nrands * $ntests;
my @uints = ((rand * 10000).Int) xx $nrands;
for @uints -> $dec {
    for 2..36 -> $bi {
        for 2..36 -> $bo {
            # skip some here
            next if $bi eq $bo; 

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

            is baseM2baseN($tnum-in, $bi, $bo), $tnum-out;
            if $bo eq '2' {
                my $out = '0b' ~ $tnum-out;
                is baseM2baseN($tnum-in, $bi, $bo, :$prefix), $out;
            }
            elsif $bo eq '8' {
                my $out = '0o' ~ $tnum-out;
                is baseM2baseN($tnum-in, $bi, $bo, :$prefix), $out;
            }
            elsif $bo eq '16' {
                my $out = '0x' ~ $tnum-out;
                is baseM2baseN($tnum-in, $bi, $bo, :$prefix), $out;
                $out = '0x' ~ uc $tnum-out;
                is baseM2baseN($tnum-in, $bi, $bo, :$prefix, :$UC), $out;
                $out = uc $tnum-out;
                is baseM2baseN($tnum-in, $bi, $bo, :$UC), $out;
            }
        }
    }
}

