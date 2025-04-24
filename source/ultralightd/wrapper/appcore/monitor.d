module ultralightd.wrapper.appcore.monitor;

import ultralightd.bindings.appcore;
import ultralightd.wrapper.util;

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

    public const(ULMonitor) raw() const @property => this.monitor;

    public double scale() const @property => ulMonitorGetScale(this.raw.asMut!ULMonitor);

    public uint width() const @property => ulMonitorGetWidth(this.raw.asMut!ULMonitor);

    public uint height() const @property => ulMonitorGetHeight(this.raw.asMut!ULMonitor);
}
