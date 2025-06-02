module ultralightd.bindings.ultralight;

import std.stdint;

public alias JSContextRef = void*;

/// Opaque types
public struct C_Config;
public struct C_Renderer;
public struct C_Session;
public struct C_ViewConfig;
public struct C_View;
public struct C_Bitmap;
public struct C_String;
public struct C_Buffer;
public struct C_KeyEvent;
public struct C_MouseEvent;
public struct C_ScrollEvent;
public struct C_GamepadEvent;
public struct C_GamepadAxisEvent;
public struct C_GamepadButtonEvent;
public struct C_Surface;
public struct C_FontFile;
public struct C_ImageSource;

/// Type aliases
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
public alias ULChar16 = ushort;
public alias ULIndexType = uint;

/// Callback types
public alias ULClipboardClearCallback = extern(C) void function();
public alias ULClipboardReadPlainTextCallback = extern(C) void function(ULString result);
public alias ULClipboardWritePlainTextCallback = extern(C) void function(ULString text);
public alias ULDestroyBufferCallback = extern(C) void function(void* user_data, void* data);

public alias ULLoggerLogMessageCallback = extern(C) void function(ULLogLevel log_level, ULString message);

public alias ULFileSystemFileExistsCallback = extern(C) bool function(ULString path);
public alias ULFileSystemGetFileMimeTypeCallback = extern(C) ULString function(ULString path);
public alias ULFileSystemGetFileCharsetCallback = extern(C) ULString function(ULString path);
public alias ULFileSystemOpenFileCallback = extern(C) ULBuffer function(ULString path);

public alias ULFontLoaderGetFallbackFont = extern(C) ULString function();
public alias ULFontLoaderGetFallbackFontForCharacters = extern(C) ULString function(ULString characters, int weight, bool italic);
public alias ULFontLoaderLoad = extern(C) ULFontFile function(ULString family, int weight, bool italic);

public alias ULSurfaceDefinitionCreateCallback = extern(C) void* function(uint width, uint height);
public alias ULSurfaceDefinitionDestroyCallback = extern(C) void function(void* user_data);
public alias ULSurfaceDefinitionGetWidthCallback = extern(C) uint function(void* user_data);
public alias ULSurfaceDefinitionGetHeightCallback = extern(C) uint function(void* user_data);
public alias ULSurfaceDefinitionGetRowBytesCallback = extern(C) uint function(void* user_data);
public alias ULSurfaceDefinitionGetSizeCallback = extern(C) size_t function(void* user_data);
public alias ULSurfaceDefinitionLockPixelsCallback = extern(C) void* function(void* user_data);
public alias ULSurfaceDefinitionUnlockPixelsCallback = extern(C) void function(void* user_data);
public alias ULSurfaceDefinitionResizeCallback = extern(C) void function(void* user_data, uint width, uint height);

public alias ULChangeTitleCallback = extern(C) void function(void* user_data, ULView caller, ULString title);
public alias ULChangeURLCallback = extern(C) void function(void* user_data, ULView caller, ULString url);
public alias ULChangeTooltipCallback = extern(C) void function(void* user_data, ULView caller, ULString tooltip);
public alias ULChangeCursorCallback = extern(C) void function(void* user_data, ULView caller, ULCursor cursor);
public alias ULAddConsoleMessageCallback = extern(C) void function(void* user_data, ULView caller, ULMessageSource source, ULMessageLevel level, ULString message, uint line_number, uint column_number, ULString source_id);
public alias ULCreateChildViewCallback = extern(C) ULView function(void* user_data, ULView caller, ULString opener_url, ULString target_url, bool is_popup, ULIntRect popup_rect);
public alias ULCreateInspectorViewCallback = extern(C) ULView function(void* user_data, ULView caller, bool is_local, ULString inspected_url);
public alias ULBeginLoadingCallback = extern(C) void function(void* user_data, ULView caller, ulong frame_id, bool is_main_frame, ULString url);
public alias ULFinishLoadingCallback = extern(C) void function(void* user_data, ULView caller, ulong frame_id, bool is_main_frame, ULString url);
public alias ULFailLoadingCallback = extern(C) void function(void* user_data, ULView caller, ulong frame_id, bool is_main_frame, ULString url, ULString description, ULString error_domain, int error_code);
public alias ULWindowObjectReadyCallback = extern(C) void function(void* user_data, ULView caller, ulong frame_id, bool is_main_frame, ULString url);
public alias ULDOMReadyCallback = extern(C) void function(void* user_data, ULView caller, ulong frame_id, bool is_main_frame, ULString url);
public alias ULUpdateHistoryCallback = extern(C) void function(void* user_data, ULView caller);

public alias ULGPUDriverBeginSynchronizeCallback = extern(C) void function();
public alias ULGPUDriverEndSynchronizeCallback = extern(C) void function();
public alias ULGPUDriverNextTextureIdCallback = extern(C) uint function();
public alias ULGPUDriverCreateTextureCallback = extern(C) void function(uint texture_id, ULBitmap bitmap);
public alias ULGPUDriverUpdateTextureCallback = extern(C) void function(uint texture_id, ULBitmap bitmap);
public alias ULGPUDriverDestroyTextureCallback = extern(C) void function(uint texture_id);
public alias ULGPUDriverNextRenderBufferIdCallback = extern(C) uint function();
public alias ULGPUDriverCreateRenderBufferCallback = extern(C) void function(uint render_buffer_id, ULRenderBuffer buffer);
public alias ULGPUDriverDestroyRenderBufferCallback = extern(C) void function(uint render_buffer_id);
public alias ULGPUDriverNextGeometryIdCallback = extern(C) uint function();
public alias ULGPUDriverCreateGeometryCallback = extern(C) void function(uint geometry_id, ULVertexBuffer vertices, ULIndexBuffer indices);
public alias ULGPUDriverUpdateGeometryCallback = extern(C) void function(uint geometry_id, ULVertexBuffer vertices, ULIndexBuffer indices);
public alias ULGPUDriverDestroyGeometryCallback = extern(C) void function(uint geometry_id);
public alias ULGPUDriverUpdateCommandListCallback = extern(C) void function(ULCommandList list);

/// Enum definitions
extern(C) public enum ULMessageSource
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
    kMessageSource_PrivateClientMeasurement,
    kMessageSource_PaymentRequest,
    kMessageSource_Other,
}

extern(C) public enum ULMessageLevel
{
    kMessageLevel_Log = 0,
    kMessageLevel_Warning,
    kMessageLevel_Error,
    kMessageLevel_Debug,
    kMessageLevel_Info,
}

extern(C) public enum ULCursor
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

extern(C) public enum ULBitmapFormat
{
    kBitmapFormat_A8_UNORM,
    kBitmapFormat_BGRA8_UNORM_SRGB,
}

extern(C) public enum ULKeyEventType
{
    kKeyEventType_KeyDown,
    kKeyEventType_KeyUp,
    kKeyEventType_RawKeyDown,
    kKeyEventType_Char,
}

extern(C) public enum ULMouseEventType
{
    kMouseEventType_MouseMoved,
    kMouseEventType_MouseDown,
    kMouseEventType_MouseUp,
}

extern(C) public enum ULMouseButton
{
    kMouseButton_None = 0,
    kMouseButton_Left,
    kMouseButton_Middle,
    kMouseButton_Right,
}

extern(C) public enum ULScrollEventType
{
    kScrollEventType_ScrollByPixel,
    kScrollEventType_ScrollByPage,
}

extern(C) public enum ULGamepadEventType
{
    kGamepadEventType_Connected,
    kGamepadEventType_Disconnected,
}

extern(C) public enum ULFaceWinding
{
    kFaceWinding_Clockwise,
    kFaceWinding_CounterClockwise,
}

extern(C) public enum ULFontHinting
{
    kFontHinting_Smooth,
    kFontHinting_Normal,
    kFontHinting_Monochrome,
}

extern(C) public enum ULLogLevel
{
    kLogLevel_Error = 0,
    kLogLevel_Warning,
    kLogLevel_Info,
}

extern(C) public enum ULVertexBufferFormat
{
    kVertexBufferFormat_2f_4ub_2f,
    kVertexBufferFormat_2f_4ub_2f_2f_28f,
}

extern(C) public enum ULShaderType
{
    kShaderType_Fill,
    kShaderType_FillPath,
}

extern(C) public enum ULCommandType
{
    kCommandType_ClearRenderBuffer,
    kCommandType_DrawGeometry,
}

/// Struct definitions
extern(C) public struct ULRect
{
    public float left;
    public float top;
    public float right;
    public float bottom;
}

extern(C) public struct ULIntRect
{
    public int left;
    public int top;
    public int right;
    public int bottom;
}

extern(C) public struct ULRenderTarget
{
    public bool is_empty;
    public uint width;
    public uint height;
    public uint texture_id;
    public uint texture_width;
    public uint texture_height;
    public ULBitmapFormat texture_format;
    public ULRect uv_coords;
    public uint render_buffer_id;
}

extern(C) public struct ULClipboard
{
    public ULClipboardClearCallback clear;
    public ULClipboardReadPlainTextCallback read_plain_text;
    public ULClipboardWritePlainTextCallback write_plain_text;
}

extern(C) public struct ULLogger
{
    public ULLoggerLogMessageCallback log_message;
}

extern(C) public struct ULFileSystem
{
    public ULFileSystemFileExistsCallback file_exists;
    public ULFileSystemGetFileMimeTypeCallback get_file_mime_type;
    public ULFileSystemGetFileCharsetCallback get_file_charset;
    public ULFileSystemOpenFileCallback open_file;
}

extern(C) public struct ULFontLoader
{
    public ULFontLoaderGetFallbackFont get_fallback_font;
    public ULFontLoaderGetFallbackFontForCharacters get_fallback_font_for_characters;
    public ULFontLoaderLoad load;
}

extern(C) public struct ULSurfaceDefinition
{
    public ULSurfaceDefinitionCreateCallback create;
    public ULSurfaceDefinitionDestroyCallback destroy;
    public ULSurfaceDefinitionGetWidthCallback get_width;
    public ULSurfaceDefinitionGetHeightCallback get_height;
    public ULSurfaceDefinitionGetRowBytesCallback get_row_bytes;
    public ULSurfaceDefinitionGetSizeCallback get_size;
    public ULSurfaceDefinitionLockPixelsCallback lock_pixels;
    public ULSurfaceDefinitionUnlockPixelsCallback unlock_pixels;
    public ULSurfaceDefinitionResizeCallback resize;
}

extern(C) public struct ULRenderBuffer
{
    public uint texture_id;
    public uint width;
    public uint height;
    public bool has_stencil_buffer;
    public bool has_depth_buffer;
}

extern(C) align(1) public struct ULVertex_2f_4ub_2f
{
    public float[2] pos;
    public ubyte[4] color;
    public float[2] obj;
}

extern(C) align(1) public struct ULVertex_2f_4ub_2f_2f_28f
{
    public float[2] pos;
    public ubyte[4] color;
    public float[2] tex;
    public float[2] obj;
    public float[4] data0;
    public float[4] data1;
    public float[4] data2;
    public float[4] data3;
    public float[4] data4;
    public float[4] data5;
    public float[4] data6;
}

extern(C) public struct ULVertexBuffer
{
    public ULVertexBufferFormat format;
    public uint size;
    public ubyte* data;
}

extern(C) public struct ULIndexBuffer
{
    public uint size;
    public ubyte* data;
}

extern(C) public struct ULMatrix4x4
{
    public float[16] data;
}

extern(C) public struct ULvec4
{
    public float[4] value;
}

extern(C) public struct ULGPUState
{
    public uint viewport_width;
    public uint viewport_height;
    public ULMatrix4x4 transform;
    public bool enable_texturing;
    public bool enable_blend;
    public ubyte shader_type;
    public uint render_buffer_id;
    public uint texture_1_id;
    public uint texture_2_id;
    public uint texture_3_id;
    public float[8] uniform_scalar;
    public ULvec4[8] uniform_vector;
    public ubyte clip_size;
    public ULMatrix4x4[8] clip;
    public bool enable_scissor;
    public ULIntRect scissor_rect;
}

extern(C) public struct ULCommand
{
    public ubyte command_type;
    public ULGPUState gpu_state;
    public uint geometry_id;
    public uint indices_count;
    public uint indices_offset;
}

extern(C) public struct ULCommandList
{
    public uint size;
    public ULCommand* commands;
}

extern(C) public struct ULGPUDriver
{
    public ULGPUDriverBeginSynchronizeCallback begin_synchronize;
    public ULGPUDriverEndSynchronizeCallback end_synchronize;
    public ULGPUDriverNextTextureIdCallback next_texture_id;
    public ULGPUDriverCreateTextureCallback create_texture;
    public ULGPUDriverUpdateTextureCallback update_texture;
    public ULGPUDriverDestroyTextureCallback destroy_texture;
    public ULGPUDriverNextRenderBufferIdCallback next_render_buffer_id;
    public ULGPUDriverCreateRenderBufferCallback create_render_buffer;
    public ULGPUDriverDestroyRenderBufferCallback destroy_render_buffer;
    public ULGPUDriverNextGeometryIdCallback next_geometry_id;
    public ULGPUDriverCreateGeometryCallback create_geometry;
    public ULGPUDriverUpdateGeometryCallback update_geometry;
    public ULGPUDriverDestroyGeometryCallback destroy_geometry;
    public ULGPUDriverUpdateCommandListCallback update_command_list;
}

/// Function declarations for the Version API
extern(C) @system
{
    public const(char)* ulVersionString();
    public uint ulVersionMajor();
    public uint ulVersionMinor();
    public uint ulVersionPatch();
    public const(char)* ulWebKitVersionString();
}

/// Function declarations for the Rect API
extern(C) @system
{
    public bool ulRectIsEmpty(ULRect rect);
    public ULRect ulRectMakeEmpty();
    public bool ulIntRectIsEmpty(ULIntRect rect);
    public ULIntRect ulIntRectMakeEmpty();
    public ULMatrix4x4 ulApplyProjection(ULMatrix4x4 transform, float viewport_width, float viewport_height, bool flip_y);
}

/// Function declarations for the String API
extern(C) @system
{
    public ULString ulCreateString(const(char)* str);
    public ULString ulCreateStringUTF8(const(char)* str, size_t length);
    public ULString ulCreateStringUTF16(ULChar16* str, size_t length);
    public ULString ulCreateStringFromCopy(ULString str);
    public void ulDestroyString(ULString str);
    public char* ulStringGetData(ULString str);
    public size_t ulStringGetLength(ULString str);
    public bool ulStringIsEmpty(ULString str);
    public void ulStringAssignString(ULString str, ULString new_str);
    public void ulStringAssignCString(ULString str, const(char)* c_str);
}

/// Function declarations for the Buffer API
extern(C) @system
{
    public ULBuffer ulCreateBuffer(void* data, size_t size, void* user_data, ULDestroyBufferCallback destruction_callback);
    public ULBuffer ulCreateBufferFromCopy(const(void)* data, size_t size);
    public void ulDestroyBuffer(ULBuffer buffer);
    public void* ulBufferGetData(ULBuffer buffer);
    public size_t ulBufferGetSize(ULBuffer buffer);
    public void* ulBufferGetUserData(ULBuffer buffer);
    public bool ulBufferOwnsData(ULBuffer buffer);
}

/// Function declarations for the Bitmap API
extern(C) @system
{
    public ULBitmap ulCreateEmptyBitmap();
    public ULBitmap ulCreateBitmap(uint width, uint height, ULBitmapFormat format);
    public ULBitmap ulCreateBitmapFromPixels(uint width, uint height, ULBitmapFormat format, uint row_bytes, const(void)* pixels, size_t size, bool should_copy);
    public ULBitmap ulCreateBitmapFromCopy(ULBitmap existing_bitmap);
    public void ulDestroyBitmap(ULBitmap bitmap);
    public uint ulBitmapGetWidth(ULBitmap bitmap);
    public uint ulBitmapGetHeight(ULBitmap bitmap);
    public ULBitmapFormat ulBitmapGetFormat(ULBitmap bitmap);
    public uint ulBitmapGetBpp(ULBitmap bitmap);
    public uint ulBitmapGetRowBytes(ULBitmap bitmap);
    public size_t ulBitmapGetSize(ULBitmap bitmap);
    public bool ulBitmapOwnsPixels(ULBitmap bitmap);
    public void* ulBitmapLockPixels(ULBitmap bitmap);
    public void ulBitmapUnlockPixels(ULBitmap bitmap);
    public void* ulBitmapRawPixels(ULBitmap bitmap);
    public bool ulBitmapIsEmpty(ULBitmap bitmap);
    public void ulBitmapErase(ULBitmap bitmap);
    public bool ulBitmapWritePNG(ULBitmap bitmap, const(char)* path);
    public void ulBitmapSwapRedBlueChannels(ULBitmap bitmap);
}

/// Function declarations for the Config API
extern(C) @system
{
    public ULConfig ulCreateConfig();
    public void ulDestroyConfig(ULConfig config);
    public void ulConfigSetCachePath(ULConfig config, ULString cache_path);
    public void ulConfigSetResourcePathPrefix(ULConfig config, ULString resource_path_prefix);
    public void ulConfigSetFaceWinding(ULConfig config, ULFaceWinding winding);
    public void ulConfigSetFontHinting(ULConfig config, ULFontHinting font_hinting);
    public void ulConfigSetFontGamma(ULConfig config, double font_gamma);
    public void ulConfigSetUserStylesheet(ULConfig config, ULString css_string);
    public void ulConfigSetForceRepaint(ULConfig config, bool enabled);
    public void ulConfigSetAnimationTimerDelay(ULConfig config, double delay);
    public void ulConfigSetScrollTimerDelay(ULConfig config, double delay);
    public void ulConfigSetRecycleDelay(ULConfig config, double delay);
    public void ulConfigSetMemoryCacheSize(ULConfig config, uint size);
    public void ulConfigSetPageCacheSize(ULConfig config, uint size);
    public void ulConfigSetOverrideRAMSize(ULConfig config, uint size);
    public void ulConfigSetMinLargeHeapSize(ULConfig config, uint size);
    public void ulConfigSetMinSmallHeapSize(ULConfig config, uint size);
    public void ulConfigSetNumRendererThreads(ULConfig config, uint num_renderer_threads);
    public void ulConfigSetMaxUpdateTime(ULConfig config, double max_update_time);
    public void ulConfigSetBitmapAlignment(ULConfig config, uint bitmap_alignment);
}

/// Function declarations for the View Config API
extern(C) @system
{
    public ULViewConfig ulCreateViewConfig();
    public void ulDestroyViewConfig(ULViewConfig config);
    public void ulViewConfigSetDisplayId(ULViewConfig config, uint display_id);
    public void ulViewConfigSetIsAccelerated(ULViewConfig config, bool is_accelerated);
    public void ulViewConfigSetIsTransparent(ULViewConfig config, bool is_transparent);
    public void ulViewConfigSetInitialDeviceScale(ULViewConfig config, double initial_device_scale);
    public void ulViewConfigSetInitialFocus(ULViewConfig config, bool is_focused);
    public void ulViewConfigSetEnableImages(ULViewConfig config, bool enabled);
    public void ulViewConfigSetEnableJavaScript(ULViewConfig config, bool enabled);
    public void ulViewConfigSetFontFamilyStandard(ULViewConfig config, ULString font_name);
    public void ulViewConfigSetFontFamilyFixed(ULViewConfig config, ULString font_name);
    public void ulViewConfigSetFontFamilySerif(ULViewConfig config, ULString font_name);
    public void ulViewConfigSetFontFamilySansSerif(ULViewConfig config, ULString font_name);
    public void ulViewConfigSetUserAgent(ULViewConfig config, ULString font_name);
}

/// Function declarations for the Platform API
extern(C) @system
{
    public void ulPlatformSetLogger(ULLogger logger);
    public void ulPlatformSetFileSystem(ULFileSystem file_system);
    public void ulPlatformSetFontLoader(ULFontLoader font_loader);
    public void ulPlatformSetSurfaceDefinition(ULSurfaceDefinition surface_definition);
    public void ulPlatformSetGPUDriver(ULGPUDriver gpu_driver);
    public void ulPlatformSetClipboard(ULClipboard clipboard);
}

/// Function declarations for the Renderer API
extern(C) @system
{
    public ULRenderer ulCreateRenderer(ULConfig config);
    public void ulDestroyRenderer(ULRenderer renderer);
    public void ulUpdate(ULRenderer renderer);
    public void ulRefreshDisplay(ULRenderer renderer, uint display_id);
    public void ulRender(ULRenderer renderer);
    public void ulPurgeMemory(ULRenderer renderer);
    public void ulLogMemoryUsage(ULRenderer renderer);
    public bool ulStartRemoteInspectorServer(ULRenderer renderer, const(char)* address, ushort port);
    public void ulSetGamepadDetails(ULRenderer renderer, uint index, ULString id, uint axis_count, uint button_count);
    public void ulFireGamepadEvent(ULRenderer renderer, ULGamepadEvent evt);
    public void ulFireGamepadAxisEvent(ULRenderer renderer, ULGamepadAxisEvent evt);
    public void ulFireGamepadButtonEvent(ULRenderer renderer, ULGamepadButtonEvent evt);
}

/// Function declarations for the Session API
extern(C) @system
{
    public ULSession ulCreateSession(ULRenderer renderer, bool is_persistent, ULString name);
    public void ulDestroySession(ULSession session);
    public ULSession ulDefaultSession(ULRenderer renderer);
    public bool ulSessionIsPersistent(ULSession session);
    public ULString ulSessionGetName(ULSession session);
    public ulong ulSessionGetId(ULSession session);
    public ULString ulSessionGetDiskPath(ULSession session);
}

/// Function declarations for the Surface API
extern(C) @system
{
    public uint ulSurfaceGetWidth(ULSurface surface);
    public uint ulSurfaceGetHeight(ULSurface surface);
    public uint ulSurfaceGetRowBytes(ULSurface surface);
    public size_t ulSurfaceGetSize(ULSurface surface);
    public void* ulSurfaceLockPixels(ULSurface surface);
    public void ulSurfaceUnlockPixels(ULSurface surface);
    public void ulSurfaceResize(ULSurface surface, uint width, uint height);
    public void ulSurfaceSetDirtyBounds(ULSurface surface, ULIntRect bounds);
    public ULIntRect ulSurfaceGetDirtyBounds(ULSurface surface);
    public void ulSurfaceClearDirtyBounds(ULSurface surface);
    public void* ulSurfaceGetUserData(ULSurface surface);
    public ULBitmap ulSurfaceGetBitmap(ULBitmapSurface surface);
}

/// Function declarations for the View API
extern(C) @system
{
    public ULView ulCreateView(ULRenderer renderer, uint width, uint height, ULViewConfig view_config, ULSession session);
    public void ulDestroyView(ULView view);
    public ULString ulViewGetURL(ULView view);
    public ULString ulViewGetTitle(ULView view);
    public uint ulViewGetWidth(ULView view);
    public uint ulViewGetHeight(ULView view);
    public uint ulViewGetDisplayId(ULView view);
    public void ulViewSetDisplayId(ULView view, uint display_id);
    public double ulViewGetDeviceScale(ULView view);
    public void ulViewSetDeviceScale(ULView view, double scale);
    public bool ulViewIsAccelerated(ULView view);
    public bool ulViewIsTransparent(ULView view);
    public bool ulViewIsLoading(ULView view);
    public ULRenderTarget ulViewGetRenderTarget(ULView view);
    public ULSurface ulViewGetSurface(ULView view);
    public void ulViewLoadHTML(ULView view, ULString html_string);
    public void ulViewLoadURL(ULView view, ULString url_string);
    public void ulViewResize(ULView view, uint width, uint height);
    public JSContextRef ulViewLockJSContext(ULView view);
    public void ulViewUnlockJSContext(ULView view);
    public ULString ulViewEvaluateScript(ULView view, ULString js_string, ULString* exception);
    public bool ulViewCanGoBack(ULView view);
    public bool ulViewCanGoForward(ULView view);
    public void ulViewGoBack(ULView view);
    public void ulViewGoForward(ULView view);
    public void ulViewGoToHistoryOffset(ULView view, int offset);
    public void ulViewReload(ULView view);
    public void ulViewStop(ULView view);
    public void ulViewFocus(ULView view);
    public void ulViewUnfocus(ULView view);
    public bool ulViewHasFocus(ULView view);
    public bool ulViewHasInputFocus(ULView view);
    public void ulViewFireKeyEvent(ULView view, ULKeyEvent key_event);
    public void ulViewFireMouseEvent(ULView view, ULMouseEvent mouse_event);
    public void ulViewFireScrollEvent(ULView view, ULScrollEvent scroll_event);
    public void ulViewSetChangeTitleCallback(ULView view, ULChangeTitleCallback callback, void* user_data);
    public void ulViewSetChangeURLCallback(ULView view, ULChangeURLCallback callback, void* user_data);
    public void ulViewSetChangeTooltipCallback(ULView view, ULChangeTooltipCallback callback, void* user_data);
    public void ulViewSetChangeCursorCallback(ULView view, ULChangeCursorCallback callback, void* user_data);
    public void ulViewSetAddConsoleMessageCallback(ULView view, ULAddConsoleMessageCallback callback, void* user_data);
    public void ulViewSetCreateChildViewCallback(ULView view, ULCreateChildViewCallback callback, void* user_data);
    public void ulViewSetCreateInspectorViewCallback(ULView view, ULCreateInspectorViewCallback callback, void* user_data);
    public void ulViewSetBeginLoadingCallback(ULView view, ULBeginLoadingCallback callback, void* user_data);
    public void ulViewSetFinishLoadingCallback(ULView view, ULFinishLoadingCallback callback, void* user_data);
    public void ulViewSetFailLoadingCallback(ULView view, ULFailLoadingCallback callback, void* user_data);
    public void ulViewSetWindowObjectReadyCallback(ULView view, ULWindowObjectReadyCallback callback, void* user_data);
    public void ulViewSetDOMReadyCallback(ULView view, ULDOMReadyCallback callback, void* user_data);
    public void ulViewSetUpdateHistoryCallback(ULView view, ULUpdateHistoryCallback callback, void* user_data);
    public void ulViewSetNeedsPaint(ULView view, bool needs_paint);
    public bool ulViewGetNeedsPaint(ULView view);
    public void ulViewCreateLocalInspectorView(ULView view);
}

/// Function declarations for the KeyEvent API
extern(C) @system
{
    public ULKeyEvent ulCreateKeyEvent(ULKeyEventType type, uint modifiers, int virtual_key_code, int native_key_code, ULString text, ULString unmodified_text, bool is_keypad, bool is_auto_repeat, bool is_system_key);
    public void ulDestroyKeyEvent(ULKeyEvent evt);
}

/// Function declarations for the MouseEvent API
extern(C) @system
{
    public ULMouseEvent ulCreateMouseEvent(ULMouseEventType type, int x, int y, ULMouseButton button);
    public void ulDestroyMouseEvent(ULMouseEvent evt);
}

/// Function declarations for the ScrollEvent API
extern(C) @system
{
    public ULScrollEvent ulCreateScrollEvent(ULScrollEventType type, int delta_x, int delta_y);
    public void ulDestroyScrollEvent(ULScrollEvent evt);
}

/// Function declarations for the GamepadEvent API
extern(C) @system
{
    public ULGamepadEvent ulCreateGamepadEvent(uint index, ULGamepadEventType type);
    public void ulDestroyGamepadEvent(ULGamepadEvent evt);
    public ULGamepadAxisEvent ulCreateGamepadAxisEvent(uint index, uint axis_index, double value);
    public void ulDestroyGamepadAxisEvent(ULGamepadAxisEvent evt);
    public ULGamepadButtonEvent ulCreateGamepadButtonEvent(uint index, uint button_index, double value);
    public void ulDestroyGamepadButtonEvent(ULGamepadButtonEvent evt);
}

/// Function declarations for the FontFile API
extern(C) @system
{
    public ULFontFile ulFontFileCreateFromFilePath(ULString file_path);
    public ULFontFile ulFontFileCreateFromBuffer(ULBuffer buffer);
    public void ulDestroyFontFile(ULFontFile font_file);
}

/// Function declarations for the ImageSource API
extern(C) @system
{
    public ULImageSource ulCreateImageSourceFromTexture(uint width, uint height, uint texture_id, ULRect texture_uv, ULBitmap bitmap);
    public ULImageSource ulCreateImageSourceFromBitmap(ULBitmap bitmap);
    public void ulDestroyImageSource(ULImageSource image_source);
    public void ulImageSourceInvalidate(ULImageSource image_source);
    public void ulImageSourceProviderAddImageSource(ULString id, ULImageSource image_source);
    public void ulImageSourceProviderRemoveImageSource(ULString id);
}
