import std.stdio;
import std.conv : to;

import ultralightd.bindings.ultralight;

void main()
{
	writeln(ulVersionString().to!string);
	writeln(ulVersionMajor().to!string ~ "." ~ ulVersionMinor().to!string ~ "." ~ ulVersionPatch().to!string);
}
