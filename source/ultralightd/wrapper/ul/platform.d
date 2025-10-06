module ultralightd.wrapper.ul.platform;

import ultralightd.bindings.ultralight;

import ultralightd.wrapper.ul.string;

/++
 + Collection of static methods for configuring the platform.
 +/
public struct Platform
{
    /// Set a custom logger implementation.
    public static void setLogger(ULLogger logger)
    {
        ulPlatformSetLogger(logger);
    }

    /// Set a custom file system implementation.
    public static void setFileSystem(ULFileSystem fileSystem)
    {
        ulPlatformSetFileSystem(fileSystem);
    }

    /// Set a custom font loader implementation.
    public static void setFontLoader(ULFontLoader fontLoader)
    {
        // TODO doesnt work
        /++
         + lld-link: error: undefined symbol: ulPlatformSetFontLoader
         + >>> referenced by ...\ultralightd\source\ultralightd\wrapper\ul\platform.d:27
         + >>>               ...\dub\cache\ultralightd\~main\build\ultralightd-windows-debug-Wr6m2LaY-CoNxrn7I6FSkg\ultralightd.obj:(_D11ultralightd7wrapper2ul8platform8Platform13setFontLoaderFSQCh8bindings10ultralight12ULFontLoaderZv)
         + Error: linker exited with status 1
         + Error Z:\opend\bin\dmd.exe failed with exit code 1.
         +/
        //ulPlatformSetFontLoader(fontLoader);
    }

    /// Set a custom surface definition.
    public static void setSurfaceDefinition(ULSurfaceDefinition surfaceDefinition)
    {
        ulPlatformSetSurfaceDefinition(surfaceDefinition);
    }

    /// Set a custom GPU driver implementation.
    public static void setGPUDriver(ULGPUDriver gpuDriver)
    {
        ulPlatformSetGPUDriver(gpuDriver);
    }

    /// Set a custom clipboard implementation.
    public static void setClipboard(ULClipboard clipboard)
    {
        ulPlatformSetClipboard(clipboard);
    }

    /// Enable the default logger (requires AppCore).
    public static void enableDefaultLogger(string logPath)
    {
        import ultralightd.bindings.appcore : ulEnableDefaultLogger;

        ulEnableDefaultLogger(String.fromString(logPath).raw);
    }

    /// Enable the platform file system (requires AppCore).
    public static void enablePlatformFileSystem(string baseDir)
    {
        //extern(C) void ulEnablePlatformFileSystem(ULString base_dir);

        import ultralightd.bindings.appcore : ulEnablePlatformFileSystem;

        ulEnablePlatformFileSystem(String.fromString(baseDir).raw);
    }

    /// Enable the platform font loader (requires AppCore).
    public static void enablePlatformFontLoader()
    {
        //extern(C) void ulEnablePlatformFontLoader();

        import ultralightd.bindings.appcore : ulEnablePlatformFontLoader;

        ulEnablePlatformFontLoader();
    }
}
