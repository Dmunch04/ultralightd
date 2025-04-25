module ultralightd.wrapper.util;

// TODO: should we use function pointers instead of their names?
public mixin template Handled(T, alias copyFn, alias diposeFn)
{
    /// Helper method to call the correct handle copy function.
    private T copy() @trusted
    {
        auto raw = mixin(copyFn ~ "(this.handle)");
        if (raw is null)
        {
            throw new Exception("Failed to copy handle");
        }
        
        return cast(T) raw;
    }
    
    /// Helper method to call the correct handle destructor.
    private void dispose() @trusted
    {
        mixin(diposeFn ~ "(this.handle);");
    }
    
    /// idk
    public T release()
    {
        auto raw = this.handle;
        this.handle = null;
        this.owned = false;
        
        return cast(T) raw;
    }
    
    /// Postblit for safely copying
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
    
    /// Destructor for safely disposing of the handle
    ~this()
    {
        version(MEM_DBG) import std.stdio : writeln;
        version(MEM_DBG) writeln(typeof(this).stringof ~ "::dtor() called. owned=", this.owned, ", handle=", cast(void*) this.handle);
        
        if (this.owned && this.handle !is null)
        {
            version(MEM_DBG) writeln("   destroying handle: ", cast(void*) this.handle);
            this.dispose();
        }
        else
        {
            version(MEM_DBG) writeln("   not destroying handle: ", cast(void*) this.handle);
        }
    }
}

/++
 + Performs a `@trusted` cast to remove `const` from a value, assuming the
 + caller guarantees the subsequent usage will not improperly mutate the
 + underlying data (e.g., calling a C function that is logically const but
 + lacks a const-correct signature).
 +
 + **CRITICAL SAFETY WARNING:**
 + This function bypasses D's `const` protection based **entirely** on the
 + **caller's guarantee** about the safety of the subsequent operation.
 + Misuse can lead to undefined behavior by violating `const` expectations.
 + Use only when interacting with APIs (like C functions) where you have
 + verified (via documentation, testing, or source inspection) that mutation
 + will not occur despite a non-`const` signature.
 +
 + Params:
 +   U = The target non-`const` type (e.g., `ULString`). Must be explicitly specified.
 +   T = The source type (e.g., `const(ULString)`). Inferred from `value`.
 +   value = The `const` value to cast.
 +
 + Returns:
 +   The value cast to the mutable type `U`.
 +
 + Trust Rationale (`@trusted`):
 +   Marked `@trusted` because `cast(U)value` removes `const`, bypassing a D
 +   compiler safety check based on the caller's assertion of logical constness
 +   in the subsequent usage.
 +
 + Example:
 + ---
 + // Assuming:
 + // extern(C) void CFunc(ResourceType* r1, ResourceType* r2); // r2 not mutated
 + // const(ResourceType*) handle1, handle2;
 +
 + // Instead of:
 + // CFunc(cast(ResourceType*)handle1, cast(ResourceType*)handle2); // Requires @trusted context
 +
 + // Use:
 + CFunc(asMutable!ResourceType*(handle1), asMutable!ResourceType*(handle2));
 + ---
 +/
public U asMutable(U, T)(const(T) handle) @trusted
{
    return cast(U) handle;
}

/// ditto
alias asMut = asMutable;