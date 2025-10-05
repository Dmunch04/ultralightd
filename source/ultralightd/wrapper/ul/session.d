module ultralightd.wrapper.ul.session;

import ultralightd.bindings.ultralight;

import ultralightd.wrapper.ul.string;

public struct Session
{
    package ULSession handle;
    private bool owned;
}