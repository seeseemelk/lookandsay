module lookandsay;

import std.stdio;
import std.range;
import std.algorithm;
import std.conv;
import std.meta;

enum n = 100;
//enum n = 90;
//enum n = 70;
//enum n = 10;
//enum n = 50;

auto lookAndSay(Range)(Range input)
if (isInputRange!Range)
{
    static struct LookAndSay
    {
        Range input;
        int outputChr = 1;
		dchar count;
		dchar chr;
		alias front = count;
		bool empty = false;

		this(Range input)
		{
			this.input = input;
			popFront();
		}

        void popFront()
        {
			if (outputChr == 0)
			{
				outputChr = 1;
				front = chr;
			}
			else
			{
				if (input.empty)
				{
					empty = true;
					return;
				}

				count = '1';
				chr = input.front;
				input.popFront();

				while (!input.empty && input.front == chr)
				{
					count++;
					input.popFront();
				}
				outputChr = 0;
			}
        }
    }
	return LookAndSay(input);
}
static assert(isInputRange!(typeof(lookAndSay("1"))));

auto lookAndSayMultiple(int n, Range)(Range input)
if (n == 1)
{
    return lookAndSay(input);
}

auto lookAndSayMultiple(int n, Range)(Range input)
if (n > 1)
{
    return lookAndSayMultiple!(n - 1)(lookAndSay(input));
}

auto lookAndSayNth(int n)()
if (n > 1)
{
	return lookAndSayMultiple!(n - 1)("1");
}

auto lookAndSayNth(int n)()
if (n == 1)
{
	return "1";
}

version (unittest) {} else
{
	void main(string[] args)
	{
		import core.stdc.stdio : putc;
		auto fp = stdout.getFP();
		foreach (chr; lookAndSayNth!n)
		{
			putc(chr, fp);
		}
		putc('\n', fp);
	}
}

unittest
{
    assert(lookAndSay("1").array == "11");
    assert(lookAndSay("11").array == "21");
    assert(lookAndSay("21").array == "1211");
    assert(lookAndSay("1211").array == "111221");
    assert(lookAndSay("111221").array == "312211");
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
