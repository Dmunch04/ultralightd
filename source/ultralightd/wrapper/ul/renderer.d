module ultralightd.wrapper.ul.renderer;

import ultralightd.bindings.ultralight;

import ultralightd.wrapper.ul.config;
import ultralightd.wrapper.ul.events;
import ultralightd.wrapper.ul.session;
import ultralightd.wrapper.ul.string;

import std.string : toStringz;

public struct Renderer
{
    package(ultralightd.wrapper) ULRenderer handle;
    private bool owned;

    @disable public this();

    public this(Config config)
    {
        this.handle = ulCreateRenderer(config.raw);
        this.owned = true;
    }

    private this(ULRenderer raw, bool owned)
    {
        this.handle = raw;
        this.owned = owned;
    }

    ~this()
    {
        if (handle !is null && owned)
        {
            ulDestroyRenderer(handle);
        }
    }

    public static Renderer fromRaw(ULRenderer raw, bool owned) => Renderer(raw, owned);

    public ULRenderer raw() => handle;

    public void update() => ulUpdate(handle);

    public void refreshDisplay(uint displayId) => ulRefreshDisplay(handle, displayId);

    public void render() => ulRender(handle);

    public void purgeMemory() => ulPurgeMemory(handle);

    public void logMemoryUsage() => ulLogMemoryUsage(handle);

    public bool startRemoteInspectorServer(string address, ushort port) => ulStartRemoteInspectorServer(handle, address.toStringz, port);

    public void setGamepadDetails(uint index, string id, uint axisCount, uint buttonCount) => ulSetGamepadDetails(handle, index, String.fromString(id).raw, axisCount, buttonCount);

    public void fireGamepadEvent(GamepadEvent event) => ulFireGamepadEvent(handle, event.raw);

    public void fireGamepadAxisEvent(GamepadAxisEvent event) => ulFireGamepadAxisEvent(handle, event.raw);

    public void fireGamepadButtonEvent(GamepadButtonEvent event) => ulFireGamepadButtonEvent(handle, event.raw);

    public Session createSession(bool isPersistent, string name) => Session(this, isPersistent, name);

    public Session defaultSession() => Session.getDefault(this);
}
