#!/usr/bin/env perl6

use Number::More :ALL;

# a test set of numbers and bases
my $nums   = 100; # nums to choose
my $nchars = 5; # num chars per number

my @b = 2..62;
for 1..$nums -> $i {
    # pick chars at random
    my @c = pick $nchars, @stdchar;
    my $num-i = join '', @c;
    say "== number $i: $num-i";

    # pick each valid base
    for @b -> $base-i {
       #my @bo = @b;
       next if $num-i !~~ @base[$base-i];
       # pick an output base
       #my $base-o = pick 1, @bo;
       my $base-o = pick 1, @b;
       while $base-o == $base-i {
           $base-o = pick 1, @b;
       }
       say "  base-i: $base-i; base-o: $base-o";
    }
}

sub rebase2($x, $bi, $bo) {
    my $log_b-x = ln $x / ln $b;
    
    my $n = floor $log_b-x;

    my $r_n = $x;

    for $n..0 -> $i {
    }

}


