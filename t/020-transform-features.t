use v6;
use Test;

use Number::More :ALL;

$Number::More::LENGHT-HANDLING = 'waRn';

plan 26;

my $prefix = True;
my $UC     = True;

my $msg1 = ":\$prefix arg not allowed for conversion to decimal";
my $msg2 = ":\$UC arg not allowed for conversion to anything but hexadecimal";

# error conditions
dies-ok { hex2dec('ff', :$prefix), 255; }, $msg1;
dies-ok { hex2dec('ff', 2, :$prefix), '255'; }, $msg1;
dies-ok { bin2dec('11', :$prefix), 3;}, $msg1;

# various features
is hex2dec('ff', 5), '00255';
is hex2dec('ff', 2), '255';

is bin2dec('11', 4), '0003';

is bin2hex('00001010', :$prefix), '0xa';
is bin2hex('00001010', :$UC), 'A';
is bin2hex('00001010', :$UC, :$prefix), '0xA';

is bin2hex('11', 4), '0003';
is bin2hex('11', 4, :$prefix), '0x03';

is dec2hex(10, 3), '00a';
is dec2hex(10, :$UC, :$prefix), '0xA';
is dec2hex(10, 4, :$prefix), '0x0a';

is hex2bin('ff', 11), '00011111111';
is hex2bin('ff', :$prefix), '0b11111111';
is hex2bin('ff', 11, :$prefix), '0b011111111';

is dec2bin(10, 5), '01010';
is dec2bin(10, 5, :$prefix), '0b1010';
is dec2bin(10, :$prefix), '0b1010';

# new tests, organize better later
is bin2oct('111111', :$prefix), '0o77';

is hex2oct('3f', :$prefix), '0o77';

is dec2oct(63, :$prefix), '0o77';

is oct2bin('77', :$prefix), '0b111111';

is oct2hex('77', :$prefix), '0x3f';
is oct2hex('77', :$prefix, :$UC), '0x3F';
