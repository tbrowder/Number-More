use Test;

use UUID::V4;

use Number::More :ALL;

my $hex = "ffffffffffffffffffffffffffffffff";
is $hex.chars, 32;
lives-ok {
	rebase $hex, 16, 62; #, 22;
}, "test 1";

my $uuid = uuid-v4();
my $nc = $uuid.chars;
#say "DEBUG uuid: '$uuid', chars: $nc" if $debug; #  > 1;
# remove hyphens
$uuid ~~ s:g/'-'//;
$nc = $uuid.chars;
#say "DEBUG2 uuid: '$uuid', chars: $nc" if $debug; # > 1;
# convert to base 62

lives-ok {
    $uuid = rebase $uuid, 16, 62; #, 22;
}, "test 2";

#$uuid = rebase $uuid, 16, 62;
$nc = $uuid.chars;
#say "DEBUG3 uuid: '$uuid', chars: $nc" if $debug; # > 1;
#return $uuid;

# from a bug:
$hex = 'e90cdff8d6714c529efead7dfea22262';

lives-ok {
    $hex = rebase $hex, 16, 62; #, 22;
}, "test 3";

done-testing;

