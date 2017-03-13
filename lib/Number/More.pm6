unit module Number::More:auth<github:tbrowder>;

# file:  ALL-SUBS.md
# title: Subroutines Exported by the `:ALL` Tag

# export a debug var for users
our $DEBUG is export(:DEBUG) = False;
BEGIN {
    if %*ENV<NUMBER_MORE_DEBUG> {
	$DEBUG = True;
    }
    else {
	$DEBUG = False;
    }
}

# export a var for users to set length behavior
our $LENGTH-HANDLING is export(:DEBUG) = 'ignore'; # other options: 'warn', 'fail'
my token length-action { ^ :i warn|fail $ }

# define tokens for common regexes
my token binary is export(:token-binary)            { ^ <[01]>+ $ }
my token octal is export(:token-octal)              { ^ <[0..7]>+ $ }
my token decimal is export(:token-decimal)          { ^ \d+ $ }              # actually an int
my token hexadecimal is export(:token-hecadecimal)  { :i ^ <[a..f\d]>+ $ }   # multiple chars

# for general base functions 2..62
my token all-bases is export(:token-all-bases)      { ^ <[2..9]> | <[1..5]><[0..9]> | 6 <[0..2]> $ }

# for limited, current base functions 2..36
my token limited-bases is export(:token-limited-bases) { ^ <[2..9]> | <[1..2]><[0..9]> | 3 <[0..6]> $ }

# base 2 is binary
my token base2 is export(:token-base2)              { ^ <[01]>+ $ }
my token base3 is export(:token-base3)              { ^ <[012]>+ $ }
my token base4 is export(:token-base4)              { ^ <[0..3]>+ $ }
my token base5 is export(:token-base5)              { ^ <[0..4]>+ $ }
my token base6 is export(:token-base6)              { ^ <[0..5]>+ $ }
my token base7 is export(:token-base7)              { ^ <[0..6]>+ $ }
# base 8 is octal
my token base8 is export(:token-base8)              { ^ <[0..7]>+ $ }
my token base9 is export(:token-base9)              { ^ <[0..8]>+ $ }
# base 10 is decimal
my token base10 is export(:token-base10)            { ^ \d+ $ }              # actually an int
my token base11 is export(:token-base11)            { :i ^ <[a\d]>+ $ }      # multiple chars
my token base12 is export(:token-base12)            { :i ^ <[ab\d]>+ $ }     # multiple chars
my token base13 is export(:token-base13)            { :i ^ <[abc\d]>+ $ }    # multiple chars
my token base14 is export(:token-base14)            { :i ^ <[a..d\d]>+ $ }   # multiple chars
my token base15 is export(:token-base15)            { :i ^ <[a..e\d]>+ $ }   # multiple chars
# base 16 is hexadecimal
my token base16 is export(:token-base16)            { :i ^ <[a..f\d]>+ $ }   # multiple chars
my token base17 is export(:token-base17)            { :i ^ <[a..g\d]>+ $ }   # multiple chars
my token base18 is export(:token-base18)            { :i ^ <[a..h\d]>+ $ }   # multiple chars
my token base19 is export(:token-base19)            { :i ^ <[a..i\d]>+ $ }   # multiple chars

my token base20 is export(:token-base20)            { :i ^ <[a..j\d]>+ $ }   # multiple chars
my token base21 is export(:token-base21)            { :i ^ <[a..k\d]>+ $ }   # multiple chars
my token base22 is export(:token-base22)            { :i ^ <[a..l\d]>+ $ }   # multiple chars
my token base23 is export(:token-base23)            { :i ^ <[a..m\d]>+ $ }   # multiple chars
my token base24 is export(:token-base24)            { :i ^ <[a..n\d]>+ $ }   # multiple chars
my token base25 is export(:token-base25)            { :i ^ <[a..o\d]>+ $ }   # multiple chars
my token base26 is export(:token-base26)            { :i ^ <[a..p\d]>+ $ }   # multiple chars
my token base27 is export(:token-base27)            { :i ^ <[a..q\d]>+ $ }   # multiple chars
my token base28 is export(:token-base28)            { :i ^ <[a..r\d]>+ $ }   # multiple chars
my token base29 is export(:token-base29)            { :i ^ <[a..s\d]>+ $ }   # multiple chars

my token base30 is export(:token-base30)            { :i ^ <[a..t\d]>+ $ }   # multiple chars
my token base31 is export(:token-base31)            { :i ^ <[a..u\d]>+ $ }   # multiple chars
my token base32 is export(:token-base32)            { :i ^ <[a..v\d]>+ $ }   # multiple chars
my token base33 is export(:token-base33)            { :i ^ <[a..w\d]>+ $ }   # multiple chars
my token base34 is export(:token-base34)            { :i ^ <[a..x\d]>+ $ }   # multiple chars
my token base35 is export(:token-base35)            { :i ^ <[a..y\d]>+ $ }   # multiple chars
my token base36 is export(:token-base36)            { :i ^ <[a..z\d]>+ $ }   # multiple chars

# char sets for higher bases are case sensitive
my token base37 is export(:token-base37)            { ^ <[A..Za\d]>+ $ }     # case-sensitive, multiple chars
my token base38 is export(:token-base38)            { ^ <[A..Zab\d]>+ $ }    # case-sensitive, multiple chars
my token base39 is export(:token-base39)            { ^ <[A..Zabc\d]>+ $ }   # case-sensitive, multiple chars

my token base40 is export(:token-base40)            { ^ <[A..Za..d\d]>+ $ }  # case-sensitive, multiple chars
my token base41 is export(:token-base41)            { ^ <[A..Za..e\d]>+ $ }  # case-sensitive, multiple chars
my token base42 is export(:token-base42)            { ^ <[A..Za..f\d]>+ $ }  # case-sensitive, multiple chars
my token base43 is export(:token-base43)            { ^ <[A..Za..g\d]>+ $ }  # case-sensitive, multiple chars
my token base44 is export(:token-base44)            { ^ <[A..Za..h\d]>+ $ }  # case-sensitive, multiple chars
my token base45 is export(:token-base45)            { ^ <[A..Za..i\d]>+ $ }  # case-sensitive, multiple chars
my token base46 is export(:token-base46)            { ^ <[A..Za..j\d]>+ $ }  # case-sensitive, multiple chars
my token base47 is export(:token-base47)            { ^ <[A..Za..k\d]>+ $ }  # case-sensitive, multiple chars
my token base48 is export(:token-base48)            { ^ <[A..Za..l\d]>+ $ }  # case-sensitive, multiple chars
my token base49 is export(:token-base49)            { ^ <[A..Za..m\d]>+ $ }  # case-sensitive, multiple chars

my token base50 is export(:token-base50)            { ^ <[A..Za..n\d]>+ $ }  # case-sensitive, multiple chars
my token base51 is export(:token-base51)            { ^ <[A..Za..o\d]>+ $ }  # case-sensitive, multiple chars
my token base52 is export(:token-base52)            { ^ <[A..Za..p\d]>+ $ }  # case-sensitive, multiple chars
my token base53 is export(:token-base53)            { ^ <[A..Za..q\d]>+ $ }  # case-sensitive, multiple chars
my token base54 is export(:token-base54)            { ^ <[A..Za..r\d]>+ $ }  # case-sensitive, multiple chars
my token base55 is export(:token-base55)            { ^ <[A..Za..s\d]>+ $ }  # case-sensitive, multiple chars
my token base56 is export(:token-base56)            { ^ <[A..Za..t\d]>+ $ }  # case-sensitive, multiple chars
my token base57 is export(:token-base57)            { ^ <[A..Za..u\d]>+ $ }  # case-sensitive, multiple chars
my token base58 is export(:token-base58)            { ^ <[A..Za..v\d]>+ $ }  # case-sensitive, multiple chars
my token base59 is export(:token-base59)            { ^ <[A..Za..w\d]>+ $ }  # case-sensitive, multiple chars

my token base60 is export(:token-base60)            { ^ <[A..Za..x\d]>+ $ }  # case-sensitive, multiple chars
my token base61 is export(:token-base61)            { ^ <[A..Za..y\d]>+ $ }  # case-sensitive, multiple chars
my token base62 is export(:token-base62)            { ^ <[A..Za..x\d]>+ $ }  # case-sensitive, multiple chars

my @base = [
'0',
'1',
&base2,
&base3,
&base4,
&base5,
&base6,
&base7,
&base8,
&base9,
&base10,
&base11,
&base12,
&base13,
&base14,
&base15,
&base16,
&base17,
&base18,
&base19,
&base20,
&base21,
&base22,
&base23,
&base24,
&base25,
&base26,
&base27,
&base28,
&base29,
&base30,
&base31,
&base32,
&base33,
&base34,
&base35,
&base36,

&base37,
&base38,
&base39,

&base40,
&base41,
&base42,
&base43,
&base44,
&base45,
&base46,
&base47,
&base48,
&base49,

&base50,
&base51,
&base52,
&base53,
&base54,
&base55,
&base56,
&base57,
&base58,
&base59,

&base60,
&base61,
&base62,

];

# standard char set for bases 2 through 62 (char 0 through 61)
our @stdchar is export(:stdchar) = <
0 1 2 3 4 5 6 7 8 9
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
a b c d e f g h i j k l m n o p q r s t u v w x y z
>;


my token base { ^ 2|8|10|16 $ }

# this is an internal sub
sub pad-number($num is rw,
               UInt $base where &limited-bases, # change to "&all-bases" when ready
               UInt $len = 0,
               Bool :$prefix = False,
               Bool :$LC = False) {

    # this also checks for length error, upper-lower casing, and handling
    if $base > 10 && $base < 37 {
        if $LC {
	    # special feature for case-insensitive bases
            $num .= lc;
        }
    }

    my $nc  = $num.chars;
    my $nct = $prefix ?? $nc + 2 !! $nc;
    if $LENGTH-HANDLING ~~ &length-action && $nct > $len {
        my $msg = "Desired length ($len) of number '$num' is less than required by it";
        $msg ~= " and its prefix" if $prefix;
        $msg ~= " ($nct).";

        if $LENGTH-HANDLING ~~ /$ :i warn $/ {
            note "WARNING: $msg";
        }
        else {
            die "FATAL: $msg";
        }
    }

    if $len > $nct {
        # padding required
        # first pad with zeroes
        # the following test should always be true!!
        die "debug FATAL: unexpected \$len ($len) NOT greater than \$nc ($nc)" if $len <= $nc;
        # create the zero padding
        my $zpad = 0 x ($len - $nct);
        $num = $zpad ~ $num;
    }
    if $prefix {
        when $base eq '2'  { $num = '0b' ~ $num }
        when $base eq '8'  { $num = '0o' ~ $num }
        when $base eq '16' { $num = '0x' ~ $num }
    }
}

#------------------------------------------------------------------------------
# Subroutine: hex2dec
# Purpose : Convert a non-negative hexadecimal number (string) to a decimal number.
# Params  : Hexadecimal number (string), desired length (optional).
# Returns : Decimal number (or string).
sub hex2dec(Str:D $hex where &hexadecimal,
            UInt $len = 0
            --> Cool) is export(:hex2dec) {
    # need bases of incoming and outgoing number
    constant $base-i = 16;
    constant $base-o = 10;

    my $dec = parse-base $hex, $base-i;
    pad-number $dec, $base-o, $len;
    return $dec;
} # hex2dec

#------------------------------------------------------------------------------
# Subroutine: hex2bin
# Purpose : Convert a non-negative hexadecimal number (string) to a binary string.
# Params  : Hexadecimal number (string), desired length (optional), prefix (optional).
# Returns : Binary number (string).
sub hex2bin(Str:D $hex where &hexadecimal,
            UInt $len = 0,
            Bool :$prefix = False
            --> Str) is export(:hex2bin) {
    # need bases of incoming and outgoing number
    constant $base-i = 16;
    constant $base-o =  2;

    # have to get decimal first
    my $dec = parse-base $hex, $base-i;
    my $bin = $dec.base: $base-o;
    pad-number $bin, $base-o, $len, :$prefix;
    return $bin;
} # hex2bin

#------------------------------------------------------------------------------
# Subroutine: dec2hex
# Purpose : Convert a non-negative integer to a hexadecimal number (string).
# Params  : Non-negative decimal number, desired length (optional), prefix (optional), lower-case (optional).
# Returns : Hexadecimal number (string).
sub dec2hex($dec where &decimal,
            UInt $len = 0,
            Bool :$prefix = False,
            Bool :$LC = False
	    --> Str) is export(:dec2hex) {
    # need base of outgoing number
    constant $base-o = 16;

    my $hex = $dec.base: $base-o;
    pad-number $hex, $base-o, $len, :$prefix, :$LC;
    return $hex;
} # dec2hex

#------------------------------------------------------------------------------
# Subroutine: dec2bin
# Purpose : Convert a non-negative integer to a binary number (string).
# Params  : Non-negative decimal number, desired length (optional), prefix (optional).
# Returns : Binary number (string).
sub dec2bin($dec where &decimal,
            UInt $len = 0,
            :$prefix = False
            --> Str) is export(:dec2bin) {
    # need base of outgoing number
    constant $base-o = 2;

    my $bin = $dec.base: $base-o;
    pad-number $bin, $base-o, $len, :$prefix;
    return $bin;
} # dec2bin

#------------------------------------------------------------------------------
# Subroutine: bin2dec
# Purpose : Convert a binary number (string) to a decimal number.
# Params  : Binary number (string), desired length (optional).
# Returns : Decimal number (or string).
sub bin2dec(Str:D $bin where &binary,
            UInt $len = 0
            --> Cool) is export(:bin2dec) {
    # need bases of incoming and outgoing numbers
    constant $base-i =  2;
    constant $base-o = 10;

    my $dec = parse-base $bin, $base-i;
    pad-number $dec, $base-o, $len;
    return $dec;
} # bin2dec

#------------------------------------------------------------------------------
# Subroutine: bin2hex
# Purpose : Convert a binary number (string) to a hexadecimal number (string).
# Params  : Binary number (string), desired length (optional), prefix (optional), lower-case (optional).
# Returns : Hexadecimal number (string).
sub bin2hex(Str:D $bin where &binary,
            UInt $len = 0,
            Bool :$prefix = False,
            Bool :$LC = False
	    --> Str) is export(:bin2hex) {
    # need bases of incoming and outgoing number
    constant $base-i =  2;
    constant $base-o = 16;

    # need decimal intermediary
    my $dec = parse-base $bin, $base-i;
    my $hex = $dec.base: $base-o;
    pad-number $hex, $base-o, $len, :$prefix, :$LC;
    return $hex;
} # bin2hex

#------------------------------------------------------------------------------
# Subroutine: oct2bin
# Purpose : Convert an octal number (string) to a binary number (string).
# Params  : Octal number (string), desired length (optional), prefix (optional).
# Returns : Binary number (string).
sub oct2bin($oct where &octal, UInt $len = 0,
            Bool :$prefix = False
            --> Str) is export(:oct2bin) {
    # need bases of incoming and outgoing number
    constant $base-i = 8;
    constant $base-o = 2;

    # need decimal intermediary
    my $dec = parse-base $oct, $base-i;
    my $bin = $dec.base: $base-o;
    pad-number $bin, $base-o, $len, :$prefix;
    return $bin;
} # oct2bin

#------------------------------------------------------------------------------
# Subroutine: oct2hex
# Purpose : Convert an octal number (string) to a hexadecimal number (string).
# Params  : Octal number (string), desired length (optional), prefix (optional), lower-case (optional).
# Returns : Hexadecimal number (string).
sub oct2hex($oct where &octal, UInt $len = 0,
            Bool :$prefix = False,
            Bool :$LC = False
            --> Str) is export(:oct2hex) {
    # need bases of incoming and outgoing number
    constant $base-i =  8;
    constant $base-o = 16;

    # need decimal intermediary
    my $dec = parse-base $oct, $base-i;
    my $hex = $dec.base: $base-o;
    pad-number $hex, $base-o, $len, :$prefix, :$LC;
    return $hex;
} # oct2hex

#------------------------------------------------------------------------------
# Subroutine: oct2dec
# Purpose : Convert an octal number (string) to a decimal number.
# Params  : Octal number (string), desired length (optional).
# Returns : Decimal number (or string).
sub oct2dec($oct where &octal, UInt $len = 0
            --> Cool) is export(:oct2dec) {
    # need bases of incoming and outgoing number
    constant $base-i =  8;
    constant $base-o = 10;

    my $dec = parse-base $oct, $base-i;
    pad-number $dec, $base-o, $len;
    return $dec;
} # oct2dec

#------------------------------------------------------------------------------
# Subroutine: bin2oct
# Purpose : Convert a binary number (string) to an octal number (string).
# Params  : Binary number (string), desired length (optional), prefix (optional).
# Returns : Octal number (string).
sub bin2oct($bin where &binary,
            UInt $len = 0,
            Bool :$prefix = False
            --> Str) is export(:bin2oct) {
    # need bases of incoming and outgoing number
    constant $base-i = 2;
    constant $base-o = 8;

    # need decimal intermediary
    my $dec = parse-base $bin, $base-i;
    my $oct = $dec.base: $base-o;
    pad-number $oct, $base-o, $len, :$prefix;
    return $oct;
} # bin2oct

#------------------------------------------------------------------------------
# Subroutine: dec2oct
# Purpose : Convert a non-negative integer to an octal number (string).
# Params  : Decimal number, desired length (optional), prefix (optional).
# Returns : Octal number (string).
sub dec2oct($dec where &decimal,
            UInt $len = 0,
            Bool :$prefix = False
            --> Cool) is export(:dec2oct) {
    # need base of outgoing number
    constant $base-o =  8;

    my $oct = $dec.base: $base-o;
    pad-number $oct, $base-o, $len, :$prefix;
    return $oct;
} # dec2oct

#------------------------------------------------------------------------------
# Subroutine: hex2oct
# Purpose : Convert a hexadecimal number (string) to an octal number (string).
# Params  : Hexadecimal number (string), desired length (optional), prefix (optional).
# Returns : Octal number (string).
sub hex2oct($hex where &hexadecimal, UInt $len = 0,
            Bool :$prefix = False
            --> Str) is export(:hex2oct) {
    # need bases of incoming and outgoing number
    constant $base-i = 16;
    constant $base-o =  8;

    # need decimal intermediary
    my $dec = parse-base $hex, $base-i;
    my $oct = $dec.base: $base-o;
    pad-number $oct, $base-o, $len, :$prefix;
    return $oct;
} # hex2oct

#------------------------------------------------------------------------------
# Subroutine: rebase
# Purpose : Convert any number (integer or string) and base (2..36) to a number in another base (2..36).
# Params  : Number (string), desired length (optional), prefix (optional), lower-case (optional).
# Returns : Desired number (decimal or string) in the desired base.
sub rebase($num-i,
           $base-i where &limited-bases, # change to "&all-bases" when ready
           $base-o where &limited-bases, # change to "&all-bases" when ready
           UInt $len = 0,
           Bool :$prefix = False,
           Bool :$LC = False
           --> Cool) is export(:baseM2baseN) {

    # make sure incoming number is in the right base
    if $num-i !~~ @base[$base-i] {
        die "FATAL: Incoming number in sub 'rebase' is not a member of base '$base-i'.";
    }

    # check for same bases
    if $base-i eq $base-o {
        die "FATAL: Both bases are the same ($base-i), no conversion necessary."
    }

    # check for known bases
    my ($bi, $bo);
    {
        when $base-i eq '2'  { $bi = 'bin' }
        when $base-i eq '8'  { $bi = 'oct' }
        when $base-i eq '16' { $bi = 'hex' }
    }
    {
        when $base-o eq '2'  { $bo = 'bin' }
        when $base-o eq '8'  { $bo = 'oct' }
        when $base-o eq '16' { $bo = 'hex' }
    }
    if $bi && $bo {
        note "NOTE: Use function '{$bi}2{$bo}' instead for an easier interface."
    }

    # treatment varies if in or out base is decimal
    my $num-o;
    if $base-i eq '10' {
        $num-o = $num-i.base: $base-o;
    }
    elsif $base-o eq '10' {
        $num-o = parse-base $num-i, $base-i;
    }
    elsif 1 < $base-o < 37 {
        # need decimal as intermediary
        my $dec = parse-base $num-i, $base-i;
        $num-o = $dec.base: $base-o;
    }
    else {
	die "FATAL: Unable to handle base conditions: \$base-i = $base-i, \$base-o = $base-o";
    }

    if $base-o eq '2' || $base-o eq '8' {
        pad-number $num-o, $base-o, $len, :$prefix;
    }
    elsif $base-o eq '16' {
        pad-number $num-o, $base-o, $len, :$prefix, :$LC;
    }
    elsif 10 < $base-o < 37 {
	# case insensitive bases
        pad-number $num-o, $base-o, $len, :$LC;
    }
    elsif 1 < $base-o < 11 {
	# case N/A bases
        pad-number $num-o, $base-o, $len;
    }
    else {
	die "FATAL: Unable to handle base conditions: \$base-i = $base-i, \$base-o = $base-o";
	# case SENSITIVE bases
        pad-number $num-o, $base-o, $len;
    }

    return $num-o;
} # rebase
