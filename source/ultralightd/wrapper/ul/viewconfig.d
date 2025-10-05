module ultralightd.wrapper.ul.viewconfig;

import ultralightd.bindings.ultralight;

import ultralightd.wrapper.ul.string;

public struct ViewConfig
{
    package ULViewConfig handle;

    /// Constructor for creating a new default config
    public this()
    {
        this.handle = ulCreateViewConfig();
    }

    /// Destructor for safely disposing of the handle
    ~this()
    {
        if (handle !is null)
        {
            ulDestroyViewConfig(handle);
        }
    }
    
    /// Get a reference to the raw ULViewConfig handle.
    public ULViewConfig raw() => this.handle;
    
    /// Set the display ID that the View will be shown on.
    public ref ViewConfig setDisplayId(uint displayId)
    {
        ulViewConfigSetDisplayId(handle, displayId);
        return this;
    }
    
    /// Set whether to use GPU rendering.
    public ref ViewConfig setIsAccelerated(bool isAccelerated)
    {
        ulViewConfigSetIsAccelerated(handle, isAccelerated);
        return this;
    }
    
    /// Set whether the View should be transparent.
    public ref ViewConfig setIsTransparent(bool isTransparent)
    {
        ulViewConfigSetIsTransparent(handle, isTransparent);
        return this;
    }
    
    /// Set the initial device scale.
    public ref ViewConfig setInitialDeviceScale(double scale)
    {
        ulViewConfigSetInitialDeviceScale(handle, scale);
        return this;
    }
    
    /// Set whether the View should initially have input focus.
    public ref ViewConfig setInitialFocus(bool hasFocus)
    {
        ulViewConfigSetInitialFocus(handle, hasFocus);
        return this;
    }
    
    /// Set whether images should be enabled.
    public ref ViewConfig setEnableImages(bool enabled)
    {
        ulViewConfigSetEnableImages(handle, enabled);
        return this;
    }
    
    /// Set whether JavaScript should be enabled.
    public ref ViewConfig setEnableJavascript(bool enabled)
    {
        ulViewConfigSetEnableJavaScript(handle, enabled);
        return this;
    }
    
    /// Set the default font family for standard fonts.
    public ref ViewConfig setFontFamilyStandard(string fontName)
    {
        ulViewConfigSetFontFamilyStandard(handle, String.fromString(fontName).raw);
        return this;
    }
    
    /// Set the default font family for fixed fonts.
    public ref ViewConfig setFontFamilyFixed(string fontName)
    {
        ulViewConfigSetFontFamilyFixed(handle, String.fromString(fontName).raw);
        return this;
    }
    
    /// Set the default font family for serif fonts.
    public ref ViewConfig setFontFamilySerif(string fontName)
    {
        ulViewConfigSetFontFamilySerif(handle, String.fromString(fontName).raw);
        return this;
    }
    
    /// Set the default font family for sans-serif fonts.
    public ref ViewConfig setFontFamilySansSerif(string fontName)
    {
        ulViewConfigSetFontFamilySansSerif(handle, String.fromString(fontName).raw);
        return this;
    }
    
    /// Set the user agent string.
    public ref ViewConfig setUserAgent(string userAgent)
    {
        ulViewConfigSetUserAgent(handle, String.fromString(userAgent).raw);
        return this;
    }
}
