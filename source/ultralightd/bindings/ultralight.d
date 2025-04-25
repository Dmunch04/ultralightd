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
public alias ULFontFile = C_FontFile*;
public alias ULImageSource = C_ImageSource*;
public alias ULChar16 = ushort;
public alias ULIndexType = uint;

/// Callback types
public alias ULClipboardClearCallback = extern(C) void function();
public alias ULClipboardReadPlainTextCallback = extern(C) void function(ULString result);
public alias ULClipboardWritePlainTextCallback = extern(C) void function(ULString text);
public alias ULDestroyBufferCallback = extern(C) void function(void* userData, void* data);

public alias ULLoggerLogMessageCallback = extern(C) void function(ULLogLevel logLevel, ULString message);

public alias ULFileSystemFileExistsCallback = extern(C) bool function(ULString path);
public alias ULFileSystemGetFileMimeTypeCallback = extern(C) ULString function(ULString path);
public alias ULFileSystemGetFileCharsetCallback = extern(C) ULString function(ULString path);
public alias ULFileSystemOpenFileCallback = extern(C) ULBuffer function(ULString path);

public alias ULFontLoaderGetFallbackFont = extern(C) ULString function();
public alias ULFontLoaderGetFallbackFontForCharacters = extern(C) ULString function(ULString characters, int weight, bool italic);
public alias ULFontLoaderLoad = extern(C) ULFontFile function(ULString family, int weight, bool italic);

public alias ULSurfaceDefinitionCreateCallback = extern(C) void* function(uint width, uint height);
public alias ULSurfaceDefinitionDestroyCallback = extern(C) void function(void* userData);
public alias ULSurfaceDefinitionGetWidthCallback = extern(C) uint function(void* userData);
public alias ULSurfaceDefinitionGetHeightCallback = extern(C) uint function(void* userData);
public alias ULSurfaceDefinitionGetRowBytesCallback = extern(C) uint function(void* userData);
public alias ULSurfaceDefinitionGetSizeCallback = extern(C) size_t function(void* userData);
public alias ULSurfaceDefinitionLockPixelsCallback = extern(C) void* function(void* userData);
public alias ULSurfaceDefinitionUnlockPixelsCallback = extern(C) void function(void* userData);
public alias ULSurfaceDefinitionResizeCallback = extern(C) void function(void* userData, uint width, uint height);

public alias ULChangeTitleCallback = extern(C) void function(void* userData, ULView caller, ULString title);
public alias ULChangeURLCallback = extern(C) void function(void* userData, ULView caller, ULString url);
public alias ULChangeTooltipCallback = extern(C) void function(void* userData, ULView caller, ULString tooltip);
public alias ULChangeCursorCallback = extern(C) void function(void* userData, ULView caller, ULCursor cursor);
public alias ULAddConsoleMessageCallback = extern(C) void function(void* userData, ULView caller, ULMessageSource source, ULMessageLevel level, ULString message, uint lineNumber, uint columnNumber, ULString sourceId);
public alias ULCreateChildViewCallback = extern(C) ULView function(void* userData, ULView caller, ULString openerURL, ULString targetURL, bool isPopup, ULIntRect popupRect);
public alias ULCreateInspectorViewCallback = extern(C) ULView function(void* userData, ULView caller, bool isLocal, ULString inspectedURL);
public alias ULBeginLoadingCallback = extern(C) void function(void* userData, ULView caller, ulong frameId, bool isMainFrame, ULString url);
public alias ULFinishLoadingCallback = extern(C) void function(void* userData, ULView caller, ulong frameId, bool isMainFrame, ULString url);
public alias ULFailLoadingCallback = extern(C) void function(void* userData, ULView caller, ulong frameId, bool isMainFrame, ULString url, ULString description, ULString errorDomain, int errorCode);
public alias ULWindowObjectReadyCallback = extern(C) void function(void* userData, ULView caller, ulong frameId, bool isMainFrame, ULString url);
public alias ULDOMReadyCallback = extern(C) void function(void* userData, ULView caller, ulong frameId, bool isMainFrame, ULString url);
public alias ULUpdateHistoryCallback = extern(C) void function(void* userData, ULView caller);

public alias ULGPUDriverBeginSynchronizeCallback = extern(C) void function();
public alias ULGPUDriverEndSynchronizeCallback = extern(C) void function();
public alias ULGPUDriverNextTextureIdCallback = extern(C) uint function();
public alias ULGPUDriverCreateTextureCallback = extern(C) void function(uint textureId, ULBitmap bitmap);
public alias ULGPUDriverUpdateTextureCallback = extern(C) void function(uint textureId, ULBitmap bitmap);
public alias ULGPUDriverDestroyTextureCallback = extern(C) void function(uint textureId);
public alias ULGPUDriverNextRenderBufferIdCallback = extern(C) uint function();
public alias ULGPUDriverCreateRenderBufferCallback = extern(C) void function(uint renderBufferId, ULRenderBuffer buffer);
public alias ULGPUDriverDestroyRenderBufferCallback = extern(C) void function(uint renderBufferId);
public alias ULGPUDriverNextGeometryIdCallback = extern(C) uint function();
public alias ULGPUDriverCreateGeometryCallback = extern(C) void function(uint geometryId, ULVertexBuffer vertices, ULIndexBuffer indices);
public alias ULGPUDriverUpdateGeometryCallback = extern(C) void function(uint geometryId, ULVertexBuffer vertices, ULIndexBuffer indices);
public alias ULGPUDriverDestroyGeometryCallback = extern(C) void function(uint geometryId);
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
    public ULMatrix4x4 ulApplyProjection(ULMatrix4x4 transform, float viewportWidth, float viewportHeight, bool flipY);
}
