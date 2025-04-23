module ultralightd.wrapper.config;

import ultralightd.bindings.ultralight;

public struct UltralightConfig
{
    public static ULConfig internal;

    ~this()
    {
        ulDestroyConfig(internal);
    }

    public void setAnimationTimerDelay(double delay)
    {
        ulConfigSetAnimationTimerDelay(internal, delay);
    }
}