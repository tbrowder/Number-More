use Test;

use Number::More :ALL;

plan 80;

my $debug = 1;

is rebase(642, 10, 3), "212210", "test 1";
is rebase("1010000010", 2, 3), "212210", "test 2";
is rebase("1202", 8, 3), "212210", "test 3";
is rebase("282", 16, 3), "212210", "test 4";

is rebase(3612, 10, 4), "320130", "test 5";
is rebase("111000011100", 2, 4), "320130", "test 6";
is rebase("7034", 8, 4), "320130", "test 7";
is rebase("e1c", 16, 4), "320130", "test 8";

is rebase(2832, 10, 5), "42312", "test 9";
is rebase("101100010000", 2, 5), "42312", "test 10";
is rebase("5420", 8, 5), "42312", "test 11";
is rebase("b10", 16, 5), "42312", "test 12";

is rebase(5735, 10, 6), "42315", "test 13";
is rebase("1011001100111", 2, 6), "42315", "test 14";
is rebase("13147", 8, 6), "42315", "test 15";
is rebase("1667", 16, 6), "42315", "test 16";

is rebase(15251, 10, 7), "62315", "test 17";
is rebase("1110111001011", 2, 7), "62315", "test 18";
is rebase("35623", 8, 7), "62315", "test 19";
is rebase("3693", 16, 7), "62315", "test 20";

is rebase(4615, 10, 9), "6287", "test 21";
is rebase("1001000000111", 2, 9), "6287", "test 22";
is rebase("11007", 8, 9), "6287", "test 23";
is rebase("1207", 16, 9), "6287", "test 24";

is rebase(13396, 10, 11), "a079", "test 25";
is rebase("11010001010100", 2, 11), "a079", "test 26";
is rebase("32124", 8, 11), "a079", "test 27";
is rebase("3454", 16, 11), "a079", "test 28";

is rebase(17375, 10, 12), "a07b", "test 29";
is rebase("100001111011111", 2, 12), "a07b", "test 30";
is rebase("41737", 8, 12), "a07b", "test 31";
is rebase("43df", 16, 12), "a07b", "test 32";

is rebase(1949, 10, 13), "b8c", "test 33";
is rebase("11110011101", 2, 13), "b8c", "test 34";
is rebase("3635", 8, 13), "b8c", "test 35";
is rebase("79d", 16, 13), "b8c", "test 36";

is rebase(34290, 10, 14), "c6d4", "test 37";
is rebase("1000010111110010", 2, 14), "c6d4", "test 38";
is rebase("102762", 8, 14), "c6d4", "test 39";
is rebase("85f2", 16, 14), "c6d4", "test 40";

is rebase(49562, 10, 15), "ea42", "test 41";
is rebase("1100000110011010", 2, 15), "ea42", "test 42";
is rebase("140632", 8, 15), "ea42", "test 43";
is rebase("c19a", 16, 15), "ea42", "test 44";

is rebase(71753, 10, 17), "e94d", "test 45";
is rebase("10001100001001001", 2, 17), "e94d", "test 46";
is rebase("214111", 8, 17), "e94d", "test 47";
is rebase("1849", 16, 17), "e94d", "test 48";

is rebase(81518, 10, 18), "ga13", "test 49";
is rebase("10011111001101110", 2, 18), "ga13", "test 50";
is rebase("237156", 8, 18), "ga13", "test 51";
is rebase("13ebe", 16, 18), "ga13", "test 52";

is rebase(6355, 10, 19), "hb9", "test 53";
is rebase("110001101011", 2, 19), "hb9", "test 54";
is rebase("14323", 8, 19), "hb9", "test 55";
is rebase("18d3", 16, 19), "hb9", "test 56";

is rebase(148847, 10, 20), "ic27", "test 57";
is rebase("100100010101101111", 2, 20), "ic27", "test 58";
is rebase("44257", 8, 20), "ic27", "test 59";
is rebase("2456f", 16, 20), "ic27", "test 60";

is rebase(7878, 10, 21), "hi3", "test 61";
is rebase("1111011000110", 2, 21), "hi3", "test 62";
is rebase("17306", 8, 21), "hi3", "test 63";
is rebase("1e26", 16, 21), "hi3", "test 64";

is rebase(9531, 10, 22), "jf5", "test 65";
is rebase("10010100111011", 2, 22), "jf5", "test 66";
is rebase("22473", 8, 22), "jf5", "test 67";
is rebase("253b", 16, 22), "jf5", "test 68";

is rebase(11542, 10, 60), "w42", "test 69";
is rebase("11100001011110010", 2, 60), "w42", "test 70";
is rebase("341362", 8, 60), "w42", "test 71";
is rebase("1c2f2", 16, 60), "w42", "test 72";

is rebase(19812, 10, 61), "5jM", "test 73";
is rebase("100110101100100", 2, 61), "5jM", "test 74";
is rebase("46544", 8, 61), "5jM", "test 75";
is rebase("4d64", 16, 61), "5jM", "test 76";

is rebase(8480244, 10, 62), "zA68", "test 77";
is rebase("100000010110010111110100", 2, 62), "zA68", "test 78";
is rebase("40262764", 8, 62), "zA68", "test 79";
is rebase("8165f5", 16, 62), "zA68", "test 80";
