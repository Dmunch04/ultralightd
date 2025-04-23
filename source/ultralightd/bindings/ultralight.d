module ultralightd.bindings.ultralight;

import std.stdint;

public alias ULChar16 = wchar;
//alias ULChar16 = ushort;
public alias ULIndexType = uint;

public alias ULConfig = C_Config*;
public alias ULRenderer = C_Renderer*;
public alias ULSession = C_Session*;
public alias ULViewConfig = C_ViewConfig*;
public alias ULView = C_View*;
public alias ULBitmap = C_Bitmap*;
public alias ULString = C_String*;
public alias ULBuffer = C_Buffer*;
public alias ULKeyEvent = C_KeyEvent*;
public alias ULMouseEvent = C_MouseEvent*;
public alias ULScrollEvent = C_ScrollEvent*;
public alias ULGamepadEvent = C_GamepadEvent*;
public alias ULGamepadAxisEvent = C_GamepadAxisEvent*;
public alias ULGamepadButtonEvent = C_GamepadButtonEvent*;
public alias ULSurface = C_Surface*;
public alias ULBitmapSurface = C_Surface*;
public alias ULFontFile = C_FontFile*;
public alias ULImageSource = C_ImageSource*;





/++
 + View Callbacks
 +/

/++
 + 
 +/
alias ULChangeTitleCallback = extern(C) void function(void*, ULView, ULString);

/++
 + 
 +/
alias ULChangeURLCallback = extern(C) void function(void*, ULView, ULString);

/++
 + 
 +/
alias ULChangeTooltipCallback = extern(C) void function(void*, ULView, ULString);

/++
 + 
 +/
alias ULChangeCurserCallback = extern(C) void function(void*, ULView, ULCursor);

/++
 + 
 +/
alias ULAddConsoleMessageCallback = extern(C) void function(void*, ULView, ULMessageSource, ULMessageLevel, ULString, uint, uint, ULString);

/++
 + 
 +/
alias ULCreateChildViewCallback = extern(C) ULView function(void*, ULView, ULString, ULString, bool, ULIntRect);

/++
 + 
 +/
alias ULCreateInspectorViewCallback = extern(C) ULView function(void*, ULView, bool, ULString);

/++
 + 
 +/
alias ULBeginLoadingCallback = extern(C) void function(void*, ULView, ulong, bool, ULString);

/++
 + 
 +/
alias ULFinishLoadingCallback = extern(C) void function(void*, ULView, ulong, bool, ULString);

/++
 + 
 +/
alias ULFailLoadingCallback = extern(C) void function(void*, ULView, ulong, bool, ULString, ULString, ULString, int);

/++
 + 
 +/
alias ULWindowObjectReadyCallback = extern(C) void function(void*, ULView, ulong, bool, ULString);

/++
 + 
 +/
alias ULDOMReadyCallback = extern(C) void function(void*, ULView, ulong, bool, ULString);

/++
 + 
 +/
alias ULUpdateHistoryCallback = extern(C) void function(void*, ULView);





/++
 + Surface Callbacks
 +/

/++
 + The callback invoked when a Surface is created.
 + @param  width  The width in pixels.
 + @param  height  The height in pixels.
 + @return  This callback should return a pointer to user-defined data for the instance. This user
 +          data pointer will be passed to all other callbacks when operating on the instance.
 +/
alias ULSurfaceDefinitionCreateCallback = extern(C) void* function(uint, uint);

/++
 + The callback invoked when a Surface is destroyed.
 + @param  user_data  User data pointer uniquely identifying the surface.
 +/
alias ULSurfaceDefinitionDestroyCallback = extern(C) void function(void*);

/++
 + The callback invoked when a Surface's width (in pixels) is requested.
 + @param  user_data  User data pointer uniquely identifying the surface.
 +/
alias ULSurfaceDefinitionGetWidthCallback = extern(C) uint function(void*);

/++
 + The callback invoked when a Surface's height (in pixels) is requested.
 + @param  user_data  User data pointer uniquely identifying the surface.
 +/
alias ULSurfaceDefinitionGetHeightCallback = extern(C) uint function(void*);

/++
 + The callback invoked when a Surface's row bytes is requested.
 + @note  This value is also known as "stride". Usually width * 4.
 + @param  user_data  User data pointer uniquely identifying the surface.
 +/
alias ULSurfaceDefinitionGetRowBytesCallback = extern(C) uint function(void*);

/++
 + The callback invoked when a Surface's size (in bytes) is requested.
 + @param  user_data  User data pointer uniquely identifying the surface.
 +/
alias ULSurfaceDefinitionGetSizeCallback = extern(C) size_t function(void*);

/++
 + The callback invoked when a Surface's pixel buffer is requested to be locked for reading/writing
 + (should return a pointer to locked bytes).
 + @param  user_data  User data pointer uniquely identifying the surface.
 +/
alias ULSurfaceDefinitionLockPixelsCallback = extern(C) void* function(void*);

/++
 + The callback invoked when a Surface's pixel buffer is requested to be unlocked after previously
 + being locked.
 + @param  user_data  User data pointer uniquely identifying the surface.
 +/
alias ULSurfaceDefinitionUnlockPixelsCallback = extern(C) void function(void*);

/++
 + The callback invoked when a Surface is requested to be resized to a certain width/height.
 + @param  user_data  User data pointer uniquely identifying the surface.
 + @param  width      Width in pixels.
 + @param  height     Height in pixels.
 +/
alias ULSurfaceDefinitionResizeCallback = extern(C) void function(void*, uint, uint);




/++
 + File System Callbacks
 +/

/++
 + The callback invoked when the FileSystem wants to check if a file path exists, return true if it
 + exists.
 +/
alias ULFileSystemFileExistsCallback = extern(C) bool function(ULString);

/++
 + Get the mime-type of the file (eg "text/html").
 + This is usually determined by analyzing the file extension.
 + If a mime-type cannot be determined, you should return "application/unknown" for this value.
 + The library will consume the result and call ulDestroyString() after this call returns.
 +/
alias ULFileSystemGetFileMimeTypeCallback = extern(C) ULString function(ULString);

/++
 + Get the charset / encoding of the file (eg "utf-8").
 + This is only important for text-based files and is usually determined by analyzing the
 + contents of the file.
 + If a charset cannot be determined, it's usually safe to return "utf-8" for this value.
 + The library will consume the result and call ulDestroyString() after this call returns.
 +/
alias ULFileSystemGetFileCharsetCallback = extern(C) ULString function(ULString);

/++
 + Open file for reading and map it to a Buffer.
 + To minimize copies, you should map the requested file into memory and use ulCreateBuffer()
 + to wrap the data pointer (unmapping should be performed in the destruction callback).
 + If the file was unable to be opened, you should return NULL for this value.
 +/
alias ULFileSystemOpenFileCallback = extern(C) ULBuffer function(ULString);





/++
 + Logger Callbacks
 +/

/++
 + The callback invoked when the library wants to print a message to the log.
 +/
alias ULLoggerLogMessageCallback = extern(C) void function(ULLogLevel, ULString);





/++
 + GPU Driver Callbacks
 +/

/++
 + Callback for users to implement ULGPUDriver::begin_synchronize.
 + Called before any state (eg, create_texture(), update_texture(), destroy_texture(), etc.) is
 + updated during a call to ulRender().
 + This is a good time to prepare the GPU for any state updates.
 +/
alias ULGPUDriverBeginSynchronizeCallback = extern(C) void function();

/++
 + Callback for users to implement ULGPUDriver::end_synchronize.
 + Called after all state has been updated during a call to ulRender().
 +/
alias ULGPUDriverEndSynchronizeCallback = extern(C) void function();

/++
 + Callback for users to implement ULGPUDriver::next_texture_id.
 + Get the next available texture ID.
 + This is used to generate a unique texture ID for each texture created by the library. The
 + GPU driver implementation is responsible for mapping these IDs to a native ID.
 + @note Numbering should start at 1, 0 is reserved for "no texture".
 + @return Returns the next available texture ID.
 +/
alias ULGPUDriverNextTextureIdCallback = extern(C) uint function();

/++
 + Callback for users to implement ULGPUDriver::create_texture.
 + Create a texture with a certain ID and optional bitmap.
 + @param texture_id  The texture ID to use for the new texture.
 + @param bitmap      The bitmap to initialize the texture with (can be empty).
 + @note If the Bitmap is empty (ulBitmapIsEmpty()), then a RTT Texture should be created instead.
 +       This will be used as a backing texture for a new RenderBuffer.
 + @warning A deep copy of the bitmap data should be made if you are uploading it to the GPU
 +          asynchronously, it will not persist beyond this call.
 +/
alias ULGPUDriverCreateTextureCallback = extern(C) void function(uint, ULBitmap);

/++
 + Callback for users to implement ULGPUDriver::update_texture.
 + Update an existing non-RTT texture with new bitmap data.
 + @param texture_id  The texture to update.
 + @param bitmap      The new bitmap data.
 + @warning A deep copy of the bitmap data should be made if you are uploading it to the GPU
 +          asynchronously, it will not persist beyond this call.
 +/
alias ULGPUDriverUpdateTextureCallback = extern(C) void function(uint, ULBitmap);

/++
 + Callback for users to implement ULGPUDriver::destroy_texture.
 + Destroy a texture.
 + @param texture_id  The texture to destroy.
 +/
alias ULGPUDriverDestroyTextureCallback = extern(C) void function(uint);

/++
 + Callback for users to implement ULGPUDriver::next_render_buffer_id.
 + Get the next available render buffer ID.
 + This is used to generate a unique render buffer ID for each render buffer created by the
 + library. The GPU driver implementation is responsible for mapping these IDs to a native ID.
 + @note Numbering should start at 1, 0 is reserved for "no render buffer".
 + @return Returns the next available render buffer ID.
 +/
alias ULGPUDriverNextRenderBufferIdCallback = extern(C) uint function();

/++
 + Callback for users to implement ULGPUDriver::create_render_buffer.
 + Create a render buffer with certain ID and buffer description.
 + @param render_buffer_id  The render buffer ID to use for the new render buffer.
 + @param buffer            The render buffer description.
 +/
alias ULGPUDriverCreateRenderBufferCallback = extern(C) void function(uint, ULRenderBuffer);

/++
 + Callback for users to implement ULGPUDriver::destroy_render_buffer.
 + Destroy a render buffer.
 + @param render_buffer_id  The render buffer to destroy.
 +/
alias ULGPUDriverDestroyRenderBufferCallback = extern(C) void function(uint);

/++
 + Callback for users to implement ULGPUDriver::next_geometry_id.
 + Get the next available geometry ID.
 + This is used to generate a unique geometry ID for each geometry created by the library. The
 + GPU driver implementation is responsible for mapping these IDs to a native ID.
 + @note Numbering should start at 1, 0 is reserved for "no geometry".
 + @return Returns the next available geometry ID.
 +/
alias ULGPUDriverNextGeometryIdCallback = extern(C) uint function();

/++
 + Callback for users to implement ULGPUDriver::create_geometry.
 + Create geometry with certain ID and vertex/index data.
 + @param geometry_id  The geometry ID to use for the new geometry.
 + @param vertices     The vertex buffer data.
 + @param indices      The index buffer data.
 + @warning A deep copy of the vertex/index data should be made if you are uploading it to the
 +          GPU asynchronously, it will not persist beyond this call.
 +/
alias ULGPUDriverCreateGeometryCallback = extern(C) void function(uint, ULVertexBuffer, ULIndexBuffer);

/++
 + Callback for users to implement ULGPUDriver::update_geometry.
 + Update existing geometry with new vertex/index data.
 + @param geometry_id  The geometry to update.
 + @param vertices     The new vertex buffer data.
 + @param indices      The new index buffer data.
 + @warning A deep copy of the vertex/index data should be made if you are uploading it to the
 +          GPU asynchronously, it will not persist beyond this call.
 +/
alias ULGPUDriverUpdateGeometryCallback = extern(C) void function(uint, ULVertexBuffer, ULIndexBuffer);

/++
 + Callback for users to implement ULGPUDriver::destroy_geometry.
 + Destroy geometry.
 + @param geometry_id  The geometry to destroy.
 +/
alias ULGPUDriverDestroyGeometryCallback = extern(C) void function(uint);

/++
 + Callback for users to implement ULGPUDriver::update_command_list.
 + Update the pending command list with commands to execute on the GPU.
 + Commands are dispatched to the GPU driver asynchronously via this method. The GPU driver
 + implementation should consume these commands and execute them at an appropriate time.
 + @param list  The list of commands to execute.
 + @warning Implementations should make a deep copy of the command list, it will not persist
 +          beyond this call.
 +/
alias ULGPUDriverUpdateCommandListCallback = extern(C) void function(ULCommandList);





/++
 + Clipboard Callbacks
 +/

/++
 + The callback invoked when the library wants to clear the system's clipboard.
 +/
alias ULClipboardClearCallback = extern(C) void function();

/++
 + The callback invoked when the library wants to read from the system's clipboard.
 + You should store the result (if any) in 'result'.
 +/
alias ULClipboardReadPlainTextCallback = extern(C) void function(ULString);

/++
 + The callback invoked when the library wants to write to the system's clipboard.
 +/
alias ULClipboardWritePlainTextCallback = extern(C) void function(ULString);





/++
 + Buffer Callbacks
 +/

/++
 + 
 +/
alias ulDestroyBufferCallback = extern(C) void function(void*, void*);





/++
 + Font Loader Callbacks
 +/

/++
 + Fallback font family name. Will be used if all other fonts fail to load.
 + @note  This font should be guaranteed to exist (eg, ULFontLoader::load should not fail when
 +        when passed this font family name).
 + @note  The returned ULString instance will be consumed (ulDestroyString will be called on it).
 +/
alias ULFontLoaderGetFallbackFont = extern(C) ULString function();

/++
 + Fallback font family name that can render the specified characters. This is mainly used to
 + support CJK (Chinese, Japanese, Korean) text display.
 + @param  characters  One or more UTF-16 characters. This is almost always a single character.
 + @param  weight      Font weight.
 + @param  italic      Whether or not italic is requested.
 + @return  Should return a font family name that can render the text. The returned ULString
 +          instance will be consumed (ulDestroyString will be called on it).
 +/
alias ULFontLoaderGetFallbackFontForCharacters = extern(C) ULString function(ULString, int, bool);

/++
 + Get the actual font file data (TTF/OTF) for a given font description.
 + @param  family  Font family name.
 + @param  weight  Font weight.
 + @param  italic  Whether or not italic is requested.
 + @return  A font file matching the given description (either an on-disk font filepath or an
 +          in-memory file buffer). You can return NULL here and the loader will fallback to
 +          another font.
 +/
alias ULFontLoaderLoad = extern(C) ULFontFile function(ULString, int, bool);





/++
 + Low-level bindings for the Ultralight C API.
 + Source: https://github.com/ultralight-ux/Ultralight-API/blob/master/Ultralight/CAPI
 + Version as of time written: 1.4.0 (beta)
 +/
public extern(C) nothrow
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
        /// 
        kMessageSource_XML = 0,

        /// 
        kMessageSource_JS,

        /// 
        kMessageSource_Network,

        /// 
        kMessageSource_ConsoleAPI,

        /// 
        kMessageSource_Storage,

        /// 
        kMessageSource_AppCache,

        /// 
        kMessageSource_Rendering,

        /// 
        kMessageSource_CSS,

        /// 
        kMessageSource_Security,

        /// 
        kMessageSource_ContentBlocker,

        /// 
        kMessageSource_Media,

        /// 
        kMessageSource_MediaSource,

        /// 
        kMessageSource_WebRTC,

        /// 
        kMessageSource_ITPDebug,

        /// 
        kMessageSource_PrivateClickMeasurement,

        /// 
        kMessageSource_PaymentRequest,

        /// 
        kMessageSource_Other,
    }

    /++
     +
     +/
    enum ULMessageLevel
    {
        /// 
        kMessageLevel_Log = 0,

        /// 
        kMessageLevel_Warning,

        /// 
        kMessageLevel_Error,

        /// 
        kMessageLevel_Debug,

        /// 
        kMessageLevel_Info,
    }

    /++
     +
     +/
    enum ULCursor
    {
        /// 
        kCursor_Pointer = 0,

        /// 
        kCursor_Cross,

        /// 
        kCursor_Hand,

        /// 
        kCursor_IBeam,

        /// 
        kCursor_Wait,

        /// 
        kCursor_Help,

        /// 
        kCursor_EastResize,

        /// 
        kCursor_NorthResize,

        /// 
        kCursor_NorthEastResize,

        /// 
        kCursor_NorthWestResize,

        /// 
        kCursor_SouthResize,

        /// 
        kCursor_SouthEastResize,

        /// 
        kCursor_SouthWestResize,

        /// 
        kCursor_WestResize,

        /// 
        kCursor_NorthSouthResize,

        /// 
        kCursor_EastWestResize,

        /// 
        kCursor_NorthEastSouthWestResize,

        /// 
        kCursor_NorthWestSouthEastResize,

        /// 
        kCursor_ColumnResize,

        /// 
        kCursor_RowResize,

        /// 
        kCursor_MiddlePanning,

        /// 
        kCursor_EastPanning,

        /// 
        kCursor_NorthPanning,

        /// 
        kCursor_NorthEastPanning,

        /// 
        kCursor_NorthWestPanning,

        /// 
        kCursor_SouthPanning,

        /// 
        kCursor_SouthEastPanning,

        /// 
        kCursor_SouthWestPanning,

        /// 
        kCursor_WestPanning,

        /// 
        kCursor_Move,

        /// 
        kCursor_VerticalText,

        /// 
        kCursor_Cell,

        /// 
        kCursor_ContextMenu,

        /// 
        kCursor_Alias,

        /// 
        kCursor_Progress,

        /// 
        kCursor_NoDrop,

        /// 
        kCursor_Copy,

        /// 
        kCursor_None,

        /// 
        kCursor_NotAllowed,

        /// 
        kCursor_ZoomIn,

        /// 
        kCursor_ZoomOut,

        /// 
        kCursor_Grab,

        /// 
        kCursor_Grabbing,

        /// 
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
        /// 
        kMouseEventType_MouseMoved,

        /// 
        kMouseEventType_MouseDown,

        /// 
        kMouseEventType_MouseUp,
    }

    /++
     +
     +/
    enum ULMouseButton
    {
        /// 
        kMouseButton_None = 0,

        /// 
        kMouseButton_Left,

        /// 
        kMouseButton_Middle,

        /// 
        kMouseButton_Right,
    }

    /++
     +
     +/
    enum ULScrollEventType
    {
        /// 
        kScrollEventType_ScrollByPixel,

        /// 
        kScrollEventType_ScrollByPage,
    }

    /++
     +
     +/
    enum ULGamepadEventType
    {
        /// 
        kGamepadEventType_Connected,

        /// 
        kGamepadEventType_Disconnected,
    }

    /++
     +
     +/
    enum ULFaceWinding
    {
        /// 
        kFaceWinding_Clockwise,

        /// 
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
     + Offscreen render target, used when rendering Views via the GPU renderer.
     + When a View is rendered via the GPU renderer (see ulViewIsAccelerated()), it will be rendered to
     + an offscreen render target (ulViewGetRenderTarget()) that you can display in your application.
     + This is intended to be used with a custom ULGPUDriver implementation in a game or similar
     + application (ulPlatformSetGPUDriver()).
     +/
    struct ULRenderTarget
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

    /++
     + Get the version string of the library in MAJOR.MINOR.PATCH format.
     +/
    const(char*) ulVersionString();

    /++
     + Get the numeric major version of the library.
     +/
    uint ulVersionMajor();

    /++
     + Get the numeric minor version of the library.
     +/
    uint ulVersionMinor();

    /++
     + Get the numeric patch version of the library.
     +/
    uint ulVersionPatch();

    /++
     + Get the full WebKit version string.
     +/
    const(char*) ulWebKitVersionString();





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

    /++
     + Check if can navigate backwards in history.
     +/
    bool ulViewCanGoBack(ULView);

    /++
     + Check if can navigate forwards in history.
     +/
    bool ulViewCanGoForward(ULView);

    /++
     + Navigate backwards in history.
     +/
    void ulViewGoBack(ULView);

    /++
     + Navigate forwards in history.
     +/
    void ulViewGoForward(ULView);

    /++
     + Navigate to arbitrary offset in history.
     +/
    void ulViewGoToHistoryOffset(ULView, int);

    /++
     + Reload current page.
     +/
    void ulViewReload(ULView);

    /++
     + Stop all page loads.
     +/
    void ulViewStop(ULView);

    /++
     + Give focus to the View.
     + You should call this to give visual indication that the View has input focus (changes active
     + text selection colors, for example).
     +/
    void ulViewFocus(ULView);

    /++
     + Remove focus from the View and unfocus any focused input elements.
     + You should call this to give visual indication that the View has lost input focus.
     +/
    void ulViewUnfocus(ULView);

    /++
     + Whether or not the View has focus.
     +/
    bool ulViewHasFocus(ULView);

    /++
     + Whether or not the View has an input element with visible keyboard focus (indicated by a
     + blinking caret).
     + You can use this to decide whether or not the View should consume keyboard input events (useful
     + in games with mixed UI and key handling).
     +/
    bool ulViewHasInputFocus(ULView);

    /++
     + Fire a keyboard event.
     +/
    void ulViewFireKeyEvent(ULView, ULKeyEvent);

    /++
     + Fire a mouse event.
     +/
    void ulViewFireMouseEvent(ULView, ULMouseEvent);

    /++
     + Fire a scroll event.
     +/
    void ulViewFireScrollEvent(ULView, ULScrollEvent);

    /++
     + Set callback for when the page title changes.
     +/
    void ulViewSetChangeTitleCallback(ULView, ULChangeTitleCallback, void*);

    /++
     + Set callback for when the page URL changes.
     +/
    void ulViewSetChangeURLCallback(ULView, ULChangeURLCallback, void*);

    /++
     + Set callback for when the tooltip changes (usually result of a mouse hover).
     +/
    void ulViewSetChangeTooltipCallback(ULView, ULChangeTooltipCallback, void*);

    /++
     + Set callback for when the mouse cursor changes.
     +/
    void ulViewSetChangeCursorCallback(ULView, ULChangeCurserCallback, void*);

    /++
     + Set callback for when a message is added to the console (useful for JavaScript / network errors
     + and debugging).
     +/
    void ulViewSetAddConsoleMessageCallback(ULView, ULAddConsoleMessageCallback, void*);

    /++
     + Set callback for when the page wants to create a new View.
     + This is usually the result of a user clicking a link with target="_blank" or by JavaScript
     + calling window.open(url).
     + To allow creation of these new Views, you should create a new View in this callback, resize it
     + to your container, and return it. You are responsible for displaying the returned View.
     + You should return NULL if you want to block the action.
     +/
    void ulViewSetCreateChildViewCallback(ULView, ULCreateChildViewCallback, void*);

    /++
     + Set callback for when the page wants to create a new View to display the local inspector in.
     + You should create a new View in this callback, resize it to your
     + container, and return it. You are responsible for displaying the returned View.
     +/
    void ulViewSetCreateInspectorViewCallback(ULView, ULCreateInspectorViewCallback, void*);

    /++
     + Set callback for when the page begins loading a new URL into a frame.
     +/
    void ulViewSetBeginLoadingCallback(ULView, ULBeginLoadingCallback, void*);

    /++
     + Set callback for when the page finishes loading a URL into a frame.
     +/
    void ulViewSetFinishLoadingCallback(ULView, ULFinishLoadingCallback, void*);

    /++
     + Set callback for when an error occurs while loading a URL into a frame.
     +/
    void ulViewSetFailLoadingCallback(ULView, ULFailLoadingCallback, void*);

    /++
     + Set callback for when the JavaScript window object is reset for a new page load.
     + This is called before any scripts are executed on the page and is the earliest time to setup any
     + initial JavaScript state or bindings.
     + The document is not guaranteed to be loaded/parsed at this point. If you need to make any
     + JavaScript calls that are dependent on DOM elements or scripts on the page, use DOMReady
     + instead.
     + The window object is lazily initialized (this will not be called on pages with no scripts).
     +/
    void ulViewSetWindowObjectReadyCallback(ULView, ULWindowObjectReadyCallback, void*);

    /++
     + Set callback for when all JavaScript has been parsed and the document is ready.
     + This is the best time to make any JavaScript calls that are dependent on DOM elements or scripts
     + on the page.
     +/
    void ulViewSetDOMReadyCallback(ULView, ULDOMReadyCallback, void*);

    /++
     + Set callback for when the history (back/forward state) is modified.
     +/
    void ulViewSetUpdateHistoryCallback(ULView, ULUpdateHistoryCallback, void*);

    /++
     + Set whether or not a view should be repainted during the next call to ulRender.
     + @note  This flag is automatically set whenever the page content changes but you can set it
     +        directly in case you need to force a repaint.
     +/
    void ulViewSetNeedsPaint(ULView, bool);

    /++
     + Whether or not a view should be painted during the next call to ulRender.
     +/
    bool ulViewGetNeedsPaint(ULView);

    /++
     + Create an Inspector View to inspect / debug this View locally.
     + This will only succeed if you have the inspector assets in your filesystem-- the inspector
     + will look for file:///inspector/Main.html when it first loads.
     + You must handle ulViewSetCreateInspectorViewCallback so that the library has a View to display
     + the inspector in. This function will call the callback only if an inspector view is not
     + currently active.
     +/
    void ulViewCreateLocalInspectorView(ULView);





    /++
     + String
     +/
    
    /++
     + Create string from null-terminated ASCII C-string.
     +/
    ULString ulCreateString(const(char*));

    /++
     + Create string from UTF-8 buffer.
     +/
    ULString ulCreateStringUTF8(const(char*), size_t);

    /++
     + Create string from UTF-16 buffer.
     +/
    ULString ulCreateStringUTF16(ULChar16*, size_t);

    /++
     + Create string from copy of existing string.
     +/
    ULString ulCreateStringFromCopy(ULString);

    /++
     + Destroy string (you should destroy any strings you explicitly Create).
     +/
    void ulDestroyString(ULString);

    /++
     + Get native UTF-8 buffer data (always null-terminated).
     +/
    char* ulStringGetData(ULString);

    /++
     + Get length (in bytes) of the UTF-8 buffer data, not including null terminator.
     +/
    size_t ulStringGetLength(ULString);

    /++
     + Whether this string is empty or not.
     +/
    bool ulStringIsEmpty(ULString);

    /++
     + Replaces the contents of 'str' with the contents of 'new_str'
     +/
    void ulStringAssignString(ULString, ULString);

    /++
     + Replaces the contents of 'str' with the contents of a C-string.
     +/
    void ulStringAssignCString(ULString, const(char*));





    /++
     + Bitmap
     +/
    
    /++
     + Create empty bitmap.
     +/
    ULBitmap ulCreateEmptyBitmap();

    /++
     + Create bitmap with certain dimensions and pixel format.
     +/
    ULBitmap ulCreateBitmap(uint, uint, ULBitmapFormat);

    /++
     + Create bitmap from existing pixel buffer. @see Bitmap for help using this function.
     + width, height, format, row_bytes, pixels, size, should_copy
     +/
    ULBitmap ulCreateBitmapFromPixels(uint, uint, ULBitmapFormat, uint, const(void*), size_t, bool);

    /++
     + Create bitmap from copy.
     +/
    ULBitmap ulCreateBitmapFromCopy(ULBitmap);

    /++
     + Destroy a bitmap (you should only destroy Bitmaps you have explicitly created via one of the
     + creation functions above.
     +/
    void ulDestroyBitmap(ULBitmap);

    /++
     + Get the width in pixels.
     +/
    uint ulBitmapGetWidth(ULBitmap);

    /++
     + Get the height in pixels.
     +/
    uint ulBitmapGetHeight(ULBitmap);

    /++
     + Get the pixel format.
     +/
    ULBitmapFormat ulBitmapGetFormat(ULBitmap);

    /++
     + Get the bytes per pixel.
     +/
    uint ulBitmapGetBpp(ULBitmap);

    /++
     + Get the number of bytes per row.
     +/
    uint ulBitmapGetRowBytes(ULBitmap);

    /++
     + Get the size in bytes of the underlying pixel buffer.
     +/
    size_t ulBitmapGetSize(ULBitmap);

    /++
     + Whether or not this bitmap owns its own pixel buffer.
     +/
    bool ulBitmapOwnPixels(ULBitmap);

    /++
     + Lock pixels for reading/writing, returns pointer to pixel buffer.
     +/
    void* ulBitmapLockPixels(ULBitmap);

    /++
     + Unlock pixels after locking.
     +/
    void ulBitmapUnlockPixels(ULBitmap);

    /++
     + Get raw pixel buffer-- you should only call this if Bitmap is already locked.
     +/
    void* ulBitmapRawPixels(ULBitmap);

    /++
     + Whether or not this bitmap is empty.
     +/
    bool ulBitmapIsEmpty(ULBitmap);

    /++
     + Reset bitmap pixels to 0.
     +/
    void ulBitmapErase(ULBitmap);

    /++
     + Write bitmap to a PNG on disk.
     +/
    bool ulBitmapWritePNG(ULBitmap, const(char*)); 

    /++
     + This converts a BGRA bitmap to RGBA bitmap and vice-versa by swapping the red and blue channels.
     +/
    void ulBitmapSwapRedBlueChannels(ULBitmap);





    /++
     + Key Event
     +/

    /++
     + Create a key event, see KeyEvent in the C++ API for help with the parameters.
     +/
    ULKeyEvent ulCreateKeyEvent(ULKeyEventType, uint, int, int, ULString, ULString, bool, bool, bool);

    /++
     + Create a key event from native Windows event.
     +/
    version(Windows) ULKeyEvent ulCreateKeyEventWindows(ULKeyEventType, uintptr_t, intptr_t, bool);

    /++
     + Create a key event from native macOS event.
     +/
    version(OSX) ULKeyEvent ulCreateKeyEventMacOS(NSEvent*);

    /++
     + Destroy a key event.
     +/
    void ulDestroyKeyEvent(ULKeyEvent);





    /++
     + Mouse Event
     +/
    
    /++
     + Create a mouse event, see MouseEvent in the C++ API for help using this function.
     +/
    ULMouseEvent ulCreateMouseEvent(ULMouseEventType, int, int, ULMouseButton);

    /++
     + Destroy a mouse event.
     +/
    void ulDestroyMouseEvent(ULMouseEvent);





    /++
     +  Scroll Event
     +/

    /++
     + Create a scroll event, see ScrollEvent in the C++ API for help using this function.
     +/
    ULScrollEvent ulCreateScrollEvent(ULScrollEventType, int, int);

    /++
     + Destroy a scroll event.
     +/
    void ulDestroyScrollEvent(ULScrollEvent);





    /++
     + Gamepad Event
     +/
    
    /++
     + Create a gamepad event, see GamepadEvent for help using this function.
     +/
    ULGamepadEvent ulCreateGamepadEvent(uint, ULGamepadEventType);

    /++
     + Destroy a gamepad event.
     +/
    void ulDestroyGamepadEvent(ULGamepadEvent);

    /++
     + Create a gamepad axis event, see GamepadAxisEvent for help using this function.
     +/
    ULGamepadAxisEvent ulCreateGamepadAxisEvent(uint, uint, double);

    /++
     + Destroy a gamepad axis event.
     +/
    void ulDestroyGamepadAxisEvent(ULGamepadAxisEvent);

    /++
     + Create a gamepad button event, see GamepadButtonEvent for help using this function.
     +/
    ULGamepadButtonEvent ulCreateGamepadButtonEvent(uint, uint, double);

    /++
     + Destroy a gamepad button event.
     +/
    void ulDestroyGamepadButton(ULGamepadButtonEvent);





    /++
     + Geometry
     +/
    
    /++
     + Whether or not a ULRect is empty (all members equal to 0)
     +/
    bool ulRectIsEmpty(ULRect);

    /++
     + Create an empty ULRect (all members equal to 0)
     +/
    ULRect ulRectMakeEmpty();

    /++
     + Whether or not a ULIntRect is empty (all members equal to 0)
     +/
    bool ulIntRectIsEmpty(ULIntRect);

    /++
     + Create an empty ULIntRect (all members equal to 0)
     +/
    ULIntRect ulIntRectMakeEmpty();





    /++
     + Surface
     +/
    
    /++
     + Width (in pixels).
     +/
    uint ulSurfaceGetWidth(ULSurface);

    /++
     + Height (in pixels).
     +/
    uint ulSurfaceGetHeight(ULSurface);

    /++
     + Number of bytes between rows (usually width * 4)
     +/
    uint ulSurfaceGetRowBytes(ULSurface);

    /++
     + Size in bytes.
     +/
    size_t ulSurfaceGetSize(ULSurface);

    /++
     + Lock the pixel buffer and get a pointer to the beginning of the data for reading/writing.
     + Native pixel format is premultiplied BGRA 32-bit (8 bits per channel).
     +/
    void* ulSurfaceLockPixels(ULSurface);

    /++
     + Unlock the pixel buffer.
     +/
    void ulSurfaceUnlockPixels(ULSurface);

    /++
     + Resize the pixel buffer to a certain width and height (both in pixels).
     + This should never be called while pixels are locked.
     +/
    void ulSurfaceResize(ULSurface, uint, uint);

    /++
     + Set the dirty bounds to a certain value.
     + This is called after the Renderer paints to an area of the pixel buffer. (The new value will be
     + joined with the existing dirty_bounds())
     +/
    void ulSurfaceSetDirtyBounds(ULSurface, ULIntRect);

    /++
     + Get the dirty bounds.
     + This value can be used to determine which portion of the pixel buffer has been updated since the
     + last call to ulSurfaceClearDirtyBounds().
     + The general algorithm to determine if a Surface needs display is:
     + <pre>
     +   if (!ulIntRectIsEmpty(ulSurfaceGetDirtyBounds(surface))) {
     +       // Surface pixels are dirty and needs display.
     +       // Cast Surface to native Surface and use it here (pseudo code)
     +       DisplaySurface(surface);
     +       // Once you're done, clear the dirty bounds:
     +       ulSurfaceClearDirtyBounds(surface);
     +   }
     + </pre>
     +/
    ULIntRect ulSurfaceGetDirtyBounds(ULSurface);

    /++
     + Clear the dirty bounds.
     + You should call this after you're done displaying the Surface.
     +/
    void ulSurfaceClearDirtyBounds(ULSurface);

    /++
     + Get the underlying user data pointer (this is only valid if you have set a custom surface
     + implementation via ulPlatformSetSurfaceDefinition).
     + This will return nullptr if this surface is the default ULBitmapSurface.
     +/
    void* ulSurfaceGetUserData(ULSurface);

    /++
     + Get the underlying Bitmap from the default Surface.
     + @note  Do not call ulDestroyBitmap() on the returned value, it is owned by the surface.
     +/
    ULBitmap ulBitmapSurfaceGetBitmap(ULBitmapSurface);

    /++
     + User-defined surface interface.
     + You should implement each of these callbacks, then pass an instance of this struct containing
     + your callbacks to ulPlatformSetSurfaceDefinition().
     +/
    struct ULSurfaceDefinition
    {
        ///
        public ULSurfaceDefinitionCreateCallback create;

        ///
        public ULSurfaceDefinitionDestroyCallback destroy;

        ///
        public ULSurfaceDefinitionGetWidthCallback get_width;

        ///
        public ULSurfaceDefinitionGetHeightCallback get_height;

        ///
        public ULSurfaceDefinitionGetRowBytesCallback get_row_bytes;

        ///
        public ULSurfaceDefinitionGetSizeCallback get_size;

        ///
        public ULSurfaceDefinitionLockPixelsCallback lock_pixels;

        ///
        public ULSurfaceDefinitionUnlockPixelsCallback unlock_pixels;

        ///
        public ULSurfaceDefinitionResizeCallback resize;
    }





    /++
     + File System
     +/

    /++
     + User-defined file system interface.
     + You should implement each of these callbacks, then pass an instance of this struct containing
     + your callbacks to ulPlatformSetFileSystem().
     +/
    struct ULFileSystem
    {
        ///
        public ULFileSystemFileExistsCallback file_exists;

        ///
        public ULFileSystemGetFileMimeTypeCallback get_file_mime_type;

        ///
        public ULFileSystemGetFileCharsetCallback get_file_charset;

        ///
        public ULFileSystemOpenFileCallback open_file;
    }

    



    /++
     + Logger
     +/
    
    /++
     + 
     +/
    enum ULLogLevel
    {
        /// 
        kLogLevel_Error = 0,

        /// 
        kLogLevel_Warning,

        /// 
        kLogLevel_Info,
    }

    /++
     + 
     +/
    struct ULLogger
    {
        ///
        public ULLoggerLogMessageCallback log_message;
    }





    /++
     + GPU Driver
     +/
    
    /++
     + Render buffer description.
     + This structure describes a render buffer that can be used as a target for drawing commands.
     +/
    struct ULRenderBuffer
    {
        /// The backing texture for this RenderBuffer
        public uint texture_id;

        /// The width of the RenderBuffer texture
        public uint width;

        /// The height of the RenderBuffer texture
        public uint height;

        /// Currently unused, always false.
        public bool has_stencil_buffer;

        /// Currently unsued, always false.
        public bool has_depth_buffer;
    }

    /++
     + Vertex layout for path vertices.
     + This struct is the in-memory layout for each path vertex (useful for synthesizing or modifying
     + your own vertex data).
     +/
    align(1) struct ULVertex_2f_4ub_2f
    {
        ///
        public float[2] pos;

        ///
        public ubyte[4] color;

        ///
        public float[2] obj;

    }

    /++
     + Vertex layout for quad vertices.
     + This struct is the in-memory layout for each quad vertex (useful for synthesizing or modifying
     + your own vertex data).
     +/
    align(1) struct ULVertex_2f_4ub_2f_2f_28f
    {
        ///
        public float[2] pos;

        ///
        public ubyte[4] color;

        ///
        public float[2] tex;

        ///
        public float[2] obj;

        ///
        public float[4] data0;

        ///
        public float[4] data1;

        ///
        public float[4] data2;

        ///
        public float[4] data3;

        ///
        public float[4] data4;

        ///
        public float[4] data5;

        ///
        public float[4] data6;
    }

    /++
     + Vertex buffer formats.
     + This enumeration describes the format of a vertex buffer.
     +/
    enum ULVertexBufferFormat
    {
        /// Vertex_2f_4ub_2f (used for path rendering)
        kVertexBufferFormat_2f_4ub_2f,

        /// Vertex_2f_4ub_2f_2f_28f (used for quad rendering)
        kVertexBufferFormat_2f_4ub_2f_2f_28f,
    }

    /++
     + Vertex buffer description.
     + @see ULGPUDriver::create_geometry
     +/
    struct ULVertexBuffer
    {
        /// The format of the vertex buffer.
        public ULVertexBufferFormat format;

        /// The size of the vertex buffer in bytes.
        public uint size;

        /// The raw vertex buffer data.
        public ubyte* data;
    }

    /++
     + Index buffer description.
     + This structure describes an index buffer that can be used to index into a vertex buffer.
     + @note The index buffer is a simple array of IndexType values.
     +/
    struct ULIndexBuffer
    {
        /// The size of the index buffer in bytes.
        public uint size;

        /// The raw index buffer data.
        public ubyte* data;
    }

    /++
     + Shader program types, used with ULGPUState::shader_type
     + Each of these correspond to a vertex/pixel shader pair. You can find stock shader code for these
     + in the `shaders` folder of the AppCore repo.
     +/
    enum ULShaderType
    {
        /// Shader program for filling quad geometry.
        kShaderType_Fill,

        /// Shader program for filling tesselated path geometry.
        kShaderType_FillPath,
    }

    /++
     + Raw 4x4 matrix as an array of floats in column-major order.
     +/
    struct ULMatrix4x4
    {
        ///
        public float[16] data;
    }

    /++
     + 4-component float vector
     +/
    struct ULvec4
    {
        ///
        public float[4] value;
    }

    /++
     + The state of the GPU for a given draw command.
     + This structure describes the current state of the GPU for a given draw command.
     +/
    struct ULGPUState
    {
        /// Viewport width in pixels
        public uint viewport_width;

        /// Viewport height in pixels
        public uint viewport_height;

        /// Transform matrix-- you should multiply this with the screen-space orthographic projection
        /// matrix then pass to the vertex shader.
        public ULMatrix4x4 transform;

        /// Whether or not we should enable texturing for the current draw command.
        public bool enable_texturing;

        /// Whether or not we should enable blending for the current draw command. If blending is
        /// disabled, any drawn pixels should overwrite existing. Mainly used so we can modify alpha
        /// values of the RenderBuffer during scissored clears.
        public bool enable_blend;

        /// The vertex/pixel shader program pair to use for the current draw command. You should cast this
        /// to ShaderType to get the corresponding enum.
        public ubyte shader_type;

        /// The render buffer to use for the current draw command.
        public uint render_buffer_id;

        /// The texture id to bind to slot #1. (Will be 0 if none)
        public uint texture_1_id;

        /// The texture id to bind to slot #2. (Will be 0 if none)
        public uint texture_2_id;

        /// The texture id to bind to slot #3. (Will be 0 if none)
        public uint texture_3_id;

        /// The uniform scalars (passed to the pixel shader via uniforms).
        public float[8] uniform_scalar;

        /// The uniform vectors (passed to the pixel shader via uniforms).
        public ULvec4[8] uniform_vector;

        /// The clip size (passed to the pixel shader via uniforms).
        public ubyte clip_size;

        /// The clip stack (passed to the pixel shader via uniforms).
        public ULMatrix4x4[8] clip;

        /// Whether or not scissor testing should be used for the current draw command.
        public bool enable_scissor;

        /// The scissor rect to use for scissor testing (units in pixels)
        public ULIntRect scissor_rect;
    }

    /++
     + The types of commands.
     + This enumeration describes the type of command to execute on the GPU. Used with
     + ULCommand::command_type
     +/
    enum ULCommandType
    {
        /// Clear the specified render buffer.
        kCommandType_ClearRenderBuffer,

        /// Draw the specified geometry to the specified render buffer.
        kCommandType_DrawGeometry,
    }

    /++
     + A command to execute on the GPU.
     + This structure describes a command to be executed on the GPU.
     + Commands are dispatched to the GPU driver asynchronously via ULGPUDriver::update_command_list,
     + the GPU driver should consume these commands and execute them at an appropriate time.
     + @see ULCommandList
     +/
    struct ULCommand
    {
        /// The type of command to dispatch.
        public ubyte command_type;

        /// The current GPU state.
        public ULGPUState gpu_state;

        /// The geometry ID to bind. (used with kCommandType_DrawGeometry)
        public uint geometry_id;
        
        /// The number of indices.   (used with kCommandType_DrawGeometry)
        public uint indices_count;

        /// The index to start from. (used with kCommandType_DrawGeometry)
        public uint indices_offset;
    }

    /++
     + List of commands to execute on the GPU.
     + @see ULGPUDriver::update_command_list
     +/
    struct ULCommandList
    {
        /// The number of commands in the list.
        public uint size;

        /// The raw command list data.
        public ULCommand* commands;
    }

    struct ULGPUDriver
    {
        /// 
        public ULGPUDriverBeginSynchronizeCallback begin_synchronize;

        /// 
        public ULGPUDriverEndSynchronizeCallback end_synchronize;

        /// 
        public ULGPUDriverNextTextureIdCallback next_texture_id;

        /// 
        public ULGPUDriverCreateTextureCallback create_texture;

        /// 
        public ULGPUDriverUpdateTextureCallback update_texture;

        /// 
        public ULGPUDriverDestroyTextureCallback destroy_texture;

        /// 
        public ULGPUDriverNextRenderBufferIdCallback next_render_buffer_id;

        /// 
        public ULGPUDriverCreateRenderBufferCallback create_render_buffer;

        /// 
        public ULGPUDriverDestroyRenderBufferCallback destroy_render_buffer;

        /// 
        public ULGPUDriverNextGeometryIdCallback next_geometry_id;

        /// 
        public ULGPUDriverCreateGeometryCallback create_geometry;

        /// 
        public ULGPUDriverUpdateGeometryCallback update_geometry;

        /// 
        public ULGPUDriverDestroyGeometryCallback destroy_geometry;

        /// 
        public ULGPUDriverUpdateCommandListCallback update_command_list;
    }

    /++
     + Sets up an orthographic projection matrix with a certain viewport width and height, multiplies
     + it by 'transform', and returns the result.
     + This should be used to calculate the model-view projection matrix for the vertex shaders using
     + the current ULGPUState.
     + The 'flip_y' can be optionally used to flip the Y coordinate-space. (Usually flip_y == true for
     + OpenGL)
     +/
    ULMatrix4x4 ulApplyProjection(ULMatrix4x4 transform, float viewport_width, float viewport_height, bool flip_y);





    /++
     + Clipboard
     +/

    /++
     + User-defined clipboard interface.
     + You should implement each of these callbacks, then pass an instance of this struct containing
     + your callbacks to ulPlatformSetClipboard().
     +/
    struct ULClipboard
    {
        /// 
        public ULClipboardClearCallback clear;

        /// 
        public ULClipboardReadPlainTextCallback read_plain_text;

        /// 
        public ULClipboardWritePlainTextCallback write_plain_text;
    }





    /++
     + Buffer
     +/

    /++
     + Create a Buffer from existing, user-owned data without any copies. An optional, user-supplied
     + callback will be called to deallocate data upon destruction.
     + @param  data                  A pointer to the data.
     + @param  size                  Size of the data in bytes.
     + @param  user_data             Optional user data that will be passed to destruction_callback
     +                               when the returned Buffer is destroyed.
     + @param  destruction_callback  Optional callback that will be called upon destruction. Pass a
     +                               null pointer if you don't want to be informed of destruction.
     +/
    ULBuffer ulCreateBuffer(void*, size_t, void*, ulDestroyBufferCallback);

    /++
     + Create a Buffer from existing data, a deep copy of data will be made.
     +/
    ULBuffer ulCreateBufferFromCopy(const(void*), size_t);

    /++
     + Destroy buffer (you should destroy any buffers you explicitly Create).
     +/
    void ulDestroyBuffer(ULBuffer);

    /++
     + Get a pointer to the raw byte data.
     +/
    void* ulBufferGetData(ULBuffer);

    /++
     + Get the size in bytes.
     +/
    size_t ulBufferGetSize(ULBuffer);

    /++
     + Get the user data associated with this Buffer, if any.
     +/
    void* ulBufferGetUserData(ULBuffer);

    /++
     + Check whether this Buffer owns its own data (Buffer was created via ulCreateBufferFromCopy).
     + If this is false, Buffer will call the user-supplied destruction callback to deallocate data
     + when this Buffer instance is destroyed.
     +/
    bool ulBufferOwnsData(ULBuffer);





    /++
     + Font File
     +/
    
    /++
     + Create a font file from an on-disk file path.
     + @note  The file path should already exist.
     +/
    ULFontFile ulFontFileCreateFromFilePath(ULString);

    /++
     + Create a font file from an in-memory buffer.
     +/
    ULFontFile ulFontFileCreateFromBuffer(ULBuffer);

    /++
     + Destroy font file
     +/
    void ulDestroyFontFile(ULFontFile);





    /++
     + Font Loader
     +/

    /++
     + User-defined font loader interface.
     + You should implement each of these callbacks, then pass an instance of this struct containing
     + your callbacks to ulPlatformSetFontLoader().
     +/
    struct ULFontLoader
    {
        /// 
        public ULFontLoaderGetFallbackFont get_fallback_font;

        /// 
        public ULFontLoaderGetFallbackFontForCharacters get_fallback_font_for_characters;

        /// 
        public ULFontLoaderLoad load;
    }





    /++
     + Image Source
     +/

    /++
     + Create an image source from a GPU texture with optional backing bitmap.
     + @param  width  The width of the image in pixels (used for layout).
     + @param  height  The height of the image in pixels (used for layout).
     + @param  texture_id  The GPU texture identifier to bind when drawing the quad for this image.
     +                     This should be non-zero and obtained from ULGPUDriver::next_texture_id.
     + @param  texture_uv  The UV coordinates of the texture.
     + @param  bitmap  Optional backing bitmap for this image source. This is used when drawing
     +                 the image using the CPU renderer or when pixel data is needed for other
     +                 purposes. You should update this bitmap when the texture changes.
     + @return  A new image source instance.
     +/
    ULImageSource ulCreateImageSourceFromTexture(uint, uint, uint, ULRect, ULBitmap);

    /++
     + Create an image source from a bitmap.
     + @param  bitmap  The backing bitmap for this image source.
     + @return  A new image source instance.
     +/
    ULImageSource ulCreateImageSourceFromBitmap(ULBitmap);

    /++
     + Destroy an image source.
     + @param  image_source  The image source to destroy.
     +/
    void ulDestroyImageSource(ULImageSource);

    /++
     + Invalidate the image source, notifying the library that the image has changed
     + and should be redrawn.
     +/
    void ulImageSourceInvalidate(ULImageSource);

    /++
     + Add an image source to the provider.
     + @param  id  The identifier of the image source.
     + @param  image_source  The image source to add.
     +/
    void ulImageSourceProviderAddImageSource(ULString, ULImageSource);

    /++
     + Remove an image source from the provider.
     + @param  id  The identifier of the image source.
     +/
    void ulImageSourceProviderRemoveImageSource(ULString);





    /++
     + Platform
     +/

    /++
     + Set a custom Logger implementation.
     + This is used to log debug messages to the console or to a log file.
     + You should call this before ulCreateRenderer() or ulCreateApp().
     + @note  ulCreateApp() will use the default logger if you never call this.
     + @note  If you're not using ulCreateApp(), (eg, using ulCreateRenderer()) you can still use the
     +        default logger by calling ulEnableDefaultLogger() (@see <AppCore/CAPI.h>)
     +/
    void ulPlatformSetLogger(ULLogger);

    /++
     + Set a custom FileSystem implementation.
     + The library uses this to load all file URLs (eg, <file:///page.html>).
     + You can provide the library with your own FileSystem implementation so that file assets are
     + loaded from your own pipeline.
     + You should call this before ulCreateRenderer() or ulCreateApp().
     + @warning This is required to be defined before calling ulCreateRenderer()
     + @note  ulCreateApp() will use the default platform file system if you never call this.
     + @note  If you're not using ulCreateApp(), (eg, using ulCreateRenderer()) you can still use the
     +        default platform file system by calling ulEnablePlatformFileSystem()'
     +        (@see <AppCore/CAPI.h>)
     +/
    void ulPlatformSetFileSystem(ULFileSystem);

    /++
     + Set a custom FontLoader implementation.
     + The library uses this to load all system fonts.
     + Every operating system has its own library of installed system fonts. The FontLoader interface
     + is used to lookup these fonts and fetch the actual font data (raw TTF/OTF file data) for a given
     + given font description.
     + You should call this before ulCreateRenderer() or ulCreateApp().
     + @warning This is required to be defined before calling ulCreateRenderer()
     + @note  ulCreateApp() will use the default platform font loader if you never call this.
     + @note  If you're not using ulCreateApp(), (eg, using ulCreateRenderer()) you can still use the
     +        default platform font loader by calling ulEnablePlatformFontLoader()'
     +        (@see <AppCore/CAPI.h>)
     +/
    void ulPlatformSetFontLoader(ULFontLoader);

    /++
     + Set a custom Surface implementation.
     + This can be used to wrap a platform-specific GPU texture, Windows DIB, macOS CGImage, or any
     + other pixel buffer target for display on screen.
     + By default, the library uses a bitmap surface for all surfaces but you can override this by
     + providing your own surface definition here.
     + You should call this before ulCreateRenderer() or ulCreateApp().
     +/
    void ulPlatformSetSurfaceDefinition(ULSurfaceDefinition);

    /++
     + Set a custom GPUDriver implementation.
     + This should be used if you have enabled the GPU renderer in the Config and are using
     + ulCreateRenderer() (which does not provide its own GPUDriver implementation).
     + The GPUDriver interface is used by the library to dispatch GPU calls to your native GPU context
     + (eg, D3D11, Metal, OpenGL, Vulkan, etc.) There are reference implementations for this interface
     + in the AppCore repo.
     + You should call this before ulCreateRenderer().
     +/
    void ulPlatformSetGPUDriver(ULGPUDriver);

    /++
     + Set a custom Clipboard implementation.
     + This should be used if you are using ulCreateRenderer() (which does not provide its own
     + clipboard implementation).
     + The Clipboard interface is used by the library to make calls to the system's native clipboard
     + (eg, cut, copy, paste).
     + You should call this before ulCreateRenderer().
     +/
    void ulPlatformSetClipboard(ULClipboard);
}