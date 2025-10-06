import std.stdio;
import core.thread;

import ultralightd.bindings;
import ultralightd.wrapper;

ULApp app;
ULOverlay overlay;
ULView view;

extern(C) void onClose(void* userData, ULWindow window)
{
	ulAppQuit(app);
}

extern(C) void onResize(void* userData, ULWindow window, uint width, uint height)
{
	ulOverlayResize(overlay, width, height);
}

void main()
{
    auto cstr2dstr(inout(char)* cstr)
    {
        import core.stdc.string : strlen;
        return cstr ? cstr[0 .. strlen(cstr)] : "";
    }

    ULString str = ulCreateString("Hello, World!");
    char* cstr = ulStringGetData(str);
    
    writeln(cstr2dstr(cstr));
    
    String s = String(str, true);
    
    writeln(s);
    //s.dispose();
    //writeln(s);

	ULString baseFSPath = ulCreateString("./");
	ulEnablePlatformFileSystem(baseFSPath);
	ulDestroyString(baseFSPath);

	ULSettings settings = ulCreateSettings();
	ulSettingsSetForceCPURenderer(settings, true);
	ULConfig config = ulCreateConfig();

	app = ulCreateApp(settings, config);

	ulDestroySettings(settings);
	ulDestroyConfig(config);

	ULWindow window = ulCreateWindow(ulAppGetMainMonitor(app), 512, 512, false, ULWindowFlags.kWindowFlags_Resizable);
	ulWindowSetTitle(window, "Example");

	overlay = ulCreateOverlay(window, ulWindowGetWidth(window), ulWindowGetHeight(window), 0, 0);
	view = ulOverlayGetView(overlay);

	//ulWindowSetResizeCallback(window, &onResize, null);
	//ulWindowSetCloseCallback(window, &onClose, null);
	
	//ulWindowSetResizeCallback(window, externify!ULResizeCallback((void* userData, ULWindow window, uint width, uint height) { ulOverlayResize(overlay, width, height); }), null);
	//ulWindowSetResizeCallback(window, resize((void* userData, ULWindow window, uint w, uint h) { ulOverlayResize(overlay, w, h); }), null);
	//ulWindowSetCloseCallback(window, externify!ULCloseCallback((void* userData, ULWindow window) { ulAppQuit(app); }), null);
    
    ulWindowSetResizeCallback(
        window,
        lambda!((void* userData, ULWindow window, uint width, uint height) {
            ulOverlayResize(overlay, width, height);
        }),
        null
    );
    
    ulWindowSetCloseCallback(
        window,
        lambda!((void* userData, ULWindow window) {
            ulAppQuit(app);
        }),
        null
    );
	
	ULString url = ulCreateString("https://ultralig.ht/");
	ulViewLoadURL(view, url);
	ulDestroyString(url);

	ulAppRun(app);

	ulDestroyOverlay(overlay);
	ulDestroyWindow(window);
	ulDestroyApp(app);
}


/*
ULApp app;
ULWindow window;
ULOverlay overlay;
ULView view;

void onUpdate(void* userData)
{

}

void onClose(void* userData, ULWindow window)
{
	ulAppQuit(app);
}

void onResize(void* userData, ULWindow window, uint width, uint height)
{
	ulOverlayResize(overlay, width, height);
}

void onDOMReady(void* userData, ULView caller, ulong frameId, bool isMainFrame, ULString url)
{

}

void init()
{
	ULString baseFSPath = ulCreateString("./");
	ulEnablePlatformFileSystem(baseFSPath);
	ulDestroyString(baseFSPath);

	ULSettings settings = ulCreateSettings();
	ulSettingsSetForceCPURenderer(settings, true);

	ULString baseDir = ulCreateString("./");
	ulSettingsSetFileSystemPath(settings, baseDir);
	ulDestroyString(baseDir);

	ULConfig config = ulCreateConfig();

	app = ulCreateApp(settings, config);

	ulAppSetUpdateCallback(app, &onUpdate, null);

	ulDestroySettings(settings);
	ulDestroyConfig(config);

	window = ulCreateWindow(ulAppGetMainMonitor(app), 500, 500, false, ULWindowFlags.kWindowFlags_Titled | ULWindowFlags.kWindowFlags_Resizable);

	ulWindowSetTitle(window, "Ultralightd Sample");

	ulWindowSetCloseCallback(window, &onClose, null);

	ulWindowSetResizeCallback(window, &onResize, null);

	overlay = ulCreateOverlay(window, ulWindowGetWidth(window), ulWindowGetHeight(window), 0, 0);
	view = ulOverlayGetView(overlay);

	ulViewSetDOMReadyCallback(view, &onDOMReady, null);

	ULString url = ulCreateString("file:///assets/app.html");
	ulViewLoadURL(view, url);
	ulDestroyString(url);
}

void quit()
{
	ulDestroyOverlay(overlay);
	ulDestroyWindow(window);
	ulDestroyApp(app);
}

void main()
{
	init();
	ulAppRun(app);
	quit();
}
*/