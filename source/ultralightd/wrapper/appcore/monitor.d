module ultralightd.wrapper.appcore.monitor;

import ultralightd.bindings.appcore;

public struct Monitor
{
    private ULMonitor monitor;

    @disable public this();

    private this(ULMonitor raw)
    {
        this.monitor = raw;
    }

    public static Monitor fromRaw(ULMonitor raw)
    {
        return Monitor(raw);
    }

    public ULMonitor raw() @property => this.monitor;

    public double scale() @property => ulMonitorGetScale(this.raw);

    public uint width() @property => ulMonitorGetWidth(this.raw);

    public uint height() @property => ulMonitorGetHeight(this.raw);
}
