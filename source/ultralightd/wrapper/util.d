module ultralightd.wrapper.util;

public mixin template Handled(T, alias copyFn, alias diposeFn)
{
    private T copy() @trusted
    {
        auto raw = mixin(copyFn ~ "(this.handle)");
        if (raw is null)
        {
            throw new Exception("Failed to copy handle");
        }
        
        return cast(T) raw;
    }
    
    private void dispose() @trusted
    {
        mixin(diposeFn ~ "(this.handle);");
    }
    
    this(this) @trusted
    {
        if (this.handle !is null)
        {
            // original handle was not null, so we need to copy it
            auto newHandle = this.copy();
            assert(newHandle !is null, "New handle was null");
            
            this.handle = newHandle;
            this.owned = true;
        }
        else
        {
            // original handle was null, so this copy is as well
            this.owned = true;
        }
    }
    
    ~this()
    {
        import std.stdio : writeln;
    
        version(MEM_DBG) writeln("String::dtor() called. owned=", this.owned, ", handle=", cast(void*) this.handle);
        if (this.owned && this.handle !is null)
        {
            version(MEM_DBG) writeln("   destroying handle: ", cast(void*) this.handle);
            ulDestroyString(this.handle);
        }
        else
        {
            version(MEM_DBG) writeln("   not destroying handle: ", cast(void*) this.handle);
        }
    }
}