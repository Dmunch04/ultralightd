module ultralightd.bindings.appcore;

import ultralightd.bindings.ultralight : ULString, ULConfig, ULRenderer, ULCursor, ULView;

/// Opaque types
public struct C_Settings;
public struct C_App;
public struct C_Window;
public struct C_Monitor;
public struct C_Overlay;

/// Type aliases
public alias ULSettings = C_Settings*;
public alias ULApp = C_App*;
public alias ULWindow = C_Window*;
public alias ULMonitor = C_Monitor*;
public alias ULOverlay = C_Overlay*;

/// Callback types
public alias ULUpdateCallback = extern(C) void function(void* user_data);
public alias ULCloseCallback = extern(C) void function(void* user_data, ULWindow window);
public alias ULResizeCallback = extern(C) void function(void* user_data, ULWindow window, uint width, uint height);

/// Enum definitions
extern(C) public enum ULWindowFlags : uint
{
    kWindowFlags_Borderless = 1 << 0,
    kWindowFlags_Titled = 1 << 1,
    kWindowFlags_Resizable = 1 << 2,
    kWindowFlags_Maximizable = 1 << 3,
    kWindowFlags_Hidden = 1 << 4,
}

// TODO: add doc comments to function decls

/// Function declarations for the Settings API
extern(C) @system
{
    public ULSettings ulCreateSettings();
    public void ulDestroySettings(ULSettings settings);
    public void ulSettingsSetDeveloperName(ULSettings settings, ULString name);
    public void ulSettingsSetAppName(ULSettings settings, ULString name);
    public void ulSettingsSetFileSystemPath(ULSettings settings, ULString path);
    public void ulSettingsSetLoadShadersFromFileSystem(ULSettings settings, bool enabled);
    public void ulSettingsSetForceCPURenderer(ULSettings settings, bool force_cpu);
}

/// Function declarations for the App API
extern(C) @system
{
    public ULApp ulCreateApp(ULSettings settings, ULConfig config);
    public void ulDestroyApp(ULApp app);
    public void ulAppSetUpdateCallback(ULApp app, ULUpdateCallback callback, void* user_data);
    public bool ulAppIsRunning(ULApp app);
    public ULMonitor ulAppGetMainMonitor(ULApp app);
    public ULRenderer ulAppGetRenderer(ULApp app);
    public void ulAppRun(ULApp app);
    public void ulAppQuit(ULApp app);
}

/// Function declarations for the Monitor API
extern(C) @system
{
    public double ulMonitorGetScale(ULMonitor monitor);
    public uint ulMonitorGetWidth(ULMonitor monitor);
    public uint ulMonitorGetHeight(ULMonitor monitor);
}

/// Function declarations for the Window API
extern(C) @system
{
    public ULWindow ulCreateWindow(ULMonitor monitor, uint width, uint height, bool fullscreen, uint window_flags);
    public void ulDestroyWindow(ULWindow window);
    public void ulWindowSetCloseCallback(ULWindow window, ULCloseCallback callback, void* user_data);
    public void ulWindowSetResizeCallback(ULWindow window, ULResizeCallback callback, void* user_data);
    public uint ulWindowGetScreenWidth(ULWindow window);
    public uint ulWindowGetWidth(ULWindow window);
    public uint ulWindowGetScreenHeight(ULWindow window);
    public uint ulWindowGetHeight(ULWindow window);
    public void ulWindowMoveTo(ULWindow window, int x, int y);
    public void ulWindowMoveToCenter(ULWindow window);
    public int ulWindowGetPositionX(ULWindow window);
    public int ulWindowGetPositionY(ULWindow window);
    public bool ulWindowIsFullscreen(ULWindow window);
    public double ulWindowGetScale(ULWindow window);
    public void ulWindowSetTitle(ULWindow window, const(char)* title);
    public void ulWindowSetCursor(ULWindow window, ULCursor cursor);
    public void ulWindowShow(ULWindow window);
    public void ulWindowHide(ULWindow window);
    public bool ulWindowIsVisible(ULWindow window);
    public void ulWindowClose(ULWindow window);
    public int ulWindowScreenToPixels(ULWindow window, int val);
    public int ulWindowPixelsToScreen(ULWindow window, int val);
    public void* ulWindowGetNativeHandle(ULWindow window);
}

/// Function declarations for the Overlay API
extern(C) @system
{
    public ULOverlay ulCreateOverlay(ULWindow window, uint width, uint height, int x, int y);
    public ULOverlay ulCreateOverlayWithView(ULWindow window, ULView view, int x, int y);
    public void ulDestroyOverlay(ULOverlay overlay);
    public ULView ulOverlayGetView(ULOverlay overlay);
    public uint ulOverlayGetWidth(ULOverlay overlay);
    public uint ulOverlayGetHeight(ULOverlay overlay);
    public int ulOverlayGetX(ULOverlay overlay);
    public int ulOverlayGetY(ULOverlay overlay);
    public void ulOverlayMoveTo(ULOverlay overlay, int x, int y);
    public void ulOverlayResize(ULOverlay overlay, uint width, uint height);
    public bool ulOverlayIsHidden(ULOverlay overlay);
    public void ulOverlayHide(ULOverlay overlay);
    public void ulOverlayShow(ULOverlay overlay);
    public bool ulOverlayHasFocus(ULOverlay overlay);
    public void ulOverlayFocus(ULOverlay overlay);
    public void ulOverlayUnfocus(ULOverlay overlay);
}

/// Function declarations for the Platform API
extern(C) @system
{
    public void ulEnablePlatformFontLoader();
    public void ulEnablePlatformFileSystem(ULString base_dir);
    public void ulEnableDefaultLogger(ULString log_path);
}