module ultralightd.wrapper.appcore.monitor;

import ultralightd.bindings.appcore;
import ultralightd.wrapper.util;

public struct Monitor
{
    package(ultralightd.wrapper) ULMonitor handle;

    @disable public this();

    private this(ULMonitor raw)
    {
        this.handle = raw;
    }

    public static Monitor fromRaw(ULMonitor raw)
    {
        return Monitor(raw);
    }

    public ULMonitor raw() => handle;

    public double scale() => ulMonitorGetScale(handle);

    public uint width() => ulMonitorGetWidth(handle);

    public uint height() => ulMonitorGetHeight(handle);
}
