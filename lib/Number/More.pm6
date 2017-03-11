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

# for some future base functions
my token base3 is export(:token-base3)              { ^ <[012]>+ $ }
my token base4 is export(:token-base4)              { ^ <[0..3]>+ $ }
my token base5 is export(:token-base5)              { ^ <[0..4]>+ $ }
my token base6 is export(:token-base6)              { ^ <[0..5]>+ $ }
my token base7 is export(:token-base7)              { ^ <[0..6]>+ $ }
# base 8 is octal
my token base9 is export(:token-base9)              { ^ <[0..8]>+ $ }
# base 10 is decimal
my token base11 is export(:token-base11)            { :i ^ <[a\d]>+ $ }      # multiple chars
my token base12 is export(:token-base12)            { :i ^ <[ab\d]>+ $ }     # multiple chars
my token base13 is export(:token-base13)            { :i ^ <[abc\d]>+ $ }    # multiple chars
my token base14 is export(:token-base14)            { :i ^ <[a..d\d]>+ $ }   # multiple chars
my token base15 is export(:token-base15)            { :i ^ <[a..e\d]>+ $ }   # multiple chars
# base 16 is hexadecimal
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
my token base36 is export(:token-base35)            { :i ^ <[a..z\d]>+ $ }   # multiple chars



my token base { ^ 2|8|10|16 $ }

sub pad-number($num is rw, 
               UInt $base where &base, 
               UInt $len = 0, 
               Bool :$prefix = False,
               Bool :$UC = False) {

    # this also checks for length error, upper-lower casing, and handling
    if $base == 16 {
        if $UC {
            $num .= uc
        }
        else {
            $num .= lc
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
# Purpose : Convert a positive hexadecimal number (string) to a decimal number
# Params  : Hexadecimal number (string), desired length (optional)
# Returns : Decimal number (or string)
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
# Purpose : Convert a positive hexadecimal number (string) to a binary string
# Params  : Hexadecimal number (string), desired length (optional)
# Returns : Binary number (string)
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
# Purpose : Convert a positive integer to a hexadecimal number (string)
# Params  : Positive decimal number, desired length (optional)
# Returns : Hexadecimal number (string)
sub dec2hex($dec where &decimal, 
            UInt $len = 0,
            Bool :$prefix = False,
            Bool :$UC = False --> Str) is export(:dec2hex) {
    # need base of outgoing number
    constant $base-o = 16;

    my $hex = $dec.base: $base-o;
    pad-number $hex, $base-o, $len, :$prefix, :$UC;
    return $hex;
} # dec2hex

#------------------------------------------------------------------------------
# Subroutine: dec2bin
# Purpose : Convert a positive integer to a binary number (string)
# Params  : Positive decimal number, desired length (optional)
# Returns : Binary number (string)
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
# Purpose : Convert a binary number (string) to a decimal number
# Params  : Binary number (string), desired length (optional)
# Returns : Decimal number (or string)
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
# Purpose : Convert a binary number (string) to a hexadecimal number (string)
# Params  : Binary number (string), desired length (optional)
# Returns : Hexadecimal number (string)
sub bin2hex(Str:D $bin where &binary, 
            UInt $len = 0,
            Bool :$prefix = False,
            Bool :$UC = False --> Str) is export(:bin2hex) {
    # need bases of incoming and outgoing number
    constant $base-i =  2;
    constant $base-o = 16;

    # need decimal intermediary
    my $dec = parse-base $bin, $base-i;
    my $hex = $dec.base: $base-o;
    pad-number $hex, $base-o, $len, :$prefix, :$UC;
    return $hex;
} # bin2hex

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

sub oct2hex($oct where &octal, UInt $len = 0, 
            Bool :$prefix = False,
            Bool :$UC = False
            --> Str) is export(:oct2hex) {
    # need bases of incoming and outgoing number
    constant $base-i =  8;
    constant $base-o = 16;

    # need decimal intermediary
    my $dec = parse-base $oct, $base-i;
    my $hex = $dec.base: $base-o;
    pad-number $hex, $base-o, $len, :$prefix, :$UC;
    return $hex;
} # oct2hex

sub oct2dec($oct where &octal, UInt $len = 0 
            --> Cool) is export(:oct2dec) {
    # need bases of incoming and outgoing number
    constant $base-i =  8;
    constant $base-o = 10;

    my $dec = parse-base $oct, $base-i;
    pad-number $dec, $base-o, $len;
    return $dec;
} # oct2dec

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

