module atoms;

import std.stdio;
import std.range;
import std.conv;
import core.stdc.stdio : putc, FILE;

immutable string[] base = [
	"1",
	"11",
	"21",
	"1211",
	"111221",
	"312211",
	"13112221"
];

private struct Atom
{
	string str;
	ubyte[] decay;

	this() @disable;

	this(string str, ubyte[] decay)
	{
		this.str = str;
		this.decay = decay;
	}
}

immutable Atom[] atoms = [
	/*  0 */ {"", [0]},
	/*  1 */ {"1112", [63, 0]},
	/*  2 */ {"1112133", [64, 62, 0]},
	/*  3 */ {"111213322112", [65, 0]},
	/*  4 */ {"111213322113", [66, 0]},
	/*  5 */ {"1113", [68, 0]},
	/*  6 */ {"11131", [69, 0]},
	/*  7 */ {"111311222112", [84, 55, 0]},
	/*  8 */ {"111312", [70, 0]},
	/*  9 */ {"11131221", [71, 0]},
	/* 10 */ {"1113122112", [76, 0]},
	/* 11 */ {"1113122113", [77, 0]},
	/* 12 */ {"11131221131112", [82, 0]},
	/* 13 */ {"111312211312", [78, 0]},
	/* 14 */ {"11131221131211", [79, 0]},
	/* 15 */ {"111312211312113211", [80, 0]},
	/* 16 */ {"111312211312113221133211322112211213322112", [81, 29, 91, 0]},
	/* 17 */ {"111312211312113221133211322112211213322113", [81, 29, 90, 0]},
	/* 18 */ {"11131221131211322113322112", [81, 30, 0]},
	/* 19 */ {"11131221133112", [75, 29, 92, 0]},
	/* 20 */ {"1113122113322113111221131221", [75, 32, 0]},
	/* 21 */ {"11131221222112", [72, 0]},
	/* 22 */ {"111312212221121123222112", [73, 0]},
	/* 23 */ {"111312212221121123222113", [74, 0]},
	/* 24 */ {"11132", [83, 0]},
	/* 25 */ {"1113222", [86, 0]},
	/* 26 */ {"1113222112", [87, 0]},
	/* 27 */ {"1113222113", [88, 0]},
	/* 28 */ {"11133112", [89, 92, 0]},
	/* 29 */ {"12", [1, 0]},
	/* 30 */ {"123222112", [3, 0]},
	/* 31 */ {"123222113", [4, 0]},
	/* 32 */ {"12322211331222113112211", [2, 61, 29, 85, 0]},
	/* 33 */ {"13", [5, 0]},
	/* 34 */ {"131112", [28, 0]},
	/* 35 */ {"13112221133211322112211213322112", [24, 33, 61, 29, 91, 0]},
	/* 36 */ {"13112221133211322112211213322113", [24, 33, 61, 29, 90, 0]},
	/* 37 */ {"13122112", [7, 0]},
	/* 38 */ {"132", [8, 0]},
	/* 39 */ {"13211", [9, 0]},
	/* 40 */ {"132112", [10, 0]},
	/* 41 */ {"1321122112", [21, 0]},
	/* 42 */ {"132112211213322112", [22, 0]},
	/* 43 */ {"132112211213322113", [23, 0]},
	/* 44 */ {"132113", [11, 0]},
	/* 45 */ {"1321131112", [19, 0]},
	/* 46 */ {"13211312", [12, 0]},
	/* 47 */ {"1321132", [13, 0]},
	/* 48 */ {"13211321", [14, 0]},
	/* 49 */ {"132113212221", [15, 0]},
	/* 50 */ {"13211321222113222112", [18, 0]},
	/* 51 */ {"1321132122211322212221121123222112", [16, 0]},
	/* 52 */ {"1321132122211322212221121123222113", [17, 0]},
	/* 53 */ {"13211322211312113211", [20, 0]},
	/* 54 */ {"1321133112", [6, 61, 29, 92, 0]},
	/* 55 */ {"1322112", [26, 0]},
	/* 56 */ {"1322113", [27, 0]},
	/* 57 */ {"13221133112", [25, 29, 92, 0]},
	/* 58 */ {"1322113312211", [25, 29, 67, 0]},
	/* 59 */ {"132211331222113112211", [25, 29, 85, 0]},
	/* 60 */ {"13221133122211332", [25, 29, 68, 61, 29, 89, 0]},
	/* 61 */ {"22", [61, 0]},
	/* 62 */ {"3", [33, 0]},
	/* 63 */ {"3112", [40, 0]},
	/* 64 */ {"3112112", [41, 0]},
	/* 65 */ {"31121123222112", [42, 0]},
	/* 66 */ {"31121123222113", [43, 0]},
	/* 67 */ {"3112221", [38, 39, 0]},
	/* 68 */ {"3113", [44, 0]},
	/* 69 */ {"311311", [48, 0]},
	/* 70 */ {"31131112", [54, 0]},
	/* 71 */ {"3113112211", [49, 0]},
	/* 72 */ {"3113112211322112", [50, 0]},
	/* 73 */ {"3113112211322112211213322112", [51, 0]},
	/* 74 */ {"3113112211322112211213322113", [52, 0]},
	/* 75 */ {"311311222", [47, 38, 0]},
	/* 76 */ {"311311222112", [47, 55, 0]},
	/* 77 */ {"311311222113", [47, 56, 0]},
	/* 78 */ {"3113112221131112", [47, 57, 0]},
	/* 79 */ {"311311222113111221", [47, 58, 0]},
	/* 80 */ {"311311222113111221131221", [47, 59, 0]},
	/* 81 */ {"31131122211311122113222", [47, 60, 0]},
	/* 82 */ {"3113112221133112", [47, 33, 61, 29, 92, 0]},
	/* 83 */ {"311312", [45, 0]},
	/* 84 */ {"31132", [46, 0]},
	/* 85 */ {"311322113212221", [53, 0]},
	/* 86 */ {"311332", [38, 29, 89, 0]},
	/* 87 */ {"3113322112", [38, 30, 0]},
	/* 88 */ {"3113322113", [38, 31, 0]},
	/* 89 */ {"312", [34, 0]},
	/* 90 */ {"312211322212221121123222113", [36, 0]},
	/* 91 */ {"312211322212221121123222112", [35, 0]},
	/* 92 */ {"32112", [37, 0]}
];

private auto lookAndSay(int n, Range)(Range input)
//if (isInputRange(Range))
{
	static struct LookAndSay
	{
		Range input;
		//const(ubyte)* series;
		const(ubyte)* front;
		bool empty = false;

		this(Range input)
		{
			this.input = input;
			front = atoms[0].decay.ptr - 1;
			popFront();
		}

		void popFront()
		{
			front++;
			if (*front == 0)
			{
				if (input.empty)
				{
					empty = true;
					return;
				}
				front = atoms[*input.front].decay.ptr;
				input.popFront();
			}
		}
	}
	return LookAndSay(input);
}

auto asString(Range)(Range input)
//if (is(ElementType!Range == Atom))
{
	static struct Converter
	{
		Range input;
		string output;
		char front;
		bool empty = false;

		this(Range input)
		{
			this.input = input;
			popFront();
		}

		void popFront()
		{
			if (output.length == 0)
			{
				if (input.empty)
				{
					empty = true;
					return;
				}
				//assert(*input.front != 0);
				output = atoms[*input.front].str;
				input.popFront();
			}
			front = output[0];
			output = output[1 .. $];
		}
	}
	return Converter(input);
}

private auto lookAndSayAtoms(int n)()
if ((n - 1) == base.length)
{
	static immutable ubyte a24 = 24;
	static immutable ubyte a39 = 39;
	return [&a24, &a39];
}

private auto lookAndSayAtoms(int n)()
if ((n - 1) > base.length)
{
	return lookAndSay!n(lookAndSayAtoms!(n - 1));
}

auto lookAndSayNth(int n)()
if ((n - 1) < base.length)
{
	return base[n - 1];
}

auto lookAndSayNth(int n)()
if ((n - 1) >= base.length)
{
	return asString(lookAndSayAtoms!n);
}

auto lookAndSayPrint(int n)(FILE* fp)
{
	foreach (atom; lookAndSayAtoms!n)
	{
		//writeln(atom);
		foreach (chr; atoms[*atom].str)
			putc(chr, fp);
	}
}

unittest
{
	import std.format;
	static void assertString(string expected, string got)
	{
		if (expected != got)
		{
			assert(0, format!"Expected '%s' but got '%s'"(expected, got));
		}
	}

	//lookAndSayPrint!9(stdout.getFP);

    assert(lookAndSayNth!1.array == "1");
	assert(lookAndSayNth!2.array == "11");
	assert(lookAndSayNth!3.array == "21");
	assert(lookAndSayNth!4.array == "1211");
	assert(lookAndSayNth!5.array == "111221");
	assert(lookAndSayNth!6.array == "312211");
	assert(lookAndSayNth!7.array == "13112221");
	//assertString("1113213211", lookAndSayNth!8.to!string);
	assertString("31131211131221", lookAndSayNth!9.to!string);
}
