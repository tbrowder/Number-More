use Test;

my \BIN = 2;
my \OCT = 8;
my \DEC = 10;
my \HEX = 16;

use Number::More :ALL;

$Number::More::LENGTH-HANDLING = 'waRn';

#plan 27;

my $prefix = True;
my $LC     = True;

dies-ok  { rebase('Z', 2, 3);   }, "base-i: Z, 2, invalid base number for input";
dies-ok  { rebase('Z', 16, 37); }, "base-i: Z, 16, invalid base number for input";
lives-ok { rebase('Z', 36, 37); }, "base-i: Z, 36, valid base number for input";
lives-ok { rebase('Z', 37, 38); }, "base-i: Z, 37, valid base number for input";

# various features
dies-ok { hex2bin('ff', :prefix, :suffix) }, "cannot have ':prefix' and ':suffix'";
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

is rebase('Z', 36, 3, :suffix), "1022\x2083", "test suffix";
is rebase('z', 62, 3, :suffix), "2021\x2083", "test suffix";

my @bases-i = 2..62;
my @bases-o = @bases-i.reverse;

for @bases-i -> $bi {
    BASE-OUT: for @bases-o -> $bo {

        my $num = "1";
        my $length = 4;
        my $r;
        if $bi == BIN {
            if $bo == BIN {
                $r = bin2bin $num;
                is $r, $num;
                $r = bin2bin $num, :prefix;
                is $r, "0b1";

                $r = bin2bin $num, :prefix, :$length;
                is $r, "0b01";
            }
            elsif $bo == OCT {
                $r = bin2oct $num;
                is $r, $num;
                $r = bin2oct $num, :prefix;
                is $r, "0o1";

                $r = bin2oct $num, :prefix, :$length;
                is $r, "0o01";
            }
            elsif $bo == DEC {
                $r = bin2dec $num;
                is $r, $num;
                $r = bin2dec $num, :prefix;
                is $r, "0d1";

                $r = bin2dec $num, :prefix, :$length;
                is $r, "0d01";
            }
            elsif $bo == HEX {
                $r = bin2hex $num;
                is $r, $num;
                $r = bin2hex $num, :prefix;
                is $r, "0x1";

                $r = bin2hex $num, :prefix, :$length;
                is $r, "0x01";
            }
        }
        elsif $bi == OCT {
            if $bo == BIN {
                $r = oct2bin $num;
                is $r, $num;
                $r = oct2bin $num, :prefix;
                is $r, "0b1";

                $r = oct2bin $num, :prefix, :$length;
                is $r, "0b01";
            }
            elsif $bo == OCT {
                $r = oct2oct $num;
                is $r, $num;
                $r = oct2oct $num, :prefix;
                is $r, "0o1";

                $r = oct2oct $num, :prefix, :$length;
                is $r, "0o01";
            }
            elsif $bo == DEC {
                $r = oct2dec $num;
                is $r, $num;
                $r = oct2dec $num, :prefix;
                is $r, "0d1";

                $r = oct2dec $num, :prefix, :$length;
                is $r, "0d01";
            }
            elsif $bo == HEX {
                $r = oct2hex $num;
                is $r, $num;
                $r = oct2hex $num, :prefix;
                is $r, "0x1";

                $r = oct2hex $num, :prefix, :$length;
                is $r, "0x01";
            }
        }
        elsif $bi == DEC {
            if $bo == BIN {
                $r = dec2bin $num;
                is $r, $num;
                $r = dec2bin $num, :prefix;
                is $r, "0b1";

                $r = dec2bin $num, :prefix, :$length;
                is $r, "0b01";
            }
            elsif $bo == OCT {
                $r = dec2oct $num;
                is $r, $num;
                $r = dec2oct $num, :prefix;
                is $r, "0o1";

                $r = dec2bin $num, :prefix, :$length;
                is $r, "0b01";
            }
            elsif $bo == DEC {
                $r = dec2dec $num;
                is $r, $num;
                $r = dec2dec $num, :prefix;
                is $r, "0d1";
            }
            elsif $bo == HEX {
                $r = dec2hex $num;
                is $r, $num;
                $r = dec2hex $num, :prefix;
                is $r, "0x1";
            }
        }
        elsif $bi == HEX {
            if $bo == BIN {
                $r = hex2bin $num;
                is $r, $num;
                $r = hex2bin $num, :prefix;
                is $r, "0b1";
            }
            elsif $bo == OCT {
                $r = hex2oct $num;
                is $r, $num;
                $r = hex2oct $num, :prefix;
                is $r, "0o1";
            }
            elsif $bo == DEC {
                $r = hex2dec $num;
                is $r, $num;
                $r = hex2dec $num, :prefix;
                is $r, "0d1";
            }
            elsif $bo == HEX {
                $r = hex2hex $num;
                is $r, $num;
                $r = hex2hex $num, :prefix;
                is $r, "0x1";
            }
        }

        # now use sub rebase
        
      
    } # end of @bases-o loop

} # end of @bases-i loop

done-testing;

