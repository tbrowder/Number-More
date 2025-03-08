#!/bin/env raku

use Font::FreeType;
use Font::FreeType::Glyph;
use Font::FreeType::Outline;
use Font::FreeType::Raw::Defs;

my @fonts = <
fonts/GnuMICR.otf
fonts/micrenc.ttf
fonts/CMC7.ttf
>;

# desired codepoints:
# codepoints to show for the micre and the cmc7 fonts
# gnumicr 20 30 31 32 33 34 35 36 37 39 41 42 43 44             A9 
# micrenc 20 30 31 32 33 34 35 36 37 39 41 42 43 44 61 62 63 64    E0 
# cmc7    20 30 31 32 33 34 35 36 37 39 41 42 43 44 61 62 63 64       

my @f1cp = <gnumicr 20 30 31 32 33 34 35 36 37 39 41 42 43 44             A9>; 
my @f2cp = <micrenc 20 30 31 32 33 34 35 36 37 39 41 42 43 44 61 62 63 64    E0>; 
my @f3cp = <cmc7    20 30 31 32 33 34 35 36 37 39 41 42 43 44 61 62 63 64>; 

# create a string from codepoints
# to-string @f1cp;
sub to-string(@cplist) {
    # given a list of hex codepoints, convert them to a string repr
    # the first item in the list may be a string label
    my @list = @cplist;
    if @list.head ~~ Str { @list.shift };
    my $s = "";
    for @list -> $cpair {
        say "char pair '$cpair'";
        # convert from hex to decimal
        my $x = parse-base $cpair, 16;
        # get its char
        my $c = $x.chr;
        say "   its character: '$c'";
    }
}

#=finish
# tmp end

my $mapped = True;
my $all   = 0; # if true, show unmapped glyphs
my $debug = 0;
my $fnam; # the input font filename
if not @*ARGS {
    print qq:to/HERE/;
    Usage: {$*PROGRAM.basename} 1 | 2 | 3 [debug]

    Show glyphs for codepoints in the input file number:

    HERE
    my $n = 1;
    for @fonts {
        say "  $n - $_";
        ++$n;
    }

    print qq:to/HERE/;

    all - also show unmapped glyphs
    HERE

    exit;
}

for @*ARGS {
    when /1|2|3/ {
        $fnam = @fonts[$_-1];
    }
    when /^:i d $/ {
        ++$debug;
    }
    when /^:i a $/ {
        ++$all;
        $mapped = False;
    }
    default {
        $fnam = $_;
    }
}

list-chars $fnam, :$mapped;

# dump all characters that are mapped to a font
sub list-chars(
    Str $filename, 
    Bool :$mapped = True,
    :$debug) {

    my $face = Font::FreeType.new.face($filename);

    my @charmap;
    $face.forall-chars: :!load, :flags(FT_LOAD_NO_RECURSE), 
        -> Font::FreeType::Glyph:D $_ {

        my $bbox = $_.is-outline ?? $_.outline.bbox !! False;
        my $char = .char-code.chr;
        @charmap[.index] = $char;
        if $mapped {
            my $txt = join("\t", 'x' ~ .char-code.base(16) ~ '[' ~ .index ~ ']',
                '/' ~ (.name//''),
                $char.uniname,
                $char.raku
            );
            say "$txt";
        }
        my $ccode = .char-code; # <== decimal
        say "    char code: $ccode";
        say "    char     : '$char'";
        if $bbox {
            say "    has bbox==== [$bbox]";
        }
    }

    if not $mapped {
        # output unmapped glyphs
        $face.forall-chars: :load, :flags(FT_LOAD_NO_RECURSE), 
            -> Font::FreeType::Glyph:D $_ {

            if .index && !@charmap[.index] {
                say join("\t", '[' ~ .index ~ ']', '/' ~ (.name//''), 
                    .raku
                );
            }
        }
    }
}
