# Number::More

[![Build Status](https://travis-ci.org/tbrowder/Number-More-Perl6.svg?branch=master)]
  (https://travis-ci.org/tbrowder/Number-More-Perl6)

## Synopsis


## The Number::More module

This module provides some convenience functions to convert unsigned integers between different, commonly used 
number bases: decimal, hexadecimal, octal, and binary. The default for each function is to take a string representing
a valid number in one base and transform it into the desired base with no leading zeroes or leading decoration (such
as '0x', '0o', and '0b') to indicate
the type of number.  The default is also to use lower-case characters for the hexadecimal results.  There are named
parameters to have hexadecimal results in upper-case, add appropriate decoration to transformed numbers, and to
define desired lengths of results (which will result in adding leading zeroes if needed).  Note that requested 
decoration will take up two characters in the requested length. The use can also set a variable to
set the reponse to situations where the transformed length is greater than the requested length: (1) ignore and provide
the required length (the default), (2) warn of the increased length but provide it, and (3) throw an exception
and report the offending data.





