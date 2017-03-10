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
my token length-handling { ^ :i ignore|warn|fail $ }

# define tokens for common regexes
my token binary is export(:token-binary)                   { ^ <[01]>+ $ }
my token decimal is export(:token-decimal)                 { ^ \d+ $ }              # actually an int
my token hexadecimal is export(:token-hecadecimal)         { :i ^ <[a..f\d]>+ $ }   # multiple chars
my token hexadecimalchar is export(:token-hexadecimalchar) { :i ^ <[a..f\d]> $ }    # single char

#------------------------------------------------------------------------------
# Subroutine: hexchar2bin
# Purpose : Convert a single hexadecimal character to a binary string
# Params  : Hexadecimal character
# Returns : Binary string
sub hexchar2bin(Str:D $hexchar where &hexadecimalchar --> Str) is export(:hexchar2bin) {
    my $d = parse-base $hexchar, 16;

    my $decimal = hexchar2dec $hexchar;

    die "FATAL: decimal chars different between routine and mine" if $d ne $decimal;

    my $bin = sprintf "%04b", $decimal;
    return $bin;

} # hexchar2bin


#------------------------------------------------------------------------------
# Subroutine: hexchar2dec
# Purpose : Convert a single hexadecimal character to a decimal number
# Params  : Hexadecimal character
# Returns : Decimal number
sub hexchar2dec(Str:D $hexchar is copy where &hexadecimalchar --> UInt) is export(:hexchar2dec) {
    my UInt $num;

    my $d = parse-base $hexchar, 16;

    $hexchar .= lc;
    if $hexchar ~~ /^ \d $/ {
	# 0..9
	$num = +$hexchar;
    }
    elsif $hexchar eq 'a' {
	$num = 10;
    }
    elsif $hexchar eq 'b' {
	$num = 11;
    }
    elsif $hexchar eq 'c' {
	$num = 12;
    }
    elsif $hexchar eq 'd' {
	$num = 13;
    }
    elsif $hexchar eq 'e' {
	$num = 14;
    }
    elsif $hexchar eq 'f' {
	$num = 15;
    }
    else {
	fail "FATAL: \$hexchar '$hexchar' is unknown";
    }

    die "FATAL: decimal chars different between routine and mine" if $d ne $num;

    return $num;

} # hexchar2dec

#------------------------------------------------------------------------------
# Subroutine: hex2dec
# Purpose : Convert a positive hexadecimal number (string) to a decimal number
# Params  : Hexadecimal number (string), desired length (optional)
# Returns : Decimal number (or string)
sub hex2dec(Str:D $hex where &hexadecimal, UInt $len = 0 --> Cool) is export(:hex2dec) {

    my $d = parse-base $hex, 16;

    my @chars = $hex.comb;
    @chars .= reverse;
    #my UInt $decimal = 0;
    my $decimal = 0;
    my $power = 0;
    for @chars -> $c {
        $decimal += hexchar2dec($c) * 16 ** $power;
	++$power;
    }

    # get rid of leading zeroes
    $decimal ~~ s:g/^ 0//;
    $decimal = 0 if !$decimal;
    
    if $len && $len > $decimal.chars {
	$decimal = sprintf "%0*d", $len, $decimal;
	$d = sprintf "%0*d", $len, $d;
    }

    die "FATAL: decimal chars different between routine and mine" if $d ne $decimal;

    return $decimal;

} # hex2dec

#------------------------------------------------------------------------------
# Subroutine: hex2bin
# Purpose : Convert a positive hexadecimal number (string) to a binary string
# Params  : Hexadecimal number (string), desired length (optional)
# Returns : Binary number (string)
sub hex2bin(Str:D $hex where &hexadecimal, UInt $len = 0 --> Str) is export(:hex2bin) {

    my $d = parse-base $hex, 16; 
    my $b = $d.base: 2; 
    if $len && $len > $b.chars {
	my $s = '0' x ($len - $b.chars);
	$b = $s ~ $b;
     }

=begin pod
    my @chars = $hex.comb;
    my $bin = '';

    for @chars -> $c {
        $bin ~= hexchar2bin($c);
    }

    if $len && $len > $bin.chars {
	my $s = '0' x ($len - $bin.chars);
	$bin = $s ~ $bin;
     }
=end pod

    #return $bin;
    return $b;

} # hex2bin

#------------------------------------------------------------------------------
# Subroutine: dec2hex
# Purpose : Convert a positive integer to a hexadecimal number (string)
# Params  : Positive decimal number, desired length (optional)
# Returns : Hexadecimal number (string)
sub dec2hex(UInt $dec, UInt $len = 0 --> Str) is export(:dec2hex) {


    #my $hex = sprintf "%x", $dec;
    my $hex = lc $dec.base: 16;
    if $len && $len > $hex.chars {
	my $s = '0' x ($len - $hex.chars);
	$hex = $s ~ $hex;
    }
    return $hex;
} # dec2hex

#------------------------------------------------------------------------------
# Subroutine: dec2bin
# Purpose : Convert a positive integer to a binary number (string)
# Params  : Positive decimal number, desired length (optional)
# Returns : Binary number (string)
sub dec2bin(UInt $dec, UInt $len = 0 --> Str) is export(:dec2bin) {

    #my  $bin = sprintf "%b", $dec;
    my  $bin = lc $dec.base: 2;
    if $len && $len > $bin.chars {
	my $s = '0' x ($len - $bin.chars);
	$bin = $s ~ $bin;
    }
    return $bin;
} # dec2bin

#------------------------------------------------------------------------------
# Subroutine: bin2dec
# Purpose : Convert a binary number (string) to a decimal number
# Params  : Binary number (string), desired length (optional)
# Returns : Decimal number (or string)
sub bin2dec(Str:D $bin where &binary, UInt $len = 0 --> Cool) is export(:bin2dec) {

    my $decimal = parse-base $bin, 2;
=begin pod
    my @bits = $bin.comb;
    @bits .= reverse;
    my $decimal = 0;
    my $power = 0;
    for @bits -> $bit {
        $decimal += $bit * 2 ** $power;
	++$power;
    }
=end pod

    if $len && $len > $decimal.chars {
	my $s = '0' x ($len - $decimal.chars);
	$decimal = $s ~ $decimal;
    }
    return $decimal;
} # bin2dec

#------------------------------------------------------------------------------
# Subroutine: bin2hex
# Purpose : Convert a binary number (string) to a hexadecimal number (string)
# Params  : Binary number (string), desired length (optional)
# Returns : Hexadecimal number (string)
sub bin2hex(Str:D $bin where &binary, UInt $len = 0 --> Str) is export(:bin2hex) {

    my $dec = parse-base $bin, 2;
    my $hex = lc $dec.base: 16;
    if $len && $len > $hex.chars {
	my $s = '0' x ($len - $hex.chars);
	$hex = $s ~ $hex;
    }
=begin pod
    # take the easy way out
    my $dec = bin2dec($bin);
    my $hex = dec2hex($dec, $len);
=end pod

    return $hex;
} # bin2hex
