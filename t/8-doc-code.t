use Test;

use Number::More :ALL;

my $debug = 0;

# Tests code described in the docs

=begin code
use Number::More :ALL;
my $bin = '11001011';   # do not enter any prefix
my $hex = bin2hex $bin;
say $hex; # OUTPUT: 'CB'
=end code

{
use Number::More :ALL;
my $bin = '11001011';   # do not enter any prefix
my $hex = bin2hex $bin;
say $hex; # OUTPUT: 'CB'
is $hex, 'CB';
}

=begin code
my $bin = '11001011';
my $dec = parse-base $bin, 2;
$dec = $bin.parse-base: 2;
my $hex = $dec.base : 16;
say $hex; # OUTPUT 'CB'
=end code

{
my $bin = '11001011';
my $dec = parse-base $bin, 2;
my $hex = $dec.base: 16;
say $hex; # OUTPUT 'CB'
is $hex, 'CB';

$dec = $bin.parse-base: 2;
$hex = $dec.base: 16;
is $hex, 'CB';
}

done-testing;

