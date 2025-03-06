#!/usr/bin/env raku

use lib "../lib";

use Number::More;
my $ofil = "some-test.t";

if not @*ARGS {
    print qq:to/HERE/;
    Usage: {$*PROGRAM.basename} go

    Output: file '$ofil'

    Using module 'Number::More', this program creates
    a test file for testing the optional args for subs:

      X2Y where X and Y are: bin, oct, dec, and hex
      pad-number

    The optional arguments are:

      :length
      :prefix
      :suffix
      :LC 

    Note: Future replacement module 'Number' will offer
          ':LC' aliases ':lc' and ':lower-case'.

    HERE
    exit;
}

my $debug = 0;
my @bases = 2..62;
for @bases -> $base {
   my $bset = create-base-set $base;
   say $bset if $debug;
   my $sset = create-set 
   if $base ~~ &binary {
       say "binary";
   }

}

=finish

my $num = 1;

my
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

   # transliterate the line [VERY IMPORTANT!!]
   $line .= trans( 'a'..'z' => 'A'..'Z', 'A'..'Z' => 'a'..'z' );

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

# we have the source data, now write the test file...
my $fh = open $ofil, :w;

# header info
$fh.print: q:to/HERE/;
use Test;

use Number::More :ALL;

plan 456;

my $debug = 0;

my $suffix = True;
HERE

# step through the data set
my $tnum = 0;
for @egs -> $e {

    # calc and check base conversions
    my $num-dec = $e.dec;
    my $num-bin = $e.bin;
    my $num-oct = $e.oct;
    my $num-hex = $e.hex;
    my $base    = $e.base;
    my $num-num = $e.num;

    $fh.print: qq:to/HERE/;

    is rebase($num-dec, 10, $base), "$num-num", "base $base; test {++$tnum}";
    is rebase("$num-bin", 2, $base), "$num-num", "base $base; test {++$tnum}";
    is rebase("$num-oct", 8, $base), "$num-num", "base $base; test {++$tnum}";
    is rebase("$num-hex", 16, $base), "$num-num", "base $base; test {++$tnum}";

    # add the suffix
    is rebase($num-dec, 10, $base, :\$suffix), "{$num-num}_base-$base", "base $base; test {++$tnum}";
    is rebase("$num-bin", 2, $base, :\$suffix), "{$num-num}_base-$base", "base $base; test {++$tnum}";
    is rebase("$num-oct", 8, $base, :\$suffix), "{$num-num}_base-$base", "base $base; test {++$tnum}";
    is rebase("$num-hex", 16, $base, :\$suffix), "{$num-num}_base-$base", "base $base; test {++$tnum}";
    HERE
}

say "Normal end.";
say "See output file '$ofil'.";
