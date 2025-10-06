module ultralightd.wrapper.ul.events;

import ultralightd.bindings.ultralight;

import ultralightd.wrapper.ul.string;

public alias KeyEventType = ULKeyEventType;
public alias MouseEventType = ULMouseEventType;
public alias MouseButton = ULMouseButton;
public alias ScrollEventType = ULScrollEventType;
public alias GamepadEventType = ULGamepadEventType;

public struct KeyEvent
{
    package(ultralightd.wrapper) ULKeyEvent handle;

    @disable public this();

    public this(KeyEventType eventType, uint modifiers, int virtualKeyCode, int nativeKeyCode, string text, string unmodifiedText, bool isKeypad, bool isAutoRepeat, bool isSystemKey)
    {
        this.handle = ulCreateKeyEvent(eventType, modifiers, virtualKeyCode, nativeKeyCode, String.fromString(text).raw, String.fromString(unmodifiedText).raw, isKeypad, isAutoRepeat, isSystemKey);
    }

    ~this()
    {
        if (handle !is null)
        {
            ulDestroyKeyEvent(handle);
        }
    }

    public ULKeyEvent raw() => handle;
}

public struct MouseEvent
{
    package(ultralightd.wrapper) ULMouseEvent handle;

    @disable public this();

    public this(MouseEventType eventType, int x, int y, MouseButton button)
    {
        this.handle = ulCreateMouseEvent(eventType, x, y, button);
    }

    ~this()
    {
        if (handle !is null)
        {
            ulDestroyMouseEvent(handle);
        }
    }

    public ULMouseEvent raw() => handle;
}

public struct ScrollEvent
{
    package(ultralightd.wrapper) ULScrollEvent handle;

    @disable public this();

    public this(ScrollEventType eventType, int deltaX, int deltaY)
    {
        this.handle = ulCreateScrollEvent(eventType, deltaX, deltaY);
    }

    ~this()
    {
        if (handle !is null)
        {
            ulDestroyScrollEvent(handle);
        }
    }

    public ULScrollEvent raw() => handle;
}

public struct GamepadEvent
{
    package(ultralightd.wrapper) ULGamepadEvent handle;

    @disable public this();

    public this(uint index, GamepadEventType eventType)
    {
        this.handle = ulCreateGamepadEvent(index, eventType);
    }

    ~this()
    {
        if (handle !is null)
        {
            ulDestroyGamepadEvent(handle);
        }
    }

    public ULGamepadEvent raw() => handle;
}

public struct GamepadAxisEvent
{
    package(ultralightd.wrapper) ULGamepadAxisEvent handle;

    @disable public this();

    public this(uint index, uint axisIndex, double value)
    {
        this.handle = ulCreateGamepadAxisEvent(index, axisIndex, value);
    }

    ~this()
    {
        if (handle !is null)
        {
            ulDestroyGamepadAxisEvent(handle);
        }
    }

    public ULGamepadAxisEvent raw() => handle;
}

public struct GamepadButtonEvent
{
    package(ultralightd.wrapper) ULGamepadButtonEvent handle;

    @disable public this();

    public this(uint index, uint buttonIndex, double value)
    {
        this.handle = ulCreateGamepadButtonEvent(index, buttonIndex, value);
    }

    ~this()
    {
        if (handle !is null)
        {
            ulDestroyGamepadButtonEvent(handle);
        }
    }

    public ULGamepadButtonEvent raw() => handle;
}
