#!/usr/bin/env perl6

use Text::More :strip-comment;

class eg {
    has @!w;   # used for construction
    has $.dec;
    has $.bin;
    has $.hex;
    has $.oct;
    has $.base;
    has $.num; # number in $base format

    submethod BUILD(:words(:@!w)) {
        $!dec  = @!w[0];
        $!bin  = @!w[1];
        $!hex  = @!w[2];
        $!oct  = @!w[3];
        $!base = @!w[4];
        $!num  = @!w[5];
    }
}

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

=end pod

my $ifil = 'base-conversions.dat';
my $ofil = '060-auto-transform-checks.t';

my $fh = open $ofil, :w;

my @egs;

for $ifil.IO.lines -> $line is copy {
   $line = strip-comment $line; 
   next if $line !~~ /\S/;
   $line ~~ s:g/'|'//;
   my @w = $line.words;
   #print "$_; " for @w;
   #say '';
   my $e = eg.new(:words(@w));
   #say $e.dec;
   @egs.append: $e;
}

#say $_.dec for @egs;
my @regs = @egs.reverse;
#say $_.dec for @regs;

for @egs -> $e {
    my $bi = $e.base;
    for @regs -> $re {
        my $bo = $re.base;
        next if $bi == $bo;
        # calc and check base conversions
    }
}

say "Normal end.";
