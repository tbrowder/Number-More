=begin pod

read a formatted file of pipe-separated lines consisting of:

  decimal, binary, hexadecimal, octal, base num, number

goal is to cover all bases 2..62 excluding 2, 8, 10, and 16

for data in each line, check converssions from and to each

my @fbases = <10 2 16 8 N>;
my $rbases = @fbases.reverse;

for @fbases -> $bi {
    for @rbases -> $bo {
        next if $bi == $bo;
        calc and check base conversion
    }
}




