smodule ultralightd.wrapper.ul.surface;

import ultralightd.bindings.ultralight;

public interface ISurfaceDefinition
{
    void* create(uint width, uint height);
    void destory(void* userData);
    uint getWidth(void* userData);
    uint getHeight(void* userData);
    uint getRowBytes(void* userData);
    size_t getSize(void* userData);
    void* lockPixels(void* userData);
    void unlockPixels(void* userData);
    void resize(void* userData, uint width, uint height);

    public final ULSurfaceDefinition toRaw()
    {
        extern(C) void* createCallback(uint width, uint height)
        {
            return create(width, height);
        }

        extern(C) void destroyCallback(void* userData)
        {
            destory(userData);
        }

        return ULSurfaceDefinition(
            &createCallback,
            &destoryCallback,
            &getWidth,
            &getHeight,
            &getRowBytes,
            &getSize,
            &lockPixels,
            &unlockPixels,
            &resize
        );
    }
}
