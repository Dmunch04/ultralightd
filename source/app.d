import std.stdio;
import std.conv : to;
import core.thread;

import ultralightd.bindings.ultralight;
import ultralightd.bindings.appcore;

bool done = false;

void onFinishLoading(void* userData, ULView caller, ulong frameId, bool isMainFrame, ULString url)
{
	if (isMainFrame)
	{
		writeln("Our page has loaded!");
		done = true;
	}
}

void main()
{
	writeln(ulVersionString().to!string);
	writeln(ulVersionMajor().to!string ~ "." ~ ulVersionMinor().to!string ~ "." ~ ulVersionPatch().to!string);

	ULConfig config = ulCreateConfig();
	ulEnablePlatformFontLoader();

	//ULString resourcesPath = ulCreateString("./build/resources/");
	//ulConfigSetResourcePathPrefix(config, resourcesPath);
	//ulDestroyString(resourcesPath);

	ULString baseDir = ulCreateString("./");
	ulEnablePlatformFileSystem(baseDir);
	ulDestroyString(baseDir);

	ULString logPath = ulCreateString("./ultralight.log");
	ulEnableDefaultLogger(logPath);
	ulDestroyString(logPath);

	ULRenderer renderer = ulCreateRenderer(config);
	ulDestroyConfig(config);

	ULViewConfig viewConfig = ulCreateViewConfig();
	ulViewConfigSetInitialDeviceScale(viewConfig, 2.0);
	ulViewConfigSetIsAccelerated(viewConfig, false);

	ULView view = ulCreateView(renderer, 1600, 800, viewConfig, null);
	ulDestroyViewConfig(viewConfig);

	ulViewSetFinishLoadingCallback(view, &onFinishLoading, null);

	ULString urlString = ulCreateString("file:///assets/page.html");
	//ULString urlString = ulCreateString("https://google.com");
	ulViewLoadURL(view, urlString);
	ulDestroyString(urlString);

	writeln("Starting Run(), waiting for page to load...");

	do {
		ulUpdate(renderer);
		Thread.sleep(dur!("msecs")(10));
	} while (!done);

	ulRender(renderer);

	ULSurface surface = ulViewGetSurface(view);

	ULBitmap bitmap = ulBitmapSurfaceGetBitmap(surface);

	ulBitmapWritePNG(bitmap, "result.png");
	writeln("Saved a render of our page to result.png.");
}
