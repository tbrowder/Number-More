unit module Number::More;

use experimental :cached;


my $DEBUG = 0;

# export a var for users to set length behavior
our $LENGTH-HANDLING is export(:DEBUG) = 'ignore'; # other options: 'warn', 'fail'
my token length-action { ^ :i warn|fail $ }

our $bset = "01".comb.Set;
our $oset = (0..7).Set;
our $dset = (0..9).Set;
our $hset = "abcdef".comb.Set (|) $dset;

# define tokens for common regexes (no prefixes are allowed)
my token binary is export(:token-binary)            { ^ <[01]>+ $ }
my token octal is export(:token-octal)              { ^ <[0..7]>+ $ }
my token decimal is export(:token-decimal)          { ^ \d+ $ } # actually an int
my token hexadecimal is export(:token-hecadecimal)  { :i ^ <[a..f\d]>+ $ }   

# for general base functions 2..62
my token all-bases is export(:token-all-bases)      { ^ 
                                                        <[2..9]>         | 
                                                        <[1..5]><[0..9]> |
                                                        6 <[0..2]> 
                                                    $ }
# Standard digit set for bases 2 through 62 (char 0 through 61)
# the array of digits is indexed by their decimal value (note
# the %dec2digit hash can be created programmatically from this
# array):
our @dec2digit is export(:dec2digit) = <
    0 1 2 3 4 5 6 7 8 9
    A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
    a b c d e f g h i j k l m n o p q r s t u v w x y z
    >;

# Standard digit set for bases 2 through 62 (char 0 through 61)
# the hash is comprised of digit keys and their decimal value
sub digit2dec(
    $char,
    --> Int
    ) is cached is export(:digit2dec) {

    my %h;
    unless %h{$char}:exists {
        for @dec2digit.kv -> $i, $c is copy {
            #$c = "'$c'";
            %h{$c} = $i; 
            last if $c eq $char;
        }
    } 
    my $dec = %h{$char}.Int;
    $dec;
}

=begin comment
our %digit2dec is export(:digit2dec) = [
    0 =>  0, 1 =>  1, 2 =>  2, 3 =>  3, 4 =>  4, 
             5 =>  5, 6 =>  6, 7 =>  7, 8 =>  8, 9 =>  9,
    A => 10, B => 11, C => 12, D => 13, E => 14, 
             F => 15, G => 16, H => 17, I => 18, J => 19,
    K => 20, L => 21, M => 22, N => 23, O => 24, 
             P => 25, Q => 26, R => 27, S => 28, T => 29,
    U => 30, V => 31, W => 32, X => 33, Y => 34, 
             Z => 35, a => 36, b => 37, c => 38, d => 39,
    e => 40, f => 41, g => 42, h => 43, i => 44, 
             j => 45, k => 46, l => 47, m => 48, n => 49,
    o => 50, p => 51, q => 52, r => 53, s => 54, 
             t => 55, u => 56, v => 57, w => 58, x => 59,
    y => 60, z => 61
];
=end comment

my token base { ^ 2|8|10|16 $ }

# This is a sub
sub pad-number(
    $num is rw,
    UInt $base where &all-bases,
    # optional args
    :$length is copy, # for padding
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
) {
    my UInt $len = $num.chars;

    $length = 0 if not $length.defined;
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # This also checks for length error, upper-lower casing, and handling
    if 10 < $base < 37 {
        if $LC {
	    # special feature for case-insensitive bases
            $num .= lc;
        }
    }

    my $nc  = $num.chars;
    # num chars with prefix
    my $nct = ($prefix && !$suffix) ?? ($nc + 2) !! $nc;
    if ($length and ($LENGTH-HANDLING ~~ (&length-action)) and ($nct > $length)) {
        my $msg = "Desired length ($length) of number '$num' is\
                     less than required by it";
        $msg ~= " and its prefix" if $prefix;
        $msg ~= " ($nct).";

        if $LENGTH-HANDLING ~~ /$ :i warn $/ {
            note "WARNING: $msg";
        }
        else {
            die "FATAL: $msg";
        }
    }

    if $length > $nct {
        # padding required
        # first pad with zeroes
        # create the zero padding
        my $zpad = 0 x ($length - $nct);
        $num = $zpad ~ $num;

        # the following test should always be true!!
        if $len {
            die "debug FATAL: unexpected \$length ($length)\
                NOT greater than \$nc ($nc)";
        }
    }

    if $suffix {
        $num .= Str;
	$num ~= "_base-$base";
    }
    elsif $prefix {
        when $base eq '2'  { $num = '0b' ~ $num }
        when $base eq '8'  { $num = '0o' ~ $num }
        when $base eq '10' { $num = '0d' ~ $num }
        when $base eq '16' { $num = '0x' ~ $num }
    }

} # pad-number

#------------------------------------------------------------------------------
# Subroutine: hex2dec
# Purpose : Convert a non-negative hexadecimal number (string) to a decimal number.
# Params  : Hexadecimal number (string), desired length (optional), suffix (optional).
# Returns : Decimal number (or string).
sub hex2dec(
    Str:D $hex where &hexadecimal,
    # optional args
    :$prefix is copy,
    :$suffix is copy,
    --> Cool
) is export(:hex2dec) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;

    # need bases of incoming and outgoing number
    constant $base-i = 16;
    constant $base-o = 10;

    my $dec = parse-base $hex, $base-i;
    pad-number $dec, $base-o, :$prefix, :$suffix;

    $dec;
} # hex2dec

#------------------------------------------------------------------------------
# Subroutine: hex2bin
# Purpose : Convert a non-negative hexadecimal number (string) to a binary string.
# Params  : Hexadecimal number (string), desired length (optional), prefix (optional), suffix (optional).
# Returns : Binary number (string).
sub hex2bin(
    Str:D $hex where &hexadecimal,
    # optional args
    :$prefix is copy,
    :$suffix is copy,
    --> Str
) is export(:hex2bin) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;

    # need bases of incoming and outgoing number
    constant $base-i = 16;
    constant $base-o =  2;

    # have to get decimal first
    my $dec = parse-base $hex, $base-i;
    my $bin = $dec.base: $base-o;

    pad-number $bin, $base-o, :$prefix, :$suffix;

    $bin;
} # hex2bin

#------------------------------------------------------------------------------
# Subroutine: dec2hex
# Purpose : Convert a non-negative integer to a hexadecimal number (string).
# Params  : Non-negative decimal number, desired length (optional), prefix (optional), suffix (optional), lower-case (optional).
# Returns : Hexadecimal number (string).
sub dec2hex(
    $dec where &decimal,
    # optional args
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    --> Str
) is export(:dec2hex) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need base of outgoing number
    constant $base-o = 16;

    my $hex = $dec.base: $base-o;
    pad-number $hex, $base-o, :$prefix, :$suffix, :$LC;

    $hex;
} # dec2hex

#------------------------------------------------------------------------------
# Subroutine: dec2bin
# Purpose : Convert a non-negative integer to a binary number (string).
# Params  : Non-negative decimal number, desired length (optional), prefix (optional), suffix (optional).
# Returns : Binary number (string).
sub dec2bin(
    $dec where &decimal,
    # optional args
    :$prefix is copy,
    :$suffix is copy,
    --> Str
) is export(:dec2bin) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;

    # need base of outgoing number
    constant $base-o = 2;

    my $bin = $dec.base: $base-o;
    pad-number $bin, $base-o, :$prefix, :$suffix;

    $bin;
} # dec2bin

#------------------------------------------------------------------------------
# Subroutine: bin2dec
# Purpose : Convert a binary number (string) to a decimal number.
# Params  : Binary number (string), desired length (optional), suffix (optional).
# Returns : Decimal number (or string).
sub bin2dec(
    Str:D $bin where &binary,
    # optional args
    :$suffix is copy,
    :$debug,
    --> Cool
) is export(:bin2dec) {
    $suffix = 0 if not $suffix.defined;

    # need bases of incoming and outgoing numbers
    constant $base-i =  2;
    constant $base-o = 10;

    my $dec = parse-base $bin, $base-i;
    pad-number $dec, $base-o, :$suffix;

    $dec;
} # bin2dec

#------------------------------------------------------------------------------
# Subroutine: bin2hex
# Purpose : Convert a binary number (string) to a hexadecimal number (string).
# Params  : Binary number (string), desired length (optional), prefix (optional), suffix (optional), lower-case (optional).
# Returns : Hexadecimal number (string).
sub bin2hex(
    Str:D $bin where &binary,
    # optional args
    :$prefix is copy, 
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Str
) is export(:bin2hex) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing number
    constant $base-i =  2;
    constant $base-o = 16;

    # need decimal intermediary
    my $dec = parse-base $bin, $base-i;
    my $hex = $dec.base: $base-o;
    pad-number $hex, $base-o, :$prefix, :$suffix, :$LC;

    $hex;
} # bin2hex

#------------------------------------------------------------------------------
# Subroutine: oct2bin
# Purpose : Convert an octal number (string) to a binary number (string).
# Params  : Octal number (string), desired length (optional), prefix (optional), suffix (optional).
# Returns : Binary number (string).
sub oct2bin(
    $oct where &octal,
    # optional args
    :$prefix is copy,
    :$suffix is copy,
    --> Str
) is export(:oct2bin) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;

    # need bases of incoming and outgoing number
    constant $base-i = 8;
    constant $base-o = 2;

    # need decimal intermediary
    my $dec = parse-base $oct, $base-i;
    my $bin = $dec.base: $base-o;
    pad-number $bin, $base-o, :$prefix, :$suffix;

    $bin;
} # oct2bin

#------------------------------------------------------------------------------
# Subroutine: oct2hex
# Purpose : Convert an octal number (string) to a hexadecimal number (string).
# Params  : Octal number (string), desired length (optional), prefix (optional), suffix (optional), lower-case (optional).
# Returns : Hexadecimal number (string).
sub oct2hex(
    $oct where &octal, 
    UInt $len = 0,
    # optional args
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    --> Str
) is export(:oct2hex) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # need bases of incoming and outgoing number
    constant $base-i =  8;
    constant $base-o = 16;

    # need decimal intermediary
    my $dec = parse-base $oct, $base-i;
    my $hex = $dec.base: $base-o;
    pad-number $hex, $base-o, :$prefix, :$suffix, :$LC;

    $hex;
} # oct2hex

#------------------------------------------------------------------------------
# Subroutine: oct2dec
# Purpose : Convert an octal number (string) to a decimal number.
# Params  : Octal number (string), desired length (optional), suffix (optional).
# Returns : Decimal number (or string).
sub oct2dec(
    $oct where &octal, 
    UInt $len = 0,
    # optional args
    :$suffix is copy,
    --> Cool
) is export(:oct2dec) {
    $suffix = 0 if not $suffix.defined;

    # need bases of incoming and outgoing number
    constant $base-i =  8;
    constant $base-o = 10;

    my $dec = parse-base $oct, $base-i;
    pad-number $dec, $base-o, :$suffix;

    $dec;
} # oct2dec

#------------------------------------------------------------------------------
# Subroutine: bin2oct
# Purpose : Convert a binary number (string) to an octal number (string).
# Params  : Binary number (string), desired length (optional), prefix (optional), suffix (optional).
# Returns : Octal number (string).
sub bin2oct(
    $bin where &binary,
    # optional args
    :$prefix is copy,
    :$suffix is copy,
    :$debug,
    --> Str
) is export(:bin2oct) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;

    # need bases of incoming and outgoing number
    constant $base-i = 2;
    constant $base-o = 8;

    # need decimal intermediary
    my $dec = parse-base $bin, $base-i;
    my $oct = $dec.base: $base-o;

    pad-number $oct, $base-o, :$prefix, :$suffix;

    $oct;
} # bin2oct

#------------------------------------------------------------------------------
# Subroutine: dec2oct
# Purpose : Convert a non-negative integer to an octal number (string).
# Params  : Decimal number, desired length (optional), prefix (optional), suffix (optional).
# Returns : Octal number (string).
sub dec2oct(
    $dec where &decimal,
    # optional args
    :$prefix is copy,
    :$suffix is copy,
    --> Cool
) is export(:dec2oct) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;

    # need base of outgoing number
    constant $base-o =  8;

    my $oct = $dec.base: $base-o;
    pad-number $oct, $base-o, :$prefix, :$suffix;

    $oct;
} # dec2oct

#------------------------------------------------------------------------------
# Subroutine: hex2oct
# Purpose : Convert a hexadecimal number (string) to an octal number (string).
# Params  : Hexadecimal number (string), desired length (optional), prefix (optional), suffix (optional).
# Returns : Octal number (string).
sub hex2oct(
    $hex where &hexadecimal, 
    UInt $len = 0,
    # optional args
    :$prefix is copy,
    :$suffix is copy,
    --> Str
) is export(:hex2oct) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;

    # need bases of incoming and outgoing number
    constant $base-i = 16;
    constant $base-o =  8;

    # need decimal intermediary
    my $dec = parse-base $hex, $base-i;
    my $oct = $dec.base: $base-o;
    pad-number $oct, $base-o, :$prefix, :$suffix;

    $oct;
} # hex2oct

#------------------------------------------------------------------------------
# Subroutine: rebase
# Purpose : Convert any number (integer or string) and base (2..62) to a number in another base (2..62).
# Params  : Number (string), desired length (optional), prefix (optional), suffix (optional), suffix (optional), lower-case (optional).
# Returns : Desired number (decimal or string) in the desired base.
sub rebase(
    $num-i,
    $base-i where &all-bases,
    $base-o where &all-bases,
    # optional args
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    :$debug,
    --> Cool
) is export(:baseM2baseN) {
    $prefix = 0 if not $prefix.defined;
    $suffix = 0 if not $suffix.defined;
    $LC     = 0 if not $LC.defined;

    # make sure incoming number is in the right base
#note "DEBUG: num-i = '$num-i'; base $base-i regex |{@base[$base-i].gist}|";
#note "  early exit"; exit;

    my $bset = create-base-set $base-i;
    my $nset = create-set $num-i;

    unless $nset (<=) $bset {
        die "FATAL: Incoming number '$num-i' in sub 'rebase' is\
              not a member of base '$base-i'.";
    }
    =begin comment
    if $num-i !~~ @base[$base-i] {
        die "FATAL: Incoming number '$num-i' in sub 'rebase' is\
              not a member of base '$base-i'.";
    }
    =end comment

    # check for same bases
    if $base-i eq $base-o {
        die "FATAL: Both bases are the same ($base-i), no conversion necessary."
    }

    # check for known bases, eliminate any prefixes
    my ($bi, $bo);
    {
        when $base-i == 2  {
	    $bi = 'bin';
	    $num-i ~~ s:i/^0b//;
	}
        when $base-i == 8  {
	    $bi = 'oct';
	    $num-i ~~ s:i/^0o//;
	}
        when $base-i == 10  {
	    $bi = 'dec';
	    $num-i ~~ s:i/^0d//;
	}
        when $base-i == 16 {
	    $bi = 'hex';
	    $num-i ~~ s:i/^0x//;
	}
    }
    {
        when $base-o == 2  { $bo = 'bin' }
        when $base-o == 8  { $bo = 'oct' }
        when $base-o == 10 { $bo = 'dec' }
        when $base-o == 16 { $bo = 'hex' }
    }

    if $bi and $bo and (0 or $debug) {
        note "\nDEBUG Use function '{$bi}2{$bo}' instead for an easier interface.";
    }

    # treatment varies if in or out base is decimal
    my $num-o;
    if $base-i == 10 {
	if $base-o < 37 {
            $num-o = $num-i.base: $base-o;
	}
	else {
            $num-o = _from-dec-to-b37-b62 $num-i, $base-o;
	}
    }
    elsif $base-o == 10 {
	if $base-i < 37 {
            $num-o = parse-base $num-i, $base-i;
	}
	else {
	    $num-o = _to-dec-from-b37-b62 $num-i, $base-i;
	}
    }
    elsif ($base-i < 37) and ($base-o < 37) {
        # need decimal as intermediary
        my $dec = $num-i.parse-base: $base-i;
        $num-o  = $dec.base: $base-o;
    }
    else {
        # need decimal as intermediary
	my $dec;
	if $base-i < 37 {
            $dec = $num-i.parse-base: $base-i;
	}
	else {
	    $dec = _to-dec-from-b37-b62 $num-i, $base-i;
	}

        # then convert to desired base
	if $base-o < 37 {
            $num-o = $dec.base: $base-o;
	}
	else {
            $num-o = _from-dec-to-b37-b62 $dec, $base-o;
	}
    }

    # Finally, pad the number, make upper-case, and add prefix or suffix as
    # appropriate
    if $base-o == 2 || $base-o == 8 || $base-o == 10 {
        pad-number $num-o, $base-o, :$prefix, :$suffix;
    }
    elsif $base-o == 16 {
        pad-number $num-o, $base-o, :$prefix, :$suffix, :$LC;
    }
    elsif (10 < $base-o < 37) {
	# case insensitive bases
        pad-number $num-o, $base-o, :$LC, :$suffix;
    }
    elsif (1 < $base-o < 11) {
	# case N/A bases
        pad-number $num-o, $base-o, :$suffix;
    }
    else {
	# case SENSITIVE bases
        pad-number $num-o, $base-o, :$suffix;
    }

    $num-o;
} # rebase


sub _to-dec-from-b37-b62(
    $num,
    #$base-i where { 36 < $base-i < 63 },
    UInt $base-i where ( 36 < $base-i < 63 ),
    --> Cool
) is export(:_to-dec-from-b37-b62) {

=begin comment
# see simple algorithm for base to dec:

Let's say you have a number

  10121 in base 3

and you want to know what it is in base 10.  Well, in base three the
place values [from the highest] are

   4   3  2  1  0 <= digit place (position)
  81, 27, 9, 3, 1 <= value: digit x base ** place

so we have 1 x 81 + 0 x 27 + 1 x 9 + 2 x 3 + 1 x 1

  81 + 0 + 9 + 6 + 1 = 97

that is how it works.  You just take the number, figure out the place
values, and then add them together to get the answer.  Now, let's do
one the other way.

45 in base ten (that is the normal one.) Let's convert it to base
five.

Well, in base five the place values will be 125, 25, 5, 1

We won't have any 125's but we will have one 25. Then we will have 20
left.  That is four 5's, so in base five our number will be 140.

Hope that makes sense.  If you don't see a formula, try to work out a
bunch more examples and they should get easier.

-Doctor Ethan,  The Math Forum

=end comment

    # reverse the digits (chars) of the input number
    my @num'r = $num.comb.reverse;
    my $place = $num.chars;

    my $dec = 0;
    
    for @num'r -> $char  {
	--$place; # first place is num chars - 1
        if $char ~~ /:i z/ {
            note "DEBUG: input char is '$char', place = $place" if $DEBUG;
        }
	# need to convert the digit to dec first
	#my $digit-val = %digit2dec{$char};
	my $digit-val = digit2dec $char;
        if $char ~~ /:i z/ {
            note "DEBUG: input char is '$char', digit val is $digit-val" if $DEBUG;
        }
	my $val = $digit-val * $base-i ** $place;
	$dec += $val;
    }

    $dec;
} # _to-dec-from-b37-b62

=begin comment

General method of converting a whole number (decimal) to base b
(from Wolfram, see [Base] in README.md references):

the index of the leading digit needed to represent the number x in
base b is:

  n = floor (log_b x) [see computing log_b below]

then recursively compute the successive digits:

  a_i = floor r_i / b_i )

where r_n = x and

  r_(i-1) = r_i - a_i * b^i

for i = n, n -1, ..., 1, 0

to convert between logarithms in different bases, the formula:

  log_b x = ln x / ln b

=end comment

sub _from-dec-to-b37-b62(
      UInt $x'dec,
      UInt $base-o where ( 36 < $base-o < 63 ),
      --> Str
) is export(:_from-dec-to-b37-b62) {

    # see Wolfram's solution (article Base, see notes above)

    # need ln_b x = ln x / ln b

    # note Raku routine 'log' is math function 'ln' if no optional base
    # arg is entered
    my $log_b'x = log $x'dec / log $base-o;

    # get place index of first digit
    my $n = floor $log_b'x;

    # now the algorithm
    # we need @r below to be a fixed array of size $n + 2
    my @r[$n + 2];
    my @a[$n + 1];

    @r[$n] = $x'dec;

    # TODO FIX THIS
    # work through the $x'dec.chars places (positions, indices?)
    # for now just handle integers (later, real, i.e., digits after a fraction point)
    my @rev = (0..$n).reverse;
    #for $n...0 -> $i { # <= Wolfram text is misleading here
    for @rev -> $i { # <= Wolfram text is misleading here
	my $b'i  = $base-o ** $i;
	@a[$i]   = floor (@r[$i] / $b'i);

        say "  i = $i; a = '@a[$i]'; r = '@r[$i]'" if 1 or $DEBUG;

        # calc r for next iteration
	@r[$i-1] = @r[$i] - @a[$i] * $b'i if $i > 0;
    }

    # @a contains the index of the digits of the number in the new base
    my $x'b = '';
    # digits are in the reversed order
    for @a.reverse -> $di {
        my $digit = @dec2digit[$di];
        $x'b ~= $digit;
    }

    # trim leading zeroes
    $x'b ~~ s/^ 0+ /0/;
    $x'b ~~ s:i/^ 0 (<[0..9a..z]>) /$0/;

    $x'b;
} # _from-dec-to-b37-b62

# subs moved here from t/7*t
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
    UInt $base where ( 1 < $base < 63 ),
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

    if $debug {
        say "DEBUG base $base, first char is char index $F, char '$FC'";
        say "                   last char is char index $L, char '$LC'";
    }

    my $chars = @dec2digit[$F..$L].join;

    my %h;
    if not $CS {
        for $chars.comb -> $c is copy {
            $c .= Str;
            $c .= uc;
            %h{$c} = True;
        }
    }
    else {
        for $chars.comb -> $c is copy {
            $c .= Str;
            %h{$c} = True;
        }
    }
    %h.Set;
}

