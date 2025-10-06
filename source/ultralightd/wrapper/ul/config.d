module ultralightd.wrapper.ul.config;

import ultralightd.bindings.ultralight;

import ultralightd.wrapper.ul.string;

// https://github.com/19h/ul2/blob/master/src/ul/config.rs

/++
 + A safe wrapper for the ULConfig type.
 +/
public struct Config
{
    package(ultralightd.wrapper) ULConfig handle;

    @disable public this();

    private this(ULConfig raw)
    {
        this.handle = raw;
    }

    /// Static constructor factory for creating a new default config
    public static Config create()
    {
        return Config(ulCreateConfig());
    }

    /// Destructor for safely disposing of the handle
    ~this()
    {
        if (handle !is null)
        {
            ulDestroyConfig(handle);
        }
    }

    /// Get a reference to the raw ULConfig handle.
    public ULConfig raw() => this.handle;

    /// Set the cache path for persistent Session data.
    public ref Config setCachePath(string path)
    {
        ulConfigSetCachePath(handle, String.fromString(path).raw);
        return this;
    }

    /// Set the relative path to the resources folder.
    public ref Config setResourcePathPrefix(string prefix)
    {
        ulConfigSetResourcePathPrefix(handle, String.fromString(prefix).raw);
        return this;
    }

    /// Set the winding order for front-facing triangles.
    public ref Config setFaceWinding(ULFaceWinding winding)
    {
        ulConfigSetFaceWinding(handle, winding);
        return this;
    }

    /// Set the font hinting algorithm.
    public ref Config setFontHinting(ULFontHinting hinting)
    {
        ulConfigSetFontHinting(handle, hinting);
        return this;
    }

    /// Set the gamma to use when composing font glyphs.
    public ref Config setFontGamma(double gamma)
    {
        ulConfigSetFontGamma(handle, gamma);
        return this;
    }

    /// Set the global user-defined CSS string.
    public ref Config setUserStylesheet(string css)
    {
        ulConfigSetUserStylesheet(handle, String.fromString(css).raw);
        return this;
    }

    /// Set whether to continuously repaint Views.
    public ref Config setForceRepaint(bool enabled)
    {
        ulConfigSetForceRepaint(handle, enabled);
        return this;
    }

    /// Set the delay between ticks of a CSS animation.
    public ref Config setAnimationTimerDelay(double delay)
    {
        ulConfigSetAnimationTimerDelay(handle, delay);
        return this;
    }

    /// Set the delay between ticks of a smooth scroll animation.
    public ref Config setScrollTimerDelay(double delay)
    {
        ulConfigSetScrollTimerDelay(handle, delay);
        return this;
    }

    /// Set the delay between calls to the recycler.
    public ref Config setRecycleDelay(double delay)
    {
        ulConfigSetRecycleDelay(handle, delay);
        return this;
    }

    /// Set the size of WebCore's memory cache in bytes.
    public ref Config setMemoryCacheSize(uint size)
    {
        ulConfigSetMemoryCacheSize(handle, size);
        return this;
    }

    /// Set the number of pages to keep in the cache.
    public ref Config setPageCacheSize(uint size)
    {
        ulConfigSetPageCacheSize(handle, size);
        return this;
    }

    /// Set the system's physical RAM size in bytes.
    public ref Config setOverrideRamSize(uint size)
    {
        ulConfigSetOverrideRAMSize(handle, size);
        return this;
    }

    /// Set the minimum size of large VM heaps in JavaScriptCore.
    public ref Config setMinLargeHeapSize(uint size)
    {
        ulConfigSetMinLargeHeapSize(handle, size);
        return this;
    }

    /// Set the minimum size of small VM heaps in JavaScriptCore.
    public ref Config setMinSmallHeapSize(uint size)
    {
        ulConfigSetMinSmallHeapSize(handle, size);
        return this;
    }

    /// Set the number of threads to use in the Renderer.
    public ref Config setNumRendererThreads(uint numThreads)
    {
        ulConfigSetNumRendererThreads(handle, numThreads);
        return this;
    }

    /// Set the max amount of time to allow repeating timers to run.
    public ref Config setMaxUpdateTime(double maxTime)
    {
        ulConfigSetMaxUpdateTime(handle, maxTime);
        return this;
    }

    /// Set the alignment in bytes of the BitmapSurface.
    public ref Config setBitmapAlignment(uint alignment)
    {
        ulConfigSetBitmapAlignment(handle, alignment);
        return this;
    }
}
