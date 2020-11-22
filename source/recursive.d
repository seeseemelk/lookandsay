/**
An implementation which does not use ranges.
*/
module recursive;

import atoms;

private void lookAndSayRecurse(alias callback)(FastAtom* atom, ulong n)
{
	if (n == 0)
	{
		callback(atom.str);
	}
	else
	{
		foreach (child; atom.decay)
		{
			lookAndSayRecurse!callback(child, n - 1);
		}
	}
}

void lookAndSay(alias callback)(int n)
{
	n--;
	if (n < base.length)
	{
		callback(base[n]);
	}
	else
	{
		lookAndSayRecurse!callback(&fastAtoms[24], n - base.length);
		lookAndSayRecurse!callback(&fastAtoms[39], n - base.length);
	}
}

unittest
{
	import std.stdio;
	lookAndSay!write(1); writeln();
	lookAndSay!write(2); writeln();
	lookAndSay!write(3); writeln();
	lookAndSay!write(4); writeln();
	lookAndSay!write(5); writeln();
	lookAndSay!write(6); writeln();
	lookAndSay!write(7); writeln();
	lookAndSay!write(8); writeln();
	lookAndSay!write(9); writeln();
	lookAndSay!write(10); writeln();
}
