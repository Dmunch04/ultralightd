module ultralightd.bindings.util;

private template wrapCallback(alias lambda)
{
    import std.traits;
    
    static assert(isCallable!lambda, "The provided lambda must be callable.");
    
    alias CallbackType = ParameterTypeTuple!lambda;
    alias RT = ReturnType!lambda;
    
    extern(C) static RT wrappedCallback(CallbackType args)
    {
        return lambda(args);
    }
}

/++
 + 
 +/
public auto lambda(alias dlg)()
{
    alias Wrapper = wrapCallback!dlg;
    return &Wrapper.wrappedCallback;
}