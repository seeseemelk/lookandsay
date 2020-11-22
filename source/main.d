//import simple;
import atoms;
import std.stdio;

enum n = 100;
//enum n = 90;
//enum n = 70;
//enum n = 1;
//enum n = 50;

void main(string[] args)
{
	import core.stdc.stdio : putc;
	auto fp = stdout.getFP();
	/*
	foreach (chr; lookAndSayNth!n)
	{
		putc(chr, fp);
	}*/
	lookAndSayPrint!n(fp);
	putc('\n', fp);
	/*
	static foreach (int n; 1..20)
	{
		foreach (chr; lookAndSayNth!n)
		{
			putc(chr, fp);
		}
		putc('\n', fp);
	}
	*/
}
