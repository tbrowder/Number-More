use Test;

use Number::More :ALL;

$Number::LENGTH-HANDLING = 'waRn';

my $msg0 = "valid base number for input";
my $msg1 = "invalid base number for input";

# error conditions
dies-ok  { rebase('Z', 2, 3);   }, "base-i: Z, 2, $msg1";
dies-ok  { rebase('Z', 16, 37); }, "base-i: Z, 16, $msg1";
dies-ok { rebase('Z', 2, 3), 2; }, "invalid base number for input";
dies-ok { rebase('Z', 16, 37), 2; }, "invalid base number for input";

dies-ok { bin2oct('1', 2); }, "too many input variables";
dies-ok { bin2dec('1', 2); }, "too many input variables";
dies-ok { bin2hex('1', 2); }, "too many input variables";

dies-ok { oct2bin('1', 2); }, "too many input variables";
dies-ok { oct2dec('1', 2); }, "too many input variables";
dies-ok { oct2hex('1', 2); }, "too many input variables";

dies-ok { dec2bin('1', 2); }, "too many input variables";
dies-ok { dec2oct('1', 2); }, "too many input variables";
dies-ok { dec2hex('1', 2); }, "too many input variables";

dies-ok { hex2bin('ff', 2); }, "too many input variables";
dies-ok { hex2oct('ff', 2); }, "too many input variables";
dies-ok { hex2dec('ff', 2); }, "too many input variables";

lives-ok { rebase('Z', 36, 37); }, "base-i: Z, 36, valid base number for input";
lives-ok { rebase('Z', 37, 38); }, "base-i: Z, 37, valid base number for input";

lives-ok { bin2dec('11', :prefix), 3; }, $msg1;
lives-ok { rebase('Z', 36, 3), 2; }, "valid base number for input";

lives-ok { rebase('Z', 37, 3), 2; }, "valid base number for input";

# various features

is hex2dec('ff', :length(2)), '255';


is bin2hex('00001010', :prefix), '0xA';

is bin2hex('00001010', :LC), 'a';
is bin2hex('00001010', :LC, :prefix), '0xa';
is dec2hex(10, :LC, :prefix), '0xa';
is hex2bin('ff', :prefix), '0b11111111';
is dec2bin(10, :length(5), :prefix), '0b1010';
is dec2bin(10, :prefix), '0b1010';
is bin2oct('111111', :prefix), '0o77';
is hex2oct('3f', :prefix), '0o77';
is dec2oct(63, :prefix), '0o77';
is oct2bin('77', :prefix), '0b111111';
is oct2hex('77', :prefix), '0x3F';
is oct2hex('77', :prefix, :LC), '0x3f';

is rebase('Z', 36, 3, :suffix), '1022_base-3', "test suffix";
is rebase('z', 62, 3, :suffix), '2021_base-3', "test suffix";

# failing tests
#is hex2dec('ff', :length(5)), '00255';
#is hex2bin('ff', :length(11)), '00011111111';
#is hex2bin('ff', :length(11), :prefix), '0b011111111';

#is bin2dec('11', :length(4)), '0003';
#is bin2hex('11', :length(4)), '0003';
#is bin2hex('11', :length(4), :prefix), '0x03';

#is dec2hex(10, :length(3)), '00A';
#is dec2hex(10, :length(4), :prefix), '0x0A';
#is dec2bin(10, :length(5)), '01010';

done-testing;
