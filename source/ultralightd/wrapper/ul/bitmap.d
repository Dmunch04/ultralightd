module ultralightd.wrapper.ul.bitmap;

import ultralightd.bindings.ultralight;

import std.exception : enforce;
import std.string : toStringz;

public alias BitmapFormat = ULBitmapFormat;

public struct Bitmap
{
    package(ultralightd.wrapper) ULBitmap handle;
    private bool owned;

    @disable this(this);

    public this(uint width, uint height, BitmapFormat format)
    {
        this.handle = ulCreateBitmap(width, height, format);
        this.owned = true;
    }

    private this(ULBitmap raw, bool owned)
    {
        this.handle = raw;
        this.owned = owned;
    }

    ~this()
    {
        if (handle !is null && owned)
        {
            ulDestroyBitmap(handle);
        }
    }

    public static Bitmap fromRaw(ULBitmap raw, bool owned) => Bitmap(raw, owned);

    public static Bitmap empty() => Bitmap(ulCreateEmptyBitmap(), true);

    public static Bitmap fromPixels(uint width, uint height, BitmapFormat format, uint rowBytes, const(ubyte)[] pixels, bool shouldCopy)
    {
        return Bitmap(ulCreateBitmapFromPixels(width, height, format, rowBytes, pixels.ptr, pixels.length, shouldCopy), true);
    }

    public ULBitmap raw() => handle;

    public Bitmap clone() => Bitmap(ulCreateBitmapFromCopy(handle), true);

    public uint width() => ulBitmapGetWidth(handle);

    public uint height() => ulBitmapGetHeight(handle);

    public BitmapFormat format() => ulBitmapGetFormat(handle);

    public uint bpp() => ulBitmapGetBpp(handle);

    public uint rowBytes() => ulBitmapGetRowBytes(handle);

    public size_t size() => ulBitmapGetSize(handle);

    public bool ownsPixels() => ulBitmapOwnsPixels(handle);

    public LockedPixels lockPixels()
    {
        auto ptr = ulBitmapLockPixels(handle);
        enforce(ptr !is null, "Failed to lock bitmap pixels");
        return LockedPixels(this, cast(ubyte*) ptr, size);
    }

    public ubyte* rawPixels() @trusted => cast(ubyte*) ulBitmapRawPixels(handle);

    public bool isEmpty() => ulBitmapIsEmpty(handle);

    public void erase() => ulBitmapErase(handle);

    public bool writePNG(string path) => ulBitmapWritePNG(handle, path.toStringz);

    public void swapRedBlueChannels() => ulBitmapSwapRedBlueChannels(handle);
}

public struct LockedPixels
{
    private Bitmap* bitmap;
    private ubyte* pixels;
    private size_t len;

    this(ref Bitmap bitmap, ubyte* pixels, size_t len)
    {
        this.bitmap = &bitmap;
        this.pixels = pixels;
        this.len = len;
    }

    ~this()
    {
        if (bitmap !is null)
        {
            ulBitmapUnlockPixels(bitmap.raw);
            bitmap = null;
            pixels = null;
            len = 0;
        }
    }

    public ubyte[] asSlice() @trusted => pixels[0 .. len];
}
