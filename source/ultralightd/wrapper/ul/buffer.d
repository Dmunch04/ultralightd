module ultralightd.wrapper.ul.buffer;

import ultralightd.bindings.ultralight;

import ultralightd.wrapper.ul.string;

extern(C) void noop_buffer_destroy_callback(void* a, void* b) {}

public struct Buffer
{
    package(ultralightd.wrapper) ULBuffer handle;
    private bool owned;

    @disable public this();

    public this(ubyte[] data)
    {
        this.handle = ulCreateBuffer(cast(void*) data.ptr, data.length, null, &noop_buffer_destroy_callback);
        this.owned = true;
    }

    private this(ULBuffer raw, bool owned)
    {
        this.handle = raw;
        this.owned = owned;
    }

    public static Buffer fromRaw(ULBuffer raw, bool owned)
    {
        return Buffer(raw, owned);
    }

    public static Buffer fromCopy(ubyte[] data)
    {
        return Buffer(ulCreateBufferFromCopy(cast(const(void*)) data.ptr, data.length), true);
    }

    ~this()
    {
        if (handle !is null && owned)
        {
            ulDestroyBuffer(handle);
        }
    }

    public ULBuffer raw() => handle;

    public ubyte[] asSlice() => [];

    public size_t size() => ulBufferGetSize(handle);

    public bool ownsData() => ulBufferOwnsData(handle);
}
