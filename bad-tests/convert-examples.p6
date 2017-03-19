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

for data in each line, check conversions from and to each

my @fbases = <10 2 16 8 N>;
my $rbases = @fbases.reverse;

for @fbases -> $bi {
    for @rbases -> $bo {
        next if $bi == $bo;
        calc and check base conversion
    }
}

=end pod

my $debug = 0;
$debug = 1 if @*ARGS.elems;

my $ifil = 'base-conversions.dat';
my $ofil = '060-auto-transform-checks.t';

my @egs;

for $ifil.IO.lines -> $line is copy {
   $line = strip-comment $line;
   # ignore empty lines
   next if $line !~~ /\S/;
   $line ~~ s:g/'|'//;

   # take care of the cases of empty pipe lines awaiting data
   next if $line !~~ /\S/;
   my @w = $line.words;

   if $debug {
       print "$_; " for @w;
       say '';
   }

   my $e = eg.new(:words(@w));
   say $e.dec if $debug;
   @egs.append: $e;
}

if $debug {
    say $_.dec for @egs;
}

my @regs = @egs.reverse;

if $debug {
    say $_.dec for @regs;
}

# we have the source data, now write the test file...
my $fh = open $ofil, :w;

# header info
$fh.print: q:to/HERE/;
use Test;

use Number::More :ALL;

plan 80;

my $debug = 0;
HERE

# step through the data set
my $tnum = 0;
for @egs -> $e {
    #my $bi = $e.base;
    #for @regs -> $re {
        #my $bo = $re.base;
    #next if $bi == $bo;

        # calc and check base conversions
	my $num-dec = $e.dec;
	my $num-bin = $e.bin;
	my $num-oct = $e.oct;
	my $num-hex = $e.hex;
	my $base    = $e.base;
	my $num-num = $e.num;


	$fh.print: qq:to/HERE/;

	is rebase($num-dec, 10, $base), "$num-num", "test {++$tnum}";
	is rebase("$num-bin", 2, $base), "$num-num", "test {++$tnum}";
	is rebase("$num-oct", 8, $base), "$num-num", "test {++$tnum}";
	is rebase("$num-hex", 16, $base), "$num-num", "test {++$tnum}";
	HERE

    #}
}

say "Normal end.";
say "See output file '$ofil'.";
