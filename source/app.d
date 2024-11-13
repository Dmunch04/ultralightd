import std.stdio;
import std.conv : to;

public extern(C)
{
	const(char*) ulVersionString();

	uint ulVersionMajor();

	uint ulVersionMinor();

	uint ulVersionPatch();
}

void main()
{
	writeln(ulVersionString().to!string);
	writeln(ulVersionMajor().to!string ~ "." ~ ulVersionMinor().to!string ~ "." ~ ulVersionPatch().to!string);
}
