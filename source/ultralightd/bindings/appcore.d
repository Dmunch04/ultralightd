module ultralightd.bindings.appcore;

import ultralightd.bindings.ultralight : ULString, ULConfig, ULRenderer, ULCursor, ULView;

public alias ULSettings = C_Settings*;
public alias ULApp = C_App*;
public alias ULWindow = C_Window*;
public alias ULMonitor = C_Monitor*;
public alias ULOverlay = C_Overlay*;

/++
 + Low-level bindings for the Ultralight AppCore C API.
 + Source: https://github.com/ultralight-ux/Ultralight-API/blob/master/AppCore/CAPI.h
 + Version as of time written: 1.4.0 (beta)
 +/
public extern(C)
{
    struct C_Settings;
    struct C_App;
    struct C_Window;
    struct C_Monitor;
    struct C_Overlay;

    /++
     + Window creation flags. @see Window::Create
     +/
    enum ULWindowFlags
    {
        /// 
        kWindowFlags_Borderless  = 1 << 0,

        /// 
        kWindowFlags_Titled      = 1 << 1,

        /// 
        kWindowFlags_Resizable   = 1 << 2,

        /// 
        kWindowFlags_Maximizable = 1 << 3,

        /// 
        kWindowFlags_Hidden      = 1 << 4,
    }





    /++
     + Settings
     +/
    
    /++
     + Create settings with default values (see <AppCore/App.h>).
     +/
    ULSettings ulCreateSettings();

    /++
     + Destroy settings.
     +/
    void ulDestroySettings(ULSettings);

    /++
     + Set the name of the developer of this app.
     + This is used to generate a unique path to store local application data
     + on the user's machine.
     + Default is "MyCompany"
     +/
    void ulSettingsSetDeveloperName(ULSettings, ULString);

    /++
     + Set the name of this app.
     + This is used to generate a unique path to store local application data
     + on the user's machine.
     + Default is "MyApp"
     +/
    void ulSettingsSetAppName(ULSettings, ULString);

    /++
     + Set the root file path for our file system, you should set this to the
     + relative path where all of your app data is.
     + This will be used to resolve all file URLs, eg file:///page.html
     + @note  The default path is "./assets/"
     +        This relative path is resolved using the following logic:
     +         - Windows: relative to the executable path
     +         - Linux:   relative to the executable path
     +         - macOS:   relative to YourApp.app/Contents/Resources/
     +/
    void ulSettingsSetFileSystemPath(ULSettings, ULString);

    /++
     + Set whether or not we should load and compile shaders from the file system
     + (eg, from the /shaders/ path, relative to file_system_path).
     + If this is false (the default), we will instead load pre-compiled shaders
     + from memory which speeds up application startup time.
     +/
    void ulSettingsSetLoadShadersFromFileSystem(ULSettings, bool);

    /++
     + We try to use the GPU renderer when a compatible GPU is detected.
     + Set this to true to force the engine to always use the CPU renderer.
     +/
    void ulSettingsSetForceCPURenderer(ULSettings, bool);





    /++
     + App
     +/
    
    /++
     + Create the App singleton.
     + @param  settings  Settings to customize App runtime behavior. You can pass
     +                   NULL for this parameter to use default settings.
     + @param  config  Config options for the Ultralight renderer. You can pass
     +                 NULL for this parameter to use default config.
     + @note  You should only create one of these per application lifetime.
     + @note  Certain Config options may be overridden during App creation,
     +        most commonly Config::face_winding and Config::device_scale_hint.
     +/
    ULApp ulCreateApp(ULSettings, ULConfig);

    /++
     + Destroy the App instance.
     +/
    void ulDestroyApp(ULApp);

    /++
     + 
     +/
    alias ULUpdateCallback = void function(void*);

    /++
     + Set a callback for whenever the App updates. You should update all app
     + logic here.
     + @note  This event is fired right before the run loop calls
     +        Renderer::Update and Renderer::Render.
     +/
    void ulAppSetUpdateCallback(ULApp, ULUpdateCallback, void*);

    /++
     + Whether or not the App is running.
     +/
    bool ulAppIsRunning(ULApp);

    /++
     + Get the main monitor (this is never NULL).
     + @note  We'll add monitor enumeration later.
     +/
    ULMonitor ulAppGetMainMonitor(ULApp);

    /++
     + Get the underlying Renderer instance.
     +/
    ULRenderer ulAppGetRenderer(ULApp);

    /++
     + Run the main loop.
     +/
    void ulAppRun(ULApp);

    /++
     + Quit the application.
     +/
    void ulAppQuit(ULApp);





    /++
     + Monitor
     +/
    
    /++
     + Get the monitor's DPI scale (1.0 = 100%).
     +/
    double ulMonitorGetScale(ULMonitor);

    /++
     + Get the width of the monitor (in pixels).
     +/
    uint ulMonitorGetWidth(ULMonitor);

    /++
     + Get the height of the monitor (in pixels).
     +/
    uint ulMonitorGetHeight(ULMonitor);





    /++
     + Window
     +/
    
    /++
     + Create a new Window.
     + @param  monitor       The monitor to create the Window on.
     + @param  width         The width (in screen coordinates).
     + @param  height        The height (in screen coordinates).
     + @param  fullscreen    Whether or not the window is fullscreen.
     + @param  window_flags  Various window flags.
     +/
    ULWindow ulCreateWindow(ULMonitor, uint, uint, bool, uint);

    /++
     + Destroy a Window.
     +/
    void ulDestroyWindow(ULWindow);

    /++
     + 
     +/
    alias ULCloseCallback = void function(void*, ULWindow);

    /++
     + Set a callback to be notified when a window closes.
     +/
    void ulWindowSetCloseCallback(ULWindow, ULCloseCallback, void*);

    /++
     + 
     +/
    alias ULResizeCallback = void function(void*, ULWindow, uint, uint);

    /++
     + Set a callback to be notified when a window resizes
     + (parameters are passed back in pixels).
     +/
    void ulWindowSetResizeCallback(ULWindow, ULResizeCallback, void*);

    /++
     + Get window width (in screen coordinates).
     +/
    uint ulWindowGetScreenWidth(ULWindow);

    /++
     + Get window width (in pixels).
     +/
    uint ulWindowGetWidth(ULWindow);

    /++
     + Get window height (in screen coordinates).
     +/
    uint ulWindowGetScreenHeight(ULWindow);

    /++
     + Get window height (in pixels).
     +/
    uint ulWindowGetHeight(ULWindow);

    /++
     + Move the window to a new position (in screen coordinates) relative to the top-left of the
     + monitor area.
     +/
    void ulWindowMoveTo(ULWindow, int, int);

    /++
     + Move the window to the center of the monitor.
     +/
    void ulWindowMoveToCenter(ULWindow);

    /++
     + Get the x-position of the window (in screen coordinates) relative to the top-left of the
     + monitor area.
     +/
    int ulWindowGetPositionX(ULWindow);

    /++
     + Get the y-position of the window (in screen coordinates) relative to the top-left of the
     + monitor area.
     +/
    int ulWindowGetPositionY(ULWindow);

    /++
     + Get whether or not a window is fullscreen.
     +/
    bool ulWindowIsFullscreen(ULWindow);

    /++
     + Get the DPI scale of a window.
     +/
    double ulWindowGetScale(ULWindow);

    /++
     + Set the window title.
     +/
    void ulWindowSetTitle(ULWindow, const(char*));

    /++
     + Set the cursor for a window.
     +/
    void ulWindowSetCursor(ULWindow, ULCursor);

    /++
     + Show the window (if it was previously hidden).
     +/
    void ulWindowShow(ULWindow);

    /++
     + Hide the window.
     +/
    void ulWindowHide(ULWindow);

    /++
     + Whether or not the window is currently visible (not hidden).
     +/
    bool ulWindowIsVisible(ULWindow);

    /++
     + Close a window.
     +/
    void ulWindowClose(ULWindow);

    /++
     + Convert screen coordinates to pixels using the current DPI scale.
     +/
    int ulWindowScreenToPixels(ULWindow, int);

    /++
     + Convert pixels to screen coordinates using the current DPI scale.
     +/
    int ulWindowPixelsToScreen(ULWindow, int);

    /++
     + Get the underlying native window handle.
     + @note This is:  - HWND on Windows
     +                 - NSWindow* on macOS
     +                 - GLFWwindow* on Linux
     +/
    void* ulWindowGetNativeHandle(ULWindow);





    /++
     + Overlay
     +/
    
    /++
     + Create a new Overlay.
     + @param  window  The window to create the Overlay in.
     + @param  width   The width in pixels.
     + @param  height  The height in pixels.
     + @param  x       The x-position (offset from the left of the Window), in
     +                 pixels.
     + @param  y       The y-position (offset from the top of the Window), in
     +                 pixels.
     + @note  Each Overlay is essentially a View and an on-screen quad. You should
     +        create the Overlay then load content into the underlying View.
     +/
    ULOverlay ulCreateOverlay(ULWindow, uint, uint, int, int);

    /++
     + Create a new Overlay, wrapping an existing View.
     + @param  window  The window to create the Overlay in. (we currently only
     +                 support one window per application)
     + @param  view    The View to wrap (will use its width and height).
     + @param  x       The x-position (offset from the left of the Window), in
     +                 pixels.
     + @param  y       The y-position (offset from the top of the Window), in
     +                 pixels.
     + @note  Each Overlay is essentially a View and an on-screen quad. You should
     +        create the Overlay then load content into the underlying View.
     +/
    ULOverlay ulCreateOverlayWithView(ULWindow, ULView, int, int);

    /++
     + Destroy an overlay.
     +/
    void ulDestroyOverlay(ULOverlay);

    /++
     + Get the underlying View.
     +/
    ULView ulOverlayGetView(ULOverlay);

    /++
     + Get the width (in pixels).
     +/
    uint ulOverlayGetWidth(ULOverlay);

    /++
     + Get the height (in pixels).
     +/
    uint ulOverlayGetHeight(ULOverlay);

    /++
     + Get the x-position (offset from the left of the Window), in pixels.
     +/
    int ulOverlayGetX(ULOverlay);

    /++
     + Get the y-position (offset from the top of the Window), in pixels.
     +/
    int ulOverlayGetY(ULOverlay);

    /++
     + Move the overlay to a new position (in pixels).
     +/
    void ulOverlayMoveTo(ULOverlay, int, int);

    /++
     + Resize the overlay (and underlying View), dimensions should be
     + specified in pixels.
     +/
    void ulOverlayResize(ULOverlay, uint, uint);

    /++
     + Whether or not the overlay is hidden (not drawn).
     +/
    bool ulOverlayIsHidden(ULOverlay);

    /++
     + Hide the overlay (will no longer be drawn).
     +/
    void ulOverlayHide(ULOverlay);

    /++
     + Show the overlay.
     +/
    void ulOverlayShow(ULOverlay);

    /++
     + Whether or not an overlay has keyboard focus.
     +/
    bool ulOverlayHasFocus(ULOverlay);

    /++
     + Grant this overlay exclusive keyboard focus.
     +/
    void ulOverlayFocus(ULOverlay);

    /++
     + Remove keyboard focus.
     +/
    void ulOverlayUnfocus(ULOverlay);





    /++
     + Platform
     +/
    
    /++
     + This is only needed if you are not calling ulCreateApp().
     + Initializes the platform font loader and sets it as the current FontLoader.
     +/
    void ulEnablePlatformFontLoader();

    /++
     + This is only needed if you are not calling ulCreateApp().
     + Initializes the platform file system (needed for loading file:/// URLs) and
     + sets it as the current FileSystem.
     + You can specify a base directory path to resolve relative paths against.
     +/
    void ulEnablePlatformFileSystem(ULString);

    /++
     + This is only needed if you are not calling ulCreateApp().
     + Initializes the default logger (writes the log to a file).
     + You should specify a writable log path to write the log to
     + for example "./ultralight.log".
     +/
    void ulEnableDefaultLogger(ULString);
}