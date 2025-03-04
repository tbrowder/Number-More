use Test;

use Number::More :ALL;

plan 61;

# error conditions
dies-ok { 
    rebase('Z', 20, 3); 
}, "incorrect base number for input";

for 1..61 -> $i {
    my $bi = 10;
    my $bo = $i+1;

    next if $bi == $bo;

    # use exact definitions of the decimal number in the desired output base
    # use @dec2digit
    my $tnum-in  = $i;
    my $tnum-out = @dec2digit[$i];

    die "FATAL: Output number is NOT a single char." if $tnum-out.chars != 1;

    my $res = rebase $tnum-in, $bi, $bo;
    is $res, $tnum-out;
}
