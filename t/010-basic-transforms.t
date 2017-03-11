use v6;
use Test;

use Number::More :ALL;

plan 180;

my $UC = True;

# a random set of decimal inputs
my $nrands = 10; # num loops
my $ntests = 18; # per loop
my $total-tests = $nrands * $ntests;
my @uints = ((rand * 10000).Int) xx $nrands;
for @uints -> $dec {
    my $bin  = $dec.base: 2;
    my $oct  = $dec.base: 8;
    my $hex  = $dec.base: 16; # alpha chars are upper case
    my $hex2 = lc $hex;       # a lower-case version

    # the tests 18
    is bin2oct($bin), $oct;
    is bin2dec($bin), $dec;
    is bin2hex($bin), $hex2;
    is bin2hex($bin, :$UC), $hex;

    is oct2bin($oct), $bin;
    is oct2dec($oct), $dec;
    is oct2hex($oct), $hex2;
    is oct2hex($oct, :$UC), $hex;

    is dec2bin($dec), $bin;
    is dec2oct($dec), $oct;
    is dec2hex($dec), $hex2;
    is dec2hex($dec, :$UC), $hex;

    is hex2bin($hex), $bin;
    is hex2oct($hex), $oct;
    is hex2dec($hex), $dec;

    is hex2bin($hex2), $bin;
    is hex2oct($hex2), $oct;
    is hex2dec($hex2), $dec;
}
