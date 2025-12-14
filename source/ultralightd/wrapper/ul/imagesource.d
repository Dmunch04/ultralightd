module ultralightd.wrapper.ul.imagesource;

import ultralightd.bindings.ultralight;

import ultralightd.wrapper.ul.bitmap;
import ultralightd.wrapper.ul.geometry;
import ultralightd.wrapper.ul.string;

public struct ImageSource
{
    package(ultralightd.wrapper) ULImageSource handle;
    
    @disable public this();
    
    private this(ULImageSource raw)
    {
        this.handle = raw;
    }
    
    ~this()
    {
        if (handle !is null)
        {
            ulDestroyImageSource(handle);
        }
    }
    
    public static ImageSource fromTexture(uint width, uint height, uint textureId, Rect textureUv, Bitmap bitmap) => ImageSource(ulCreateImageSourceFromTexture(width, height, textureId, textureUv.raw, bitmap.raw));
    
    public static fromBitmap(Bitmap bitmap) => ImageSource(ulCreateImageSourceFromBitmap(bitmap.raw));
    
    public ULImageSource raw() => handle;
    
    public void invalidate() => ulImageSourceInvalidate(handle);
    
    public static  void addToProvider(string id, ImageSource imageSource) => ulImageSourceProviderAddImageSource(String.fromString(id).raw, imageSource.raw);
    
    public static void removeFromProvider(string id) => ulImageSourceProviderRemoveImageSource(String.fromString(id).raw);
}