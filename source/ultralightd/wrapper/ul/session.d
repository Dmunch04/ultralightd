module ultralightd.wrapper.ul.session;

import ultralightd.bindings.ultralight;

import ultralightd.wrapper.ul.renderer;
import ultralightd.wrapper.ul.string;

public struct Session
{
    package ULSession handle;
    private bool owned;

    public this(Renderer renderer, bool isPersistent, string name)
    {
        this.handle = ulCreateSession(renderer.raw, isPersistent, String.fromString(name).raw);
        this.owned = true;
    }

    private this(ULSession raw, bool owned)
    {
        this.handle = raw;
        this.owned = owned;
    }

    ~this()
    {
        if (handle !is null && owned)
        {
            ulDestroySession(handle);
        }
    }

    public static Session getDefault(Renderer renderer) => Session(ulDefaultSession(renderer.raw), false);

    public static Session fromRaw(ULSession raw, bool owned) => Session(raw, owned);

    public ULSession raw() => handle;

    public bool isPersistent() => ulSessionIsPersistent(handle);

    public String name() => String.fromRaw(ulSessionGetName(handle), false);

    public ulong id() => ulSessionGetId(handle);

    public String diskPath() => String.fromRaw(ulSessionGetDiskPath(handle), false);
}
