use Test;

use Number::More :ALL;

plan 228;

my $debug = 0;

is rebase(642, 10, 3), "212210", "base 3; test 1";
is rebase("1010000010", 2, 3), "212210", "base 3; test 2";
is rebase("1202", 8, 3), "212210", "base 3; test 3";
is rebase("282", 16, 3), "212210", "base 3; test 4";

is rebase(3612, 10, 4), "320130", "base 4; test 5";
is rebase("111000011100", 2, 4), "320130", "base 4; test 6";
is rebase("7034", 8, 4), "320130", "base 4; test 7";
is rebase("E1C", 16, 4), "320130", "base 4; test 8";

is rebase(2832, 10, 5), "42312", "base 5; test 9";
is rebase("101100010000", 2, 5), "42312", "base 5; test 10";
is rebase("5420", 8, 5), "42312", "base 5; test 11";
is rebase("B10", 16, 5), "42312", "base 5; test 12";

is rebase(5735, 10, 6), "42315", "base 6; test 13";
is rebase("1011001100111", 2, 6), "42315", "base 6; test 14";
is rebase("13147", 8, 6), "42315", "base 6; test 15";
is rebase("1667", 16, 6), "42315", "base 6; test 16";

is rebase(15251, 10, 7), "62315", "base 7; test 17";
is rebase("11101110010011", 2, 7), "62315", "base 7; test 18";
is rebase("35623", 8, 7), "62315", "base 7; test 19";
is rebase("3B93", 16, 7), "62315", "base 7; test 20";

is rebase(4615, 10, 9), "6287", "base 9; test 21";
is rebase("1001000000111", 2, 9), "6287", "base 9; test 22";
is rebase("11007", 8, 9), "6287", "base 9; test 23";
is rebase("1207", 16, 9), "6287", "base 9; test 24";

is rebase(13396, 10, 11), "A079", "base 11; test 25";
is rebase("11010001010100", 2, 11), "A079", "base 11; test 26";
is rebase("32124", 8, 11), "A079", "base 11; test 27";
is rebase("3454", 16, 11), "A079", "base 11; test 28";

is rebase(17375, 10, 12), "A07B", "base 12; test 29";
is rebase("100001111011111", 2, 12), "A07B", "base 12; test 30";
is rebase("41737", 8, 12), "A07B", "base 12; test 31";
is rebase("43DF", 16, 12), "A07B", "base 12; test 32";

is rebase(1975, 10, 13), "B8C", "base 13; test 33";
is rebase("11110110111", 2, 13), "B8C", "base 13; test 34";
is rebase("3667", 8, 13), "B8C", "base 13; test 35";
is rebase("7B7", 16, 13), "B8C", "base 13; test 36";

is rebase(34290, 10, 14), "C6D4", "base 14; test 37";
is rebase("1000010111110010", 2, 14), "C6D4", "base 14; test 38";
is rebase("102762", 8, 14), "C6D4", "base 14; test 39";
is rebase("85F2", 16, 14), "C6D4", "base 14; test 40";

is rebase(49562, 10, 15), "EA42", "base 15; test 41";
is rebase("1100000110011010", 2, 15), "EA42", "base 15; test 42";
is rebase("140632", 8, 15), "EA42", "base 15; test 43";
is rebase("C19A", 16, 15), "EA42", "base 15; test 44";

is rebase(71464, 10, 17), "E94D", "base 17; test 45";
is rebase("10001011100101000", 2, 17), "E94D", "base 17; test 46";
is rebase("213450", 8, 17), "E94D", "base 17; test 47";
is rebase("11728", 16, 17), "E94D", "base 17; test 48";

is rebase(96573, 10, 18), "GA13", "base 18; test 49";
is rebase("10111100100111101", 2, 18), "GA13", "base 18; test 50";
is rebase("274475", 8, 18), "GA13", "base 18; test 51";
is rebase("1793D", 16, 18), "GA13", "base 18; test 52";

is rebase(6355, 10, 19), "HB9", "base 19; test 53";
is rebase("1100011010011", 2, 19), "HB9", "base 19; test 54";
is rebase("14323", 8, 19), "HB9", "base 19; test 55";
is rebase("18D3", 16, 19), "HB9", "base 19; test 56";

is rebase(148847, 10, 20), "IC27", "base 20; test 57";
is rebase("100100010101101111", 2, 20), "IC27", "base 20; test 58";
is rebase("442557", 8, 20), "IC27", "base 20; test 59";
is rebase("2456F", 16, 20), "IC27", "base 20; test 60";

is rebase(7878, 10, 21), "HI3", "base 21; test 61";
is rebase("1111011000110", 2, 21), "HI3", "base 21; test 62";
is rebase("17306", 8, 21), "HI3", "base 21; test 63";
is rebase("1EC6", 16, 21), "HI3", "base 21; test 64";

is rebase(9531, 10, 22), "JF5", "base 22; test 65";
is rebase("10010100111011", 2, 22), "JF5", "base 22; test 66";
is rebase("22473", 8, 22), "JF5", "base 22; test 67";
is rebase("253B", 16, 22), "JF5", "base 22; test 68";

is rebase(11004, 10, 23), "KIA", "base 23; test 69";
is rebase("10101011111100", 2, 23), "KIA", "base 23; test 70";
is rebase("25374", 8, 23), "KIA", "base 23; test 71";
is rebase("2AFC", 16, 23), "KIA", "base 23; test 72";

is rebase(150633, 10, 24), "ALC9", "base 24; test 73";
is rebase("100100110001101001", 2, 24), "ALC9", "base 24; test 74";
is rebase("446151", 8, 24), "ALC9", "base 24; test 75";
is rebase("24C69", 16, 24), "ALC9", "base 24; test 76";

is rebase(355546, 10, 25), "MILL", "base 25; test 77";
is rebase("1010110110011011010", 2, 25), "MILL", "base 25; test 78";
is rebase("1266332", 8, 25), "MILL", "base 25; test 79";
is rebase("56CDA", 16, 25), "MILL", "base 25; test 80";

is rebase(15259, 10, 26), "MEN", "base 26; test 81";
is rebase("11101110011011", 2, 26), "MEN", "base 26; test 82";
is rebase("35633", 8, 26), "MEN", "base 26; test 83";
is rebase("3B9B", 16, 26), "MEN", "base 26; test 84";

is rebase(16332, 10, 27), "MAO", "base 27; test 85";
is rebase("11111111001100", 2, 27), "MAO", "base 27; test 86";
is rebase("37714", 8, 27), "MAO", "base 27; test 87";
is rebase("3FCC", 16, 27), "MAO", "base 27; test 88";

is rebase(19901, 10, 28), "PAL", "base 28; test 89";
is rebase("100110110111101", 2, 28), "PAL", "base 28; test 90";
is rebase("46675", 8, 28), "PAL", "base 28; test 91";
is rebase("4DBD", 16, 28), "PAL", "base 28; test 92";

is rebase(21997, 10, 29), "Q4F", "base 29; test 93";
is rebase("101010111101101", 2, 29), "Q4F", "base 29; test 94";
is rebase("52755", 8, 29), "Q4F", "base 29; test 95";
is rebase("55ED", 16, 29), "Q4F", "base 29; test 96";

is rebase(24613, 10, 30), "RAD", "base 30; test 97";
is rebase("110000000100101", 2, 30), "RAD", "base 30; test 98";
is rebase("60045", 8, 30), "RAD", "base 30; test 99";
is rebase("6025", 16, 30), "RAD", "base 30; test 100";

is rebase(27355, 10, 31), "SED", "base 31; test 101";
is rebase("110101011011011", 2, 31), "SED", "base 31; test 102";
is rebase("65333", 8, 31), "SED", "base 31; test 103";
is rebase("6ADB", 16, 31), "SED", "base 31; test 104";

is rebase(30027, 10, 32), "TAB", "base 32; test 105";
is rebase("111010101001011", 2, 32), "TAB", "base 32; test 106";
is rebase("72513", 8, 32), "TAB", "base 32; test 107";
is rebase("754B", 16, 32), "TAB", "base 32; test 108";

is rebase(33011, 10, 33), "UAB", "base 33; test 109";
is rebase("1000000011110011", 2, 33), "UAB", "base 33; test 110";
is rebase("100363", 8, 33), "UAB", "base 33; test 111";
is rebase("80F3", 16, 33), "UAB", "base 33; test 112";

is rebase(37837, 10, 34), "WOT", "base 34; test 113";
is rebase("1001001111001101", 2, 34), "WOT", "base 34; test 114";
is rebase("111715", 8, 34), "WOT", "base 34; test 115";
is rebase("93CD", 16, 34), "WOT", "base 34; test 116";

is rebase(42520, 10, 35), "YOU", "base 35; test 117";
is rebase("1010011000011000", 2, 35), "YOU", "base 35; test 118";
is rebase("123030", 8, 35), "YOU", "base 35; test 119";
is rebase("A618", 16, 35), "YOU", "base 35; test 120";

is rebase(44027, 10, 36), "XYZ", "base 36; test 121";
is rebase("1010101111111011", 2, 36), "XYZ", "base 36; test 122";
is rebase("125773", 8, 36), "XYZ", "base 36; test 123";
is rebase("ABFB", 16, 36), "XYZ", "base 36; test 124";

is rebase(49258, 10, 37), "ZaB", "base 37; test 125";
is rebase("1100000001101010", 2, 37), "ZaB", "base 37; test 126";
is rebase("140152", 8, 37), "ZaB", "base 37; test 127";
is rebase("C06A", 16, 37), "ZaB", "base 37; test 128";

is rebase(40393, 10, 38), "Fab", "base 38; test 129";
is rebase("1001110111001001", 2, 38), "Fab", "base 38; test 130";
is rebase("11671", 8, 38), "Fab", "base 38; test 131";
is rebase("9DC9", 16, 38), "Fab", "base 38; test 132";

is rebase(58217, 10, 39), "cAT", "base 39; test 133";
is rebase("111000110101001", 2, 39), "cAT", "base 39; test 134";
is rebase("161551", 8, 39), "cAT", "base 39; test 135";
is rebase("E369", 16, 39), "cAT", "base 39; test 136";

is rebase(63377, 10, 40), "dOH", "base 40; test 137";
is rebase("1111011110010001", 2, 40), "dOH", "base 40; test 138";
is rebase("173621", 8, 40), "dOH", "base 40; test 139";
is rebase("F791", 16, 40), "dOH", "base 40; test 140";

is rebase(58823, 10, 41), "YeT", "base 41; test 141";
is rebase("1110010111000111", 2, 41), "YeT", "base 41; test 142";
is rebase("162707", 8, 41), "YeT", "base 41; test 143";
is rebase("E5C7", 16, 41), "YeT", "base 41; test 144";

is rebase(48257, 10, 42), "REf", "base 42; test 145";
is rebase("1011110010000001", 2, 42), "REf", "base 42; test 146";
is rebase("136201", 8, 42), "REf", "base 42; test 147";
is rebase("BC81", 16, 42), "REf", "base 42; test 148";

is rebase(27708, 10, 43), "EgG", "base 43; test 149";
is rebase("110110000111100", 2, 43), "EgG", "base 43; test 150";
is rebase("66074", 8, 43), "EgG", "base 43; test 151";
is rebase("BC3C", 16, 43), "EgG", "base 43; test 152";

is rebase(71616, 10, 44), "ahS", "base 44; test 153";
is rebase("10001011111000000", 2, 44), "ahS", "base 44; test 154";
is rebase("213700", 8, 44), "ahS", "base 44; test 155";
is rebase("117C0", 16, 44), "ahS", "base 44; test 156";

is rebase(89654, 10, 45), "iCE", "base 45; test 157";
is rebase("10101111000110110", 2, 45), "iCE", "base 45; test 158";
is rebase("257066", 8, 45), "iCE", "base 45; test 159";
is rebase("15E36", 16, 45), "iCE", "base 45; test 160";

is rebase(57637, 10, 46), "RAj", "base 46; test 161";
is rebase("1110000100100101", 2, 46), "RAj", "base 46; test 162";
is rebase("160445", 8, 46), "RAj", "base 46; test 163";
is rebase("E125", 16, 46), "RAj", "base 46; test 164";

is rebase(40231, 10, 47), "I9k", "base 47; test 165";
is rebase("1001110100100111", 2, 47), "I9k", "base 47; test 166";
is rebase("116447", 8, 47), "I9k", "base 47; test 167";
is rebase("9D27", 16, 47), "I9k", "base 47; test 168";

is rebase(25314, 10, 48), "AlI", "base 48; test 169";
is rebase("110001011100010", 2, 48), "AlI", "base 48; test 170";
is rebase("61342", 8, 48), "AlI", "base 48; test 171";
is rebase("62E2", 16, 48), "AlI", "base 48; test 172";

is rebase(115248, 10, 49), "m00", "base 49; test 173";
is rebase("11100001000110000", 2, 49), "m00", "base 49; test 174";
is rebase("341060", 8, 49), "m00", "base 49; test 175";
is rebase("1C230", 16, 49), "m00", "base 49; test 176";

is rebase(2649, 10, 50), "12n", "base 50; test 177";
is rebase("101001011001", 2, 50), "12n", "base 50; test 178";
is rebase("5131", 8, 50), "12n", "base 50; test 179";
is rebase("A59", 16, 50), "12n", "base 50; test 180";

is rebase(130589, 10, 51), "oAT", "base 51; test 181";
is rebase("11111111000011101", 2, 51), "oAT", "base 51; test 182";
is rebase("377035", 8, 51), "oAT", "base 51; test 183";
is rebase("1FELD", 16, 51), "oAT", "base 51; test 184";

is rebase(29976, 10, 52), "ApE", "base 52; test 185";
is rebase("111010000001010", 2, 52), "ApE", "base 52; test 186";
is rebase("72012", 8, 52), "ApE", "base 52; test 187";
is rebase("740A", 16, 52), "ApE", "base 52; test 188";

is rebase(6041, 10, 53), "27q", "base 53; test 189";
is rebase("101110011001", 2, 53), "27q", "base 53; test 190";
is rebase("13631", 8, 53), "27q", "base 53; test 191";
is rebase("1799", 16, 53), "27q", "base 53; test 192";

is rebase(72880, 10, 54), "OrY", "base 54; test 193";
is rebase("10001110010110000", 2, 54), "OrY", "base 54; test 194";
is rebase("216260", 8, 54), "OrY", "base 54; test 195";
is rebase("11CB0", 16, 54), "OrY", "base 54; test 196";

is rebase(43944, 10, 55), "ESs", "base 55; test 197";
is rebase("1010101110101000", 2, 55), "ESs", "base 55; test 198";
is rebase("125650", 8, 55), "ESs", "base 55; test 199";
is rebase("ABA8", 16, 55), "ESs", "base 55; test 200";

is rebase(9911, 10, 56), "38t", "base 56; test 201";
is rebase("10011010110111", 2, 56), "38t", "base 56; test 202";
is rebase("23267", 8, 56), "38t", "base 56; test 203";
is rebase("2667", 16, 56), "38t", "base 56; test 204";

is rebase(13337, 10, 57), "45u", "base 57; test 205";
is rebase("11010000011001", 2, 57), "45u", "base 57; test 206";
is rebase("32031", 8, 57), "45u", "base 57; test 207";
is rebase("3419", 16, 57), "45u", "base 57; test 208";

is rebase(3769, 10, 58), "16v", "base 58; test 209";
is rebase("1110101111001", 2, 58), "16v", "base 58; test 210";
is rebase("7271", 8, 58), "16v", "base 58; test 211";
is rebase("EB9", 16, 58), "16v", "base 58; test 212";

is rebase(52170, 10, 59), "EwE", "base 59; test 213";
is rebase("1100101111001010", 2, 59), "EwE", "base 59; test 214";
is rebase("145722", 8, 59), "EwE", "base 59; test 215";
is rebase("CBCA", 16, 59), "EwE", "base 59; test 216";

is rebase(11542, 10, 60), "W42", "base 60; test 217";
is rebase("11100001011110010", 2, 60), "W42", "base 60; test 218";
is rebase("341362", 8, 60), "W42", "base 60; test 219";
is rebase("1C2F2", 16, 60), "W42", "base 60; test 220";

is rebase(19812, 10, 61), "5Jm", "base 61; test 221";
is rebase("100110101100100", 2, 61), "5Jm", "base 61; test 222";
is rebase("46544", 8, 61), "5Jm", "base 61; test 223";
is rebase("4D64", 16, 61), "5Jm", "base 61; test 224";

is rebase(8480244, 10, 62), "Za68", "base 62; test 225";
is rebase("100000010110010111110100", 2, 62), "Za68", "base 62; test 226";
is rebase("40262764", 8, 62), "Za68", "base 62; test 227";
is rebase("8165F5", 16, 62), "Za68", "base 62; test 228";
