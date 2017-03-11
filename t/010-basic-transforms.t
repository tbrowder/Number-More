use v6;
use Test;

use Number::More :ALL;

$Number::More::LENGHT-HANDLING = 'waRn';

plan 128;

my $prefix = True;
my $UC     = True;

my $msg1 = ":\$prefix arg not allowed for conversion to decimal";
my $msg2 = ":\$UC arg not allowed for conversion to anything but hexadecimal";

# error conditions
dies-ok { hex2dec('ff', :$prefix), 255; }, $msg1;
dies-ok { hex2dec('ff', 2, :$prefix), '255'; }, $msg1;
dies-ok { bin2dec('11', :$prefix), 3;}, $msg1;

# base conversions
is hex2dec('ff'), 255;


is hex2dec('ff', 5), '00255';
is hex2dec('ff', 2), '255';

is bin2dec('11'), 3;
is bin2dec('11', 4), '0003';

is bin2hex('00001010'), 'a';

is bin2hex('00001010', :$prefix), '0xa';
is bin2hex('00001010', :$UC), 'A';
is bin2hex('00001010', :$UC, :$prefix), '0xA';

is bin2hex('11', 4), '0003';
is bin2hex('11', 4, :$prefix), '0x03';

is dec2hex(10), 'a';
is dec2hex(10, 3), '00a';
is dec2hex(10, :$UC, :$prefix), '0xA';
is dec2hex(10, 4, :$prefix), '0x0a';

is hex2bin('ff'), '11111111';
is hex2bin('ff', 11), '00011111111';
is hex2bin('ff', :$prefix), '0b11111111';
is hex2bin('ff', 11, :$prefix), '0b011111111';

is dec2bin(10), '1010';
is dec2bin(10, 5), '01010';
is dec2bin(10, 5, :$prefix), '0b1010';
is dec2bin(10, :$prefix), '0b1010';

# new tests, organize better later
is bin2oct('111111'), '77';
is bin2oct('111111', :$prefix), '0o77';

is hex2oct('3f'), '77';
is hex2oct('3f', :$prefix), '0o77';

is dec2oct(63), '77';
is dec2oct(63, :$prefix), '0o77';

is oct2bin('77'), '111111';
is oct2bin('77', :$prefix), '0b111111';

is oct2hex('77'), '3f';
is oct2hex('77', :$prefix), '0x3f';
is oct2hex('77', :$prefix, :$UC), '0x3F';

is oct2dec('77'), '63';

# a random set of decimal inputs
my $nrand = 5;
my @uints = ((rand * 10000).Int) xx $nrand;
for @uints -> $dec {
    my $bin  = $dec.base: 2;
    my $oct  = $dec.base: 8;
    my $hex  = $dec.base: 16; # alpha chars are upper case
    my $hex2 = lc $hex;       # a lower-case version

    # the tests
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

