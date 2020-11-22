//import simple;
//import atoms;
import std.stdio;
import core.stdc.stdio : putc;

//enum n = 100;
enum n = 90;
//enum n = 70;
//enum n = 1;
//enum n = 50;

//version = rangedAtoms;
version = recursiveAtoms;
//version = simple;

version (recursiveAtoms)
{
	import recursive;

	private __gshared FILE* fp;

	void putstring(string str)
	{
		foreach (chr; str)
			putc(chr, fp);
	}

	void main(string[] args)
	{
		import core.stdc.stdio : putc;
		fp = stdout.getFP();
		lookAndSay!putstring(n);
		//lookAndSayPrint!n(fp);
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
}

version (rangedAtoms)
{
	import ranged;

	void main(string[] args)
	{
		import core.stdc.stdio : putc;
		auto fp = stdout.getFP();
		lookAndSayPrint!n(fp);
	}
}

version (simple)
{
	import simple;

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
