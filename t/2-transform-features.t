use v6;
use Test;

use Number::More :ALL;

$Number::More::LENGTH-HANDLING = 'waRn';

plan 27;

my $prefix = True;
my $LC     = True;

my $msg2 = ":\$LC arg not allowed for conversion to anything\
             but hexadecimal";

dies-ok  { rebase('Z', 2, 3);   }, "base-i: Z, 2, invalid base number for input";
dies-ok  { rebase('Z', 16, 37); }, "base-i: Z, 16, invalid base number for input";
lives-ok { rebase('Z', 36, 37); }, "base-i: Z, 36, valid base number for input";
lives-ok { rebase('Z', 37, 38); }, "base-i: Z, 37, valid base number for input";

# various features
is hex2dec('ff'), '255';
is hex2dec('ff', :prefix), '0d255';

is bin2dec('11'), '3';
is bin2hex('00001010', :prefix), '0xA';
is bin2hex('00001010', :LC), 'a';
is bin2hex('00001010', :LC, :prefix), '0xa';
is bin2hex('11'), '3';
is bin2hex('11', :prefix), '0x3';

is dec2hex(10), 'A';
is dec2hex(10, :LC, :prefix), '0xa';
is dec2hex(10, :prefix), '0xA';

is hex2bin('ff'), '11111111';
is hex2bin('ff', :prefix), '0b11111111';

is dec2bin(10), '1010';
is dec2bin(10, :prefix), '0b1010';

is bin2oct('111111', :prefix), '0o77';
is hex2oct('3f', :prefix), '0o77';
is dec2oct(63, :prefix), '0o77';

is oct2bin('77', :prefix), '0b111111';
is oct2hex('77', :prefix), '0x3F';
is oct2hex('77', :prefix, :$LC), '0x3f';

is rebase('Z', 36, 3, :suffix), '1022_base-3', "test suffix";
is rebase('z', 62, 3, :suffix), '2021_base-3', "test suffix";
