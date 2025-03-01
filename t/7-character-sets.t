use Test;

use Number::More :ALL;

my $debug = 0;

my $bset = "01".comb.Set;
my $oset = (0..7).Set;
my $dset = (0..9).Set;
say $oset.gist if $debug;

my ($bset1);

$bset1 = create-base-set 39; # char d is highest avail
say $bset1.gist if 1 or $debug;

#=========================================================
say "SET DEF 1...";

# false methods
say "FALSE checking 3 with method 0: {<3>.Set (<=) $bset1}";
say "FALSE checking 3 with method 1: {(3).Set (<=) $bset1}";
# true methods
say "TRUE checking 3 with method 2: {(3).Str.Set (<=) $bset1}";
say "TRUE checking 3 with method 3: {('3').Set (<=) $bset1}";

# true
say "TRUE checking a with method 0: {<a>.Set (<=) $bset1}";
# fatal
#say "checking a with method 1: {(a).Set (<=) $bset1}";
# fatal
#say "checking a with method 2: {(a).Str.Set (<=) $bset1}";
# true
say "TRUE checking a with method 3: {('a').Set (<=) $bset1}";
#=========================================================

# list of strings to create subsets
my @s = < 1 a 1a g 1g 24 ab >;
for @s {
    my $exp = True;
    if $_ ~~ /g/ {
       $exp = False;
    }
    my $subset = create-set $_;
    my $res1 = $subset (<=) $bset1;
    is $res1, $exp;
}

done-testing;
