unit module Helpers;

#my \BIN = 2;
#my \OCT = 8;
#my \DEC = 10;
#my \HEX = 16;

# we do NOT write any tests that are expected to fail (such as using :prefix
# and :suffix at the same time

sub write-test-base(
    $num,
    :$bi where ( $bi ~~ /2|8|10|16/ ), 
    :$bo where ( $bo ~~ /2|8|10|16/ ), 
    :$fh,
    # optional arguments
    :$nl is copy, # just for separating groups of tests
    :$length is copy,
    :$prefix is copy,
    :$suffix is copy,
    :$LC is copy,
    ) is export {

    $nl     = 0 unless $nl.defined;
    $length = 0 unless $length.defined;
    $prefix = 0 unless $prefix.defined;
    $suffix = 0 unless $suffix.defined;
    $LC     = 0 unless $LC.defined;

    my $BI;
    my $BO;
    with $bi {
        when /2/  { $BI = "bin" }
        when /8/  { $BI = "oct" }
        when /10/ { $BI = "dec" }
        when /16/ { $BI = "hex" }
    }
    with $bo {
        when /2/  { $BO = "bin" }
        when /8/  { $BO = "oct" }
        when /10/ { $BO = "dec" }
        when /16/ { $BO = "hex" }
    }

    # typical tests
    #   $r = hex2hex $num;
    #   is $r, $num;
    #   $r = hex2hex $num, :prefix;
    #   is $r, "0x1";
    $fh.say() if $nl;
    $fh.print: "\$r = {$BI}2$BO\(";
    # $num must be real for dec input
    if $BI == 10 {
        $fh.print: $num;
    }
    else {
        $fh.print: "'$num'";
    }

    if $length {
        $fh.print: ", :\$length";
    }
    if $prefix {
        $fh.print: ", :prefix";
    }
    elsif $suffix {
        $fh.print: ", :suffix";
    }
    if $LC {
        $fh.print: ", :LC";
    }
    $fh.say: ");";

    # write the actual tests
    if $length and $prefix {
        #my $n = $prefix ?? 6 !! 4;
        #$fh.say: "is \$r.chars, $n;";
        $fh.say: "is \$r.chars, $length;";
    }
}
