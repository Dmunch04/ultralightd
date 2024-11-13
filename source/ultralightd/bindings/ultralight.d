module ultralightd.bindings.ultralight;

import std.stdint;

//alias ULChar16 = wchar;
alias ULChar16 = ushort;

alias ULConfig = C_Config*;
alias ULRenderer = C_Renderer*;
alias ULSession = C_Session*;
alias ULViewConfig = C_ViewConfig*;
alias ULView = C_View*;
alias ULBitmap = C_Bitmap*;
alias ULString = C_String*;
alias ULBuffer = C_Buffer*;
alias ULKeyEvent = C_KeyEvent*;
alias ULMouseEvent = C_MouseEvent*;
alias ULScrollEvent = C_ScrollEvent*;
alias ULGamepadEvent = C_GamepadEvent*;
alias ULGamepadAxisEvent = C_GamepadAxisEvent*;
alias ULGamepadButtonEvent = C_GamepadButtonEvent*;
alias ULSurface = C_Surface*;
alias ULBitmapSurface = C_Surface*;
alias ULFontFile = C_FontFile*;
alias ULImageSource = C_ImageSource*;

/++
 + Low-level bindings for the Ultralight C API.
 + Source: https://github.com/ultralight-ux/Ultralight-API/blob/master/Ultralight/CAPI
 + Version as of time written: 1.4.0 (beta)
 +/
public extern(C)
{
    /++
     + Defines
     +/

    struct C_Config;
    struct C_Renderer;
    struct C_Session;
    struct C_ViewConfig;
    struct C_View;
    struct C_Bitmap;
    struct C_String;
    struct C_Buffer;
    struct C_KeyEvent;
    struct C_MouseEvent;
    struct C_ScrollEvent;
    struct C_GamepadEvent;
    struct C_GamepadAxisEvent;
    struct C_GamepadButtonEvent;
    struct C_Surface;
    struct C_FontFile;
    struct C_ImageSource;

    /++ 
     + 
     +/
    enum ULMessageSource
    {
        kMessageSource_XML = 0,
        kMessageSource_JS,
        kMessageSource_Network,
        kMessageSource_ConsoleAPI,
        kMessageSource_Storage,
        kMessageSource_AppCache,
        kMessageSource_Rendering,
        kMessageSource_CSS,
        kMessageSource_Security,
        kMessageSource_ContentBlocker,
        kMessageSource_Media,
        kMessageSource_MediaSource,
        kMessageSource_WebRTC,
        kMessageSource_ITPDebug,
        kMessageSource_PrivateClickMeasurement,
        kMessageSource_PaymentRequest,
        kMessageSource_Other,
    }

    /++
     +
     +/
    enum ULMessageLevel
    {
        kMessageLevel_Log = 0,
        kMessageLevel_Warning,
        kMessageLevel_Error,
        kMessageLevel_Debug,
        kMessageLevel_Info,
    }

    /++
     +
     +/
    enum ULCurser
    {
        kCursor_Pointer = 0,
        kCursor_Cross,
        kCursor_Hand,
        kCursor_IBeam,
        kCursor_Wait,
        kCursor_Help,
        kCursor_EastResize,
        kCursor_NorthResize,
        kCursor_NorthEastResize,
        kCursor_NorthWestResize,
        kCursor_SouthResize,
        kCursor_SouthEastResize,
        kCursor_SouthWestResize,
        kCursor_WestResize,
        kCursor_NorthSouthResize,
        kCursor_EastWestResize,
        kCursor_NorthEastSouthWestResize,
        kCursor_NorthWestSouthEastResize,
        kCursor_ColumnResize,
        kCursor_RowResize,
        kCursor_MiddlePanning,
        kCursor_EastPanning,
        kCursor_NorthPanning,
        kCursor_NorthEastPanning,
        kCursor_NorthWestPanning,
        kCursor_SouthPanning,
        kCursor_SouthEastPanning,
        kCursor_SouthWestPanning,
        kCursor_WestPanning,
        kCursor_Move,
        kCursor_VerticalText,
        kCursor_Cell,
        kCursor_ContextMenu,
        kCursor_Alias,
        kCursor_Progress,
        kCursor_NoDrop,
        kCursor_Copy,
        kCursor_None,
        kCursor_NotAllowed,
        kCursor_ZoomIn,
        kCursor_ZoomOut,
        kCursor_Grab,
        kCursor_Grabbing,
        kCursor_Custom,
    }

    /++
     +
     +/
    enum ULBitmapFormat
    {
        /++
         + Alpha channel only, 8-bits per pixel.
         + Encoding: 8-bits per channel, unsigned normalized.
         + Color-space: Linear (no gamma), alpha-coverage only.
         +/
        kBitmapFormat_A8_UNORM,

        /++
         + Blue Green Red Alpha channels, 32-bits per pixel.
         + Encoding: 8-bits per channel, unsigned normalized.
         + Color-space: sRGB gamma with premultiplied linear alpha channel.
         +/
        kBitmapFormat_BGRA8_UNORM_SRGB,
    }

    /++
     +
     +/
    enum ULKeyEventType
    {
        /++
         + Key-Down event type. This type does **not** trigger accelerator commands in WebCore (eg, 
         + Ctrl+C for copy is an accelerator command).
         +
         + @warning  You should probably use kKeyEventType_RawKeyDown instead. This type is only here for
         +           historic compatibility with WebCore's key event types.
         +/
        kKeyEventType_KeyDown,

        /++
         + Key-Up event type. Use this when a physical key is released.
         +/
        kKeyEventType_KeyUp,

        /++
         + Raw Key-Down type. Use this when a physical key is pressed.
         +/
        kKeyEventType_RawKeyDown,

        /++
         + Character input event type. Use this when the OS generates text from
         + a physical key being pressed (eg, WM_CHAR on Windows).
         +/
        kKeyEventType_Char,
    }

    /++
     +
     +/
    enum ULMouseEventType
    {
        kMouseEventType_MouseMoved,
        kMouseEventType_MouseDown,
        kMouseEventType_MouseUp,
    }

    /++
     +
     +/
    enum ULMouseButton
    {
        kMouseButton_None = 0,
        kMouseButton_Left,
        kMouseButton_Middle,
        kMouseButton_Right,
    }

    /++
     +
     +/
    enum ULScrollEventType
    {
        kScrollEventType_ScrollByPixel,
        kScrollEventType_ScrollByPage,
    }

    /++
     +
     +/
    enum ULGamepadEventType
    {
        kGamepadEventType_Connected,
        kGamepadEventType_Disconnected,
    }

    /++
     +
     +/
    enum ULFaceWinding
    {
        kFaceWinding_Clockwise,
        kFaceWinding_CounterClockwise,
    }

    enum ULFontHinting
    {
        /++
         + Lighter hinting algorithm-- glyphs are slightly fuzzier but better
         + resemble their original shape. This is achieved by snapping glyphs to the
         + pixel grid only vertically which better preserves inter-glyph spacing.
         +/
        kFontHinting_Smooth,

        /++
         + Default hinting algorithm-- offers a good balance between sharpness and
         + shape at smaller font sizes.
         +/
        kFontHinting_Normal,

        /++
         + Strongest hinting algorithm-- outputs only black/white glyphs. The result
         + is usually unpleasant if the underlying TTF does not contain hints for
         + this type of rendering.
         +/
        kFontHinting_Monochrome,
    }

    /++
     +
     +/
    struct ULRect
    {
        ///
        public float left;

        ///
        public float top;

        ///
        public float right;

        ///
        public float bottom;
    }

    /++
     +
     +/
    struct ULIntRect
    {
        ///
        public int left;

        ///
        public int top;

        ///
        public int right;

        ///
        public int bottom;
    }

    /++
     +
     +/
    struct RenderTarget
    {
        ///
        public bool is_empty;

        ///
        public uint width;

        ///
        public uint height;

        ///
        public uint texture_id;

        ///
        public uint texture_width;

        ///
        public uint texture_height;

        ///
        public ULBitmapFormat texture_format;

        ///
        public ULRect uv_coords;

        ///
        public uint render_buffer_id;
    }

    const(char*) ulVersionString();

    uint ulVersionMahor();

    uint ulVersionMinor();

    uint ulVersionPatch();





    /++
     + Config
     +/

    /++
     + Create config with default values (see <Ultralight/platform/Config.h>).
     +/
    ULConfig ulCreateConfig();

    /++
     + Destroy config.
     +/
    void ulDestroyConfig(ULConfig);

    /++
     + A writable OS file path to store persistent Session data in.
     + This data may include cookies, cached network resources, indexed DB, etc.
     + @note Files are only written to the path when using a persistent Session.
     +/
    void ulConfigSetCachePath(ULConfig, ULString);

    /++
     + The relative path to the resources folder (loaded via the FileSystem API).
     + The library loads certain resources (SSL certs, ICU data, etc.) from the FileSystem API
     + during runtime (eg, `file:///resources/cacert.pem`).
     + You can customize the relative file path to the resources folder by modifying this setting.
     + (Default = "resources/")
     +/
    void ulConfigSetResourcePathPrefix(ULConfig, ULString);

    /++
     + The winding order for front-facing triangles.
     + @pre Only used when GPU rendering is enabled for the View.
     + (Default = kFaceWinding_CounterClockwise)
     +/
    void ulConfigSetFaceWinding(ULConfig, ULFaceWinding);

    /++
     + The hinting algorithm to use when rendering fonts. (Default = kFontHinting_Normal)
     + @see ULFontHinting
     +/
    void ulConfigSetFontHinting(ULConfig, ULFontHinting);

    /++
     + The gamma to use when compositing font glyphs, change this value to adjust contrast (Adobe and
     + Apple prefer 1.8, others may prefer 2.2). (Default = 1.8)
     +/
    void ulConfigSetFontGamma(ULConfig, double);

    /++
     + Global user-defined CSS string (included before any CSS on the page).
     + You can use this to override default styles for various elements on the page.
     + @note This is an actual string of CSS, not a file path.
     +/
    void ulConfigSetUserStylesheet(ULConfig, ULString);

    /++
     + Whether or not to continuously repaint any Views, regardless if they are dirty.
     + This is mainly used to diagnose painting/shader issues and profile performance.
     + (Default = False)
     +/
    void ulConfigSetForceRepaint(ULConfig, bool);

    /++
     + The delay (in seconds) between every tick of a CSS animation.
     + (Default = 1.0 / 60.0)
     +/
    void ulConfigSetAnimationTimerDelay(ULConfig, double);

    /++
     + The delay (in seconds) between every tick of a smooth scroll animation.
     + (Default = 1.0 / 60.0)
     +/
    void ulConfigSetScrollTimerDelay(ULConfig, double);

    /++
     + The delay (in seconds) between every call to the recycler.
     + The library attempts to reclaim excess memory during calls to the internal recycler. You can
     + change how often this is run by modifying this value.
     + (Default = 4.0)
     +/
    void ulConfigSetRecycleDelay(ULConfig, double);

    /++
     + The size of WebCore's memory cache in bytes.
     + @note  You should increase this if you anticipate handling pages with large resources, Safari
     +        typically uses 128+ MiB for its cache.
     + (Default = 64 * 1024 * 1024)
     +/
    void ulConfigSetMemoryCacheSize(ULConfig, uint);

    /++
     + The number of pages to keep in the cache. (Default: 0, none)
     + Safari typically caches about 5 pages and maintains an on-disk cache to support typical
     + web-browsing activities.
     + If you increase this, you should probably increase the memory cache size as well.
     + (Default = 0)
     +/
    void ulConfigSetPageCacheSize(ULConfig, uint);

    /++
     + The system's physical RAM size in bytes.
     + JavaScriptCore tries to detect the system's physical RAM size to set reasonable allocation
     + limits. Set this to anything other than 0 to override the detected value. Size is in bytes.
     + This can be used to force JavaScriptCore to be more conservative with its allocation strategy
     + (at the cost of some performance).
     +/
    void ulConfigSetOverrideRAMSize(ULConfig, uint);

    /++
     + The minimum size of large VM heaps in JavaScriptCore.
     + Set this to a lower value to make these heaps start with a smaller initial value.
     + (Default = 32 * 1024 * 1024)
     +/
    void ulConfigSetMinLargeHeapSize(ULConfig, uint);

    /++
     + The minimum size of small VM heaps in JavaScriptCore.
     + Set this to a lower value to make these heaps start with a smaller initial value.
     + (Default = 1 * 1024 * 1024)
     +/
    void ulConfigSetMinSmallHeapSize(ULConfig, uint);

    /++
     + The number of threads to use in the Renderer (for parallel painting on the CPU, etc.).
     + You can set this to a certain number to limit the number of threads to spawn.
     + If this value is 0, the number of threads will be determined at runtime using the following
     + formula:
     +      ```
     +      max(PhysicalProcessorCount() - 1, 1)
     +      ```
     +/
    void ulConfigSetNumRendererThreads(ULConfig, uint);

    /++
     + The max amount of time (in seconds) to allow repeating timers to run during each call to
     + Renderer::Update.
     + The library will attempt to throttle timers if this time budget is exceeded.
     + (Default = 1.0 / 200.0)
     +/
    void ulConfigSetMaxUpdateTime(ULConfig, double);

    /++
     + The alignment (in bytes) of the BitmapSurface when using the CPU renderer.
     + The underlying bitmap associated with each BitmapSurface will have row_bytes padded to reach
     + this alignment.
     + Aligning the bitmap helps improve performance when using the CPU renderer. Determining the
     + proper value to use depends on the CPU architecture and max SIMD instruction set used.
     + We generally target the 128-bit SSE2 instruction set across most PC platforms so '16' is a safe
     + value to use.
     + You can set this to '0' to perform no padding (row_bytes will always be width * 4) at a slight
     + cost to performance.
     + (Default = 16)
     +/
    void ulConfigSetBitmapAlignment(ULConfig, uint);





    /++
     + Renderer
     +/

    /++
     + Create the core renderer singleton for the library.
     + You should set up the Platform singleton (see CAPI_Platform.h) before calling this function.
     + @note You do not need to the call this if you're using ulCreateApp() from AppCore.
     + @warning You'll need to define a ULFontLoader and ULFileSystem within the Platform singleton
     +          or else this call will fail.
     + @warning You should only create one Renderer during the lifetime of your program.
     + @param  config  The configuration to use for the renderer.
     + @return  Returns the new renderer instance.
     +/
    ULRenderer ulCreateRenderer(ULConfig);

    /++
     + Destroy the renderer.
     + @param renderer  The renderer instance to destroy.
     +/
    void ulDestroyRenderer(ULRenderer);

    /++
     + Update timers and dispatch internal callbacks (JavaScript and network).
     + @param  renderer  The active renderer instance.
     +/
    void ulUpdate(ULRenderer);

    /++
     + Notify the renderer that a display has refreshed (you should call this after vsync).
     + This updates animations, smooth scroll, and window.requestAnimationFrame() for all Views
     + matching the display id.
     + @param  renderer  The active renderer instance.
     + @param  display_id  The display ID to refresh (0 by default).
     +/
    void ulRefreshDisplay(ULRenderer, uint);

    /++
     + Render all active Views to their respective surfaces and render targets.
     + @param  renderer  The active renderer instance.
     +/
    void ulRender(ULRenderer);

    /++
     + Attempt to release as much memory as possible. Don't call this from any callbacks or driver
     + code.
     + @param  renderer  The active renderer instance.
     +/
    void ulPurgeMemory(ULRenderer);

    /++
     + Print detailed memory usage statistics to the log. (@see ulPlatformSetLogger)
     + @param  renderer  The active renderer instance.
     +/
    void ulLogMemoryUsage(ULRenderer);

    /++
     + Start the remote inspector server.
     + While the remote inspector is active, Views that are loaded into this renderer
     + will be able to be remotely inspected from another Ultralight instance either locally
     + (another app on same machine) or remotely (over the network) by navigating a View to:
     +      inspector://<ADDRESS>:<PORT>
     + @param renderer  The active renderer instance.
     + @param address   The address for the server to listen on (eg, "127.0.0.1")
     + @param port      The port for the server to listen on (eg, 9222)
     + @return  Returns whether the server started successfully or not.
     +/
    bool ulStartRemoteInspectorServer(ULRenderer, const(char*), ushort);

    /++
     + Describe the details of a gamepad, to be used with ulFireGamepadEvent and related
     + events below. This can be called multiple times with the same index if the details change.
     + @param  renderer      The active renderer instance.
     + @param  index         The unique index (or "connection slot") of the gamepad. For example,
     +                       controller #1 would be "1", controller #2 would be "2" and so on.
     + @param  id            A string ID representing the device, this will be made available
     +                       in JavaScript as gamepad.id
     + @param  axis_count    The number of axes on the device.
     + @param  button_count  The number of buttons on the device.
     +/
    void ulSetGamepadDetails(ULRenderer, uint, ULString, uint, uint);

    /++
     + Fire a gamepad event (connection / disconnection).
     + @note  The gamepad should first be described via ulSetGamepadDetails before calling this
     +        function.
     + @param renderer  The active renderer instance.
     + @param evt       The event to fire.
     + @see <https://developer.mozilla.org/en-US/docs/Web/API/Gamepad>
     +/
    void ulFireGamepadEvent(ULRenderer, ULGamepadEvent);

    /++
     + Fire a gamepad axis event (to be called when an axis value is changed).
     + @note  The gamepad should be connected via a previous call to ulFireGamepadEvent.
     + @param renderer  The active renderer instance.
     + @param evt       The event to fire.
     + @see <https://developer.mozilla.org/en-US/docs/Web/API/Gamepad/axes>
     +/
    void ulFireGamepadAxisEvent(ULRenderer, ULGamepadAxisEvent);

    /++
     + Fire a gamepad button event (to be called when a button value is changed).
     + @note  The gamepad should be connected via a previous call to ulFireGamepadEvent.
     + @param renderer  The active renderer instance.
     + @param evt       The event to fire.
     + @see <https://developer.mozilla.org/en-US/docs/Web/API/Gamepad/buttons>
     +/
    void ulFireGamepadButtonEvent(ULRenderer, ULGamepadButtonEvent);





    /++
     + Session
     +/
    
    /++
     + Create a Session to store local data in (such as cookies, local storage, application cache,
     + indexed db, etc).
     +/
    ULSession ulCreateSession(ULRenderer, bool, ULString);

    /++
     + Destroy a Session.
     +/
    void ulDestroySession(ULSession);

    /++
     + Get the default session (persistent session named "default").
     + @note  This session is owned by the Renderer, you shouldn't destroy it.
     +/
    void ulDefaultSession(ULRenderer);

    /++
     + Whether or not is persistent (backed to disk).
     +/
    bool ulSessionIsPersistent(ULSession);

    /++
     + Unique name identifying the session (used for unique disk path).
     +/
    ULString ulSessionGetName(ULSession);

    /++
     + Unique numeric Id for the session.
     +/
    ulong ulGetSessionId(ULSession);

    /++
     + The disk path to write to (used by persistent sessions only).
     +/
    ULString ulSessionGetDiskPath(ULSession);





    /++
     + ViewConfig
     +/
    
    /++
     + Create view configuration with default values (see <Ultralight/platform/View.h>).
     +/
    ULViewConfig ulCreateViewConfig();

    /++
     + Destroy view configuration.
     +/
    void ulDestroyViewConfig(ULViewConfig);

    /++
     + Set a user-generated id of the display (monitor, TV, or screen) that the View will be shown on.
     + Animations are driven based on the physical refresh rate of the display. Multiple Views can
     + share the same display.
     + @note This is automatically managed for you when ulCreateApp() is used.
     + @see ulRefreshDisplay()
     +/
    void ulViewConfigSetDisplayId(ULViewConfig, uint);

    /++
     + Set whether to render using the GPU renderer (accelerated) or the CPU renderer (unaccelerated).
     + This option is only valid if you're managing the Renderer yourself (eg, you've previously
     + called ulCreateRenderer() instead of ulCreateApp()).
     + When true, the View will be rendered to an offscreen GPU texture using the GPU driver set in
     + ulPlatformSetGPUDriver(). You can fetch details for the texture via ulViewGetRenderTarget().
     + When false (the default), the View will be rendered to an offscreen pixel buffer using the
     + multithreaded CPU renderer. This pixel buffer can optionally be provided by the user--
     + for more info see ulViewGetSurface().
     +/
    void ulViewConfigSetIsAccelerated(ULViewConfig, bool);

    /++
     + Set whether images should be enabled (Default = True).
     +/
    void ulViewConfigSetIsTransparent(ULViewConfig, bool);

    /++
     + Set the initial device scale, ie. the amount to scale page units to screen pixels. This should be
     + set to the scaling factor of the device that the View is displayed on. (Default = 1.0)
     + @note 1.0 is equal to 100% zoom (no scaling), 2.0 is equal to 200% zoom (2x scaling)
     +/
    void ulViewConfigSetInitialDeviceScale(ULViewConfig, double);

    /++
     + Set whether or not the View should initially have input focus. (Default = True)
     +/
    void ulViewConfigSetInitialFocus(ULViewConfig, bool);

    /++
     + Set whether images should be enabled (Default = True).
     +/
    void ulViewConfigSetEnableImages(ULViewConfig, bool);

    /++
     + Set whether JavaScript should be enabled (Default = True).
     +/
    void ulViewConfigSetEnableJavaScript(ULViewConfig, bool);

    /++
     + Set default font-family to use (Default = Times New Roman).
     +/
    void ulViewConfigSetFontFamilyStandard(ULViewConfig, ULString);

    /++
     + Set default font-family to use for fixed fonts, eg <pre> and <code>
     + (Default = Courier New).
     +/
    void ulViewConfigSetFontFamilyFixed(ULViewConfig, ULString);

    /++
     + Set default font-family to use for serif fonts (Default = Times New Roman).
     +/
    void ulViewConfigSetFontFamilySerif(ULViewConfig, ULString);

    /++
     + Set default font-family to use for sans-serif fonts (Default = Arial).
     +/
    void ulViewConfigSetFontFamilySansSerif(ULViewConfig, ULString);

    /++
     + Set user agent string (See <Ultralight/platform/Config.h> for the default).
     +/
    void ulViewConfigSetUserAgent(ULViewConfig, ULString);





    /++
     + View
     +/
    
    /++
     + Create a View with certain size (in pixels).
     + @note  You can pass null to 'session' to use the default session.
     +/
    ULView ulCreateView(ULRenderer, uint, uint, ULViewConfig, ULSession);

    /++
     + Destroy a View.
     +/
    void ulDestroyView(ULView);

    /++
     + Get current URL.
     + @note Don't destroy the returned string, it is owned by the View.
     +/
    ULString ulViewGetURL(ULView);

    /++
     + Get current title.
     + @note Don't destroy the returned string, it is owned by the View.
     +/
    ULString ulViewGetTitle(ULView);

    /++
     + Get the width, in pixels.
     +/
    uint ulViewGetWidth(ULView);

    /++
     + Get the height, in pixels.
     +/
    uint ulViewGetHeight(ULView);

    /++
     + Get the display id of the View.
     +/
    uint ulViewGetDisplayId(ULView);

    /++
     + Set the display id of the View.
     + This should be called when the View is moved to another display.
     +/
    void ulViewSetDisplayId(ULView, uint);

    /++
     + Get the device scale, ie. the amount to scale page units to screen pixels.
     + For example, a value of 1.0 is equivalent to 100% zoom. A value of 2.0 is 200% zoom.
     +/
    double ulViewGetDeviceScale(ULView);

    /++
     + Set the device scale.
     +/
    void ulViewSetDeviceScale(ULView, double);

    /++
     + Whether or not the View is GPU-accelerated. If this is false, the page will be rendered
     + via the CPU renderer.
     +/
    bool ulViewIsAccelerated(ULView);

    /++
     + Whether or not the View supports transparent backgrounds.
     +/
    bool ulViewIsTransparent(ULView);

    /++
     + Check if the main frame of the page is currrently loading.
     +/
    bool ulViewIsLoading(ULView);

    /++
     + Get the RenderTarget for the View.
     + @note  Only valid if this View is GPU accelerated.
     +        You can use this with your GPUDriver implementation to bind and display the
     +        corresponding texture in your application.
     +/
    ULRenderTarget ulViewGetRenderTarget(ULView);

    /++
     + Get the Surface for the View (native pixel buffer that the CPU renderer draws into).
     + @note  This operation is only valid if you're managing the Renderer yourself (eg, you've
     +        previously called ulCreateRenderer() instead of ulCreateApp()).
     +        This function will return NULL if this View is GPU accelerated.
     +        The default Surface is BitmapSurface but you can provide your own Surface implementation
     +        via ulPlatformSetSurfaceDefinition.
     +        When using the default Surface, you can retrieve the underlying bitmap by casting
     +        ULSurface to ULBitmapSurface and calling ulBitmapSurfaceGetBitmap().
     +/
    ULSurface ulViewGetSurface(ULView);

    /++
     + Load a raw string of HTML.
     +/
    void ulViewLoadHTML(ULView, ULString);

    /++
     + Load a URL into main frame.
     +/
    void ulViewLoadURL(ULView, ULString);

    /++
     + Resize view to a certain width and height (in pixels).
     +/
    void ulViewResize(ULView, uint, uint);

    /++
     + Acquire the page's JSContext for use with JavaScriptCore API.
     + @note  This call locks the context for the current thread. You should call
     +        ulViewUnlockJSContext() after using the context so other worker threads can modify
     +        JavaScript state.
     + @note  The lock is recusive, it's okay to call this multiple times as long as you call
     +        ulViewUnlockJSContext() the same number of times.
     +/
    //JSContextRef ulViewLockJSContext(ULView); TODO

    /++
     + Unlock the page's JSContext after a previous call to ulViewLockJSContext().
     +/
    void ulViewUnlockJSContext(ULView);

    /++
     + Evaluate a string of JavaScript and return result.
     + @param  js_string  The string of JavaScript to evaluate.
     + @param  exception  The address of a ULString to store a description of the last exception. Pass
     +                    NULL to ignore this. Don't destroy the exception string returned, it's owned
     +                    by the View.
     + @note Don't destroy the returned string, it's owned by the View. This value is reset with every
     +       call-- if you want to retain it you should copy the result to a new string via
     +       ulCreateStringFromCopy().
     + @note An example of using this API:
     +       <pre>
     +         ULString script = ulCreateString("1 + 1");
     +         ULString exception;
     +         ULString result = ulViewEvaluateScript(view, script, &exception);
     +         /* Use the result ("2") and exception description (if any) here. */
     +         ulDestroyString(script);
     +       </pre>
     +/
    ULString ulViewEvaluateScript(ULView, ULString, ULString*);

    // TODO https://github.com/ultralight-ux/Ultralight-API/blob/master/Ultralight/CAPI/CAPI_View.h#L309
}