module ultralightd.wrapper.ul.view;

import ultralightd.bindings.ultralight;

import ultralightd.wrapper.ul.error;
import ultralightd.wrapper.ul.events;
import ultralightd.wrapper.ul.geometry;
import ultralightd.wrapper.ul.renderer;
import ultralightd.wrapper.ul.session;
import ultralightd.wrapper.ul.string;
import ultralightd.wrapper.ul.surface;
import ultralightd.wrapper.ul.viewconfig;

public alias Cursor = ULCursor;
public alias MessageLevel = ULMessageLevel;
public alias MessageSource = ULMessageSource;


public struct RenderTarget
{
    public bool isEmpty;
    public uint width;
    public uint height;
    public uint textureId;
    public uint textureWidth;
    public uint textureHeight;
    public BitmapFormat textureFormat;
    public Rect uvCoords;
    public uint renderBufferId;
}

public struct View
{
    package(ultralightd.wrapper) ULView handle;
}
