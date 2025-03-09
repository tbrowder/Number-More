# WARNING - THIS FILE IS AUTO-GENERATED - EDITS MAY BE LOST
# See ./dev/create-tests.raku for the generating source

use Test;
use Number::More :ALL;

#plan 97;

my $r; # exe results to test
my $length = 4; 

$r = bin2bin('1');
$r = bin2bin('1', :$length);
$r = bin2bin('1', :prefix);
$r = bin2bin('1', :$length, :prefix);
is $r.chars, 4;
$r = bin2bin('1', :suffix);
$r = bin2bin('1', :$length, :suffix);

$r = bin2oct('1');
$r = bin2oct('1', :$length);
$r = bin2oct('1', :prefix);
$r = bin2oct('1', :$length, :prefix);
is $r.chars, 4;
$r = bin2oct('1', :suffix);
$r = bin2oct('1', :$length, :suffix);

$r = bin2dec('1');
$r = bin2dec('1', :$length);
$r = bin2dec('1', :prefix);
$r = bin2dec('1', :$length, :prefix);
is $r.chars, 4;
$r = bin2dec('1', :suffix);
$r = bin2dec('1', :$length, :suffix);

$r = bin2hex('1');
$r = bin2hex('1', :$length);
$r = bin2hex('1', :prefix);
$r = bin2hex('1', :$length, :prefix);
is $r.chars, 4;
$r = bin2hex('1', :suffix);
$r = bin2hex('1', :$length, :suffix);

$r = oct2bin('1');
$r = oct2bin('1', :$length);
$r = oct2bin('1', :prefix);
$r = oct2bin('1', :$length, :prefix);
is $r.chars, 4;
$r = oct2bin('1', :suffix);
$r = oct2bin('1', :$length, :suffix);

$r = oct2oct('1');
$r = oct2oct('1', :$length);
$r = oct2oct('1', :prefix);
$r = oct2oct('1', :$length, :prefix);
is $r.chars, 4;
$r = oct2oct('1', :suffix);
$r = oct2oct('1', :$length, :suffix);

$r = oct2dec('1');
$r = oct2dec('1', :$length);
$r = oct2dec('1', :prefix);
$r = oct2dec('1', :$length, :prefix);
is $r.chars, 4;
$r = oct2dec('1', :suffix);
$r = oct2dec('1', :$length, :suffix);

$r = oct2hex('1');
$r = oct2hex('1', :$length);
$r = oct2hex('1', :prefix);
$r = oct2hex('1', :$length, :prefix);
is $r.chars, 4;
$r = oct2hex('1', :suffix);
$r = oct2hex('1', :$length, :suffix);

$r = dec2bin('1');
$r = dec2bin('1', :$length);
$r = dec2bin('1', :prefix);
$r = dec2bin('1', :$length, :prefix);
is $r.chars, 4;
$r = dec2bin('1', :suffix);
$r = dec2bin('1', :$length, :suffix);

$r = dec2oct('1');
$r = dec2oct('1', :$length);
$r = dec2oct('1', :prefix);
$r = dec2oct('1', :$length, :prefix);
is $r.chars, 4;
$r = dec2oct('1', :suffix);
$r = dec2oct('1', :$length, :suffix);

$r = dec2dec('1');
$r = dec2dec('1', :$length);
$r = dec2dec('1', :prefix);
$r = dec2dec('1', :$length, :prefix);
is $r.chars, 4;
$r = dec2dec('1', :suffix);
$r = dec2dec('1', :$length, :suffix);

$r = dec2hex('1');
$r = dec2hex('1', :$length);
$r = dec2hex('1', :prefix);
$r = dec2hex('1', :$length, :prefix);
is $r.chars, 4;
$r = dec2hex('1', :suffix);
$r = dec2hex('1', :$length, :suffix);
$r = dec2hex('16', :$length, :prefix, :LC);
is $r.chars, 4;

$r = hex2bin('1');
$r = hex2bin('1', :$length);
$r = hex2bin('1', :prefix);
$r = hex2bin('1', :$length, :prefix);
is $r.chars, 4;
$r = hex2bin('1', :suffix);
$r = hex2bin('1', :$length, :suffix);

$r = hex2oct('1');
$r = hex2oct('1', :$length);
$r = hex2oct('1', :prefix);
$r = hex2oct('1', :$length, :prefix);
is $r.chars, 4;
$r = hex2oct('1', :suffix);
$r = hex2oct('1', :$length, :suffix);

$r = hex2dec('1');
$r = hex2dec('1', :$length);
$r = hex2dec('1', :prefix);
$r = hex2dec('1', :$length, :prefix);
is $r.chars, 4;
$r = hex2dec('1', :suffix);
$r = hex2dec('1', :$length, :suffix);

$r = hex2hex('1');
$r = hex2hex('1', :$length);
$r = hex2hex('1', :prefix);
$r = hex2hex('1', :$length, :prefix);
is $r.chars, 4;
$r = hex2hex('1', :suffix);
$r = hex2hex('1', :$length, :suffix);

done-testing;
