use Test;

use Number::More :ALL;

my $debug = 0;

my $bset = "01".comb.Set;
my $oset = (0..7).Set;
my $dset = (0..9).Set;
say $oset.gist if $debug;

my $hset = "abcdef".comb.Set (|) $dset;
say $hset.gist if $debug;
my $alowset = ("a".."z").Set;
say $alowset.gist if $debug;
my $ahighset = ("a".."z").uc.Set;
say $ahighset.gist if $debug;
my $base62 = $dset (|) $alowset (|) $ahighset;
say $base62.gist if $debug;

sub create-set {...}

my $xset = create-set 2;
say $xset.gist if $debug;

$xset = create-set 22;
say $xset.gist if $debug;

$xset = create-set 40;
say $xset.gist if $debug;
say ("3").Set (<=) $xset;


sub create-set(
    UInt $base where { 1 < $base < 63 },
    :$debug,
    --> Set
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

    my @chars = @dec2digit[$F..$L];
    my $set;
    if $CS {
        $set = @chars.comb.Set;
    }
    else {
        $set = @chars.comb.lc.Set;
    }

    $set;
}

