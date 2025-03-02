#!/usr/bin/env raku

=begin comment

2024-10-17 #raku

lizmat on map howto:

my @b = @a.map({...})
# same as:
my @b = do for @a {...}

=end comment
my @a = <a b c>;

#my %b = @a.map({
@a.map({
            #say .kv; #keys;
            #say .values;
            #say $_.head;
            #say $_.tail;
#            my $pair  say $_;
#            say $_.^name;
            #my @b = $_.lines;
            my @b = $_.words;
            say "index: ", @b.head;
            say "   value: ", @b.tail;
        })

