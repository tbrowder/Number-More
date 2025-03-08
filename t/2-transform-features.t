use Test;

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

my \BIN = 2;
my \OCT = 8;
my \DEC = 10;
my \HEX = 16;

for @bases-i -> $bi {
    BASE-OUT: for @bases-o -> $bo {
        my $num = "1";
        my $length = 4;
        my ($res, $r1, $r);
        if $bi == BIN {
            if $bo == BIN {
                $res = bin2bin $num;
                is $res, $num;
                $r = bin2bin $num, :prefix;
                is $r, "0b1";

                $r = bin2bin $num, :prefix, :$length;
                is $r, "0b01";

            }
            elsif $bo == OCT {
                $res = bin2oct $num;
                is $res, $num;
                $r1 = bin2oct $num, :prefix;
                is $r1.comb[0..1].join, "0o";
            }
            elsif $bo == DEC {
                $res = bin2dec $num;
                is $res, $num;
                $r1 = bin2dec $num, :prefix;
                is $r1.comb[0..1].join, "0d";
            }
            elsif $bo == HEX {
                $res = bin2hex $num;
                is $res, $num;
                $r1 = bin2hex $num, :prefix;
                is $r1.comb[0..1].join, "0x";
            }
        }
        elsif $bi == OCT {
            if $bo == BIN {
                $res = oct2bin $num;
                is $res, $num;
                $r1 = oct2bin $num, :prefix;
                is $r1.comb[0..1].join, "0b";
            }
            elsif $bo == OCT {
                $res = oct2oct $num;
                is $res, $num;
                $r1 = oct2oct $num, :prefix;
                is $r1.comb[0..1].join, "0o";
            }
            elsif $bo == DEC {
                $res = oct2dec $num;
                is $res, $num;
                $r1 = oct2dec $num, :prefix;
                is $r1.comb[0..1].join, "0d";
            }
            elsif $bo == HEX {
                $res = oct2hex $num;
                is $res, $num;
                $r1 = oct2hex $num, :prefix;
                is $r1.comb[0..1].join, "0x";
            }
        }
        elsif $bi == DEC {
            if $bo == BIN {
                $res = dec2bin $num;
                is $res, $num;
                $r1 = dec2bin $num, :prefix;
                is $r1.comb[0..1].join, "0b";
            }
            elsif $bo == OCT {
                $res = dec2oct $num;
                is $res, $num;
                $r1 = dec2oct $num, :prefix;
                is $r1.comb[0..1].join, "0o";
            }
            elsif $bo == DEC {
                $res = dec2dec $num;
                is $res, $num;
                $r1 = dec2dec $num, :prefix;
                is $r1.comb[0..1].join, "0d";
            }
            elsif $bo == HEX {
                $res = dec2hex $num;
                is $res, $num;
                $r1 = dec2hex $num, :prefix;
                is $r1.comb[0..1].join, "0x";
            }
        }
        elsif $bi == HEX {
            if $bo == BIN {
                $res = hex2bin $num;
                is $res, $num;
                $r1 = hex2bin $num, :prefix;
                is $r1.comb[0..1].join, "0b";
            }
            elsif $bo == OCT {
                $res = hex2oct $num;
                is $res, $num;
                $r1 = hex2oct $num, :prefix;
                is $r1.comb[0..1].join, "0o";
            }
            elsif $bo == DEC {
                $res = hex2dec $num;
                is $res, $num;
                $r1 = hex2dec $num, :prefix;
                is $r1.comb[0..1].join, "0d";
            }
            elsif $bo == HEX {
                $res = hex2hex $num;
                is $res, $num;
                $r1 = hex2hex $num, :prefix;
                is $r1.comb[0..1].join, "0x";
            }
        }

        # now use sub rebase
        
      
    } # end of @bases-o loop

} # end of @bases-i loop

done-testing;

