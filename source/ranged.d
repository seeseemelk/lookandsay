module ranged;

import atoms;
import std.stdio;
import std.range;
import std.conv;
import core.stdc.stdio : putc, FILE;

private auto lookAndSay(int n, Range)(Range input)
//if (isInputRange(Range))
{
	static struct LookAndSay
	{
		Range input;
		//const(ubyte)* series;
		FastAtom* front;
		bool empty = false;

		this(Range input)
		{
			this.input = input;
			front = (*fastAtoms[0].decayZ) - 1;
			popFront();
		}

		void popFront()
		{
			front++;
			if (front is null)
			{
				if (input.empty)
				{
					empty = true;
					return;
				}
				front = *input.front.decayZ;
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
				//output = atoms[*input.front].str;
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
	return [&fastAtoms[24], &fastAtoms[39]];
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
		foreach (chr; atom.str)
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
