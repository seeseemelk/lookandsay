module atoms;

import std.stdio;
import std.range;
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
	size_t[] decay;
}

immutable Atom[] atoms = [
	{"", []},
	{"1112", [63]},
	{"1112133", [64, 62]},
	{"111213322112", [65]},
	{"111213322113", [66]},
	{"1113", [68]},
	{"11131", [69]},
	{"111311222112", [84, 55]},
	{"111312", [70]},
	{"11131221", [71]},
	{"1113122112", [76]},
	{"1113122113", [77]},
	{"11131221131112", [82]},
	{"111312211312", [78]},
	{"11131221131211", [79]},
	{"111312211312113211", [80]},
	{"111312211312113221133211322112211213322112", [81, 29, 91]},
	{"111312211312113221133211322112211213322113", [81, 29, 90]},
	{"11131221131211322113322112", [81, 30]},
	{"11131221133112", [75, 29, 92]},
	{"1113122113322113111221131221", [75, 32]},
	{"11131221222112", [72]},
	{"111312212221121123222112", [73]},
	{"111312212221121123222113", [74]},
	{"11132", [83]},
	{"1113222", [86]},
	{"1113222112", [87]},
	{"1113222113", [88]},
	{"11133112", [89, 92]},
	{"12", [1]},
	{"123222112", [3]},
	{"123222113", [4]},
	{"12322211331222113112211", [2, 61, 29, 85]},
	{"13", [5]},
	{"131112", [28]},
	{"13112221133211322112211213322112", [24, 33, 61, 29, 91]},
	{"13112221133211322112211213322113", [24, 33, 61, 29, 90]},
	{"13122112", [7]},
	{"132", [8]},
	{"13211", [9]},
	{"132112", [10]},
	{"1321122112", [21]},
	{"132112211213322112", [22]},
	{"132112211213322113", [23]},
	{"132113", [11]},
	{"1321131112", [19]},
	{"13211312", [12]},
	{"1321132", [13]},
	{"13211321", [14]},
	{"132113212221", [15]},
	{"13211321222113222112", [18]},
	{"1321132122211322212221121123222112", [16]},
	{"1321132122211322212221121123222113", [17]},
	{"13211322211312113211", [20]},
	{"1321133112", [6, 61, 29, 92]},
	{"1322112", [26]},
	{"1322113", [27]},
	{"13221133112", [25, 29, 92]},
	{"1322113312211", [25, 29, 67]},
	{"132211331222113112211", [25, 29, 85]},
	{"13221133122211332", [25, 29, 68, 61, 29, 89]},
	{"22", [61]},
	{"3", [33]},
	{"3112", [40]},
	{"3112112", [41]},
	{"31121123222112", [42]},
	{"31121123222113", [43]},
	{"3112221", [38, 39]},
	{"3113", [44]},
	{"311311", [48]},
	{"31131112", [54]},
	{"3113112211", [49]},
	{"3113112211322112", [50]},
	{"3113112211322112211213322112", [51]},
	{"3113112211322112211213322113", [52]},
	{"311311222", [47, 38]},
	{"311311222112", [47, 55]},
	{"311311222113", [47, 56]},
	{"3113112221131112", [47, 57]},
	{"311311222113111221", [47, 58]},
	{"311311222113111221131221", [47, 59]},
	{"31131122211311122113222", [47, 60]},
	{"3113112221133112", [47, 33, 61, 29, 92]},
	{"311312", [45]},
	{"31132", [46]},
	{"311322113212221", [53]},
	{"311332", [38, 29, 89]},
	{"3113322112", [38, 30]},
	{"3113322113", [38, 31]},
	{"312", [34]},
	{"312211322212221121123222113", [36]},
	{"312211322212221121123222112", [35]},
	{"32112", [37]}
];

private auto lookAndSay(Range)(Range input)
//if (isInputRange(Range))
{
	static struct LookAndSay
	{
		Range input;
		const(size_t)[] series;
		immutable(Atom)* front;
		bool empty = false;

		this(Range input)
		{
			this.input = input;
			popFront();
		}

		void popFront()
		{
			if (series.length == 0)
			{
				if (input.empty)
				{
					empty = true;
					return;
				}
				series = input.front.decay;
				input.popFront();
			}
			front = &atoms[series[0]];
			series = series[1 .. $];
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
		dchar front;
		bool empty = false;

		this(Range input)
		{
			this.input = input;
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
				output = input.front.str;
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
	return [atoms[24], atoms[39]];
}

private auto lookAndSayAtoms(int n)()
if ((n - 1) > base.length)
{
	return lookAndSay(lookAndSayAtoms!(n - 1));
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
		foreach (chr; atom.str)
			putc(chr, fp);
	}
}

unittest
{
	import std.stdio : writeln;
	writeln(lookAndSayNth!7);
	writeln(lookAndSayNth!8);
	writeln(lookAndSayNth!9);

    assert(lookAndSayNth!1.array == "1");
	assert(lookAndSayNth!2.array == "11");
	assert(lookAndSayNth!3.array == "21");
	assert(lookAndSayNth!4.array == "1211");
	assert(lookAndSayNth!5.array == "111221");
	assert(lookAndSayNth!6.array == "312211");
	assert(lookAndSayNth!7.array == "13112221");
	assert(lookAndSayNth!8.array == "1113213211");
	assert(lookAndSayNth!9.array == "31131211131221");
}
