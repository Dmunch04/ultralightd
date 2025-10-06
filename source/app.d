module ultralightd.wrapper.app;

import std.stdio;

import ultralightd;

void main()
{
    String str = String.fromString("Hello, World");
    writeln(cast(void*) str.raw);
    writeln(cast(void*) str.handle);

    Config config = Config.create();
    writeln(cast(void*) config.handle);
}
