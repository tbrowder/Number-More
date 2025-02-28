use Test;

use Number::More :ALL;

my $debug = 0;

is 1, 1;

my $bset = "01".comb.Set;
my $oset = (0..7).Set;
my $dset = (0..9).Set;
say $oset.gist if $debug;

sub create-base-set {...}
sub create-base-subset {...}
my ($bset1, $bset2);

($bset1, $bset2) = create-base-set 39; # char d is highest avail
say $bset1.gist if 1 or $debug;
say $bset2.gist if 1 or $debug;

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

#=========================================================
say "SET DEF 2...";
my $x;

# false methods
$x = <3>.Set;
say "FALSE checking 3 with method 0: {$x (<=) $bset2}";
$x = (3).Set;
say "FALSE checking 3 with method 1: {$x (<=) $bset2}";

# true methods
$x = (3).Str.Set;
say "TRUE checking 3 with method 2: {$x (<=) $bset2}";
$x = ('3').Set;
say "TRUE checking 3 with method 3: {$x (<=) $bset2}";

# true
$x = <a>.Set;
say "TRUE checking a with method 0: {$x (<=) $bset2}";

# fatal
# $x = (a).Set;
#say "checking a with method 1: {$x (<=) $bset2}";
# fatal
#$x = (a).Str.Set;
#say "checking a with method 2: {$x (<=) $bset2}";

# true
$x = ('a').Set;
say "TRUE checking a with method 3: {$x (<=) $bset2}";
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
    my $res2 = $subset (<=) $bset2;
    is $res2, $exp;
}

sub create-set(
    $text,
    :$debug,
    --> Set
    ) is export {
    
    my @chars = $text.comb.unique;
    my %h;
    for @chars {
        %h{$_} = True;
    }
    %h.Set;
}

sub create-base-set(
    UInt $base where { 1 < $base < 63 },
    :$debug,
    #--> Set
    --> List
    ) is export {
    # if the base is < 37 (letter case insensitive)
    my $CS = 0;

    if $base > 36 {
        ++$CS;
        #die "Tom, fix this to handle base > 36";
    }

    my $first-char-idx = 0;
    my $F = $first-char-idx;
    my $first-char = @dec2digit[$first-char-idx];
    my $FC = $first-char;

    my $last-char-idx  = $base - 1;
    my $L = $last-char-idx;

    my $last-char = @dec2digit[$last-char-idx];
    my $LC = $last-char;

    say "DEBUG base $base, first char is char index $F, char '$FC'";
    say "                   last char is char index $L, char '$LC'";

    my $chars = @dec2digit[$F..$L].join;

    # try two methods:
    my %h;
    my $s = '';
    if not $CS {
        for $chars.comb -> $c is copy {
            $c .= Str;
            $c .= lc;
            %h{$c} = True;
            $s ~= " $c";
        }
    }
    else {
        for $chars.comb -> $c is copy {
            $c .= Str;
            %h{$c} = True;
            $s ~= " $c";
        }
    }
    my $bset1 = %h.Set;
    my $bset2 = $s.Str.Set;

    $bset1, $bset1;
}

done-testing;
