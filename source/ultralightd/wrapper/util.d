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
        import std.traits;
    
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
        version(MEM_DBG) writeln("String::dtor() called. owned=", this.owned, ", handle=", cast(void*) this.handle);
        
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
 + Calls a C function that is logically const (does not mutate its argument)
 + but may lack a `const`-correct signature in its D binding, requiring a cast.
 +
 + This utility encapsulates the `cast` needed to pass a `const(T)` D value
 + to a C function expecting a mutable `U` (where `U` is typically the same
 + base type as `T`). It centralizes the necessary `@trusted` annotation and
 + documents the core assumption being made.
 +
 + **CRITICAL SAFETY WARNING:**
 + This function relies **entirely** on the **caller's guarantee** that the
 + provided C function (`cFn`) **will NOT mutate** the underlying data represented
 + by the `handle`, despite potentially accepting a non-`const` argument type (`U`).
 + **NO CHECK FOR MUTATION IS PERFORMED.** Misuse with a C function that *does*
 + mutate will lead to undefined behavior, potentially violating D's `const`
 + guarantees silently. Verify the C function's behavior via documentation,
 + source code inspection, or rigorous testing.
 +
 + Params:
 +   T = The D type of the handle/value (e.g., `ULString`). Inferred from `handle`.
 +   RT = The return type of the C function. Inferred from `cFn`.
 +   U = The parameter type expected by the C function. Inferred from `cFn`.
 +       The compiler will check if `cast(U)handle` is valid.
 +   handle = The `const` D value/handle to pass to the C function. The caller
 +            is responsible for ensuring this handle is valid (e.g., not null)
 +            if the C function requires it.
 +   cFn = A function pointer or delegate to the C function to be called
 +         (e.g., `&ulStringGetLength`).
 +
 + Returns:
 +   The value returned by the C function `cFn`.
 +
 + Trust Rationale (`@trusted`):
 +   This function is marked `@trusted` because it uses `cast(U)handle` to
 +   remove the `const` qualifier from the `handle`. This bypasses a D compiler
 +   safety check based on the programmer's assertion (documented above) that
 +   the target C function (`cFn`) is logically const and will not misuse the
 +   mutable-typed argument it receives.
 +
 + Example:
 + ---
 + // Assuming:
 + // extern(C) size_t ulStringGetLength(ULString str); // Binding lacks const
 + // ULString handle; // Is const(ULString) in this context
 +
 + // Instead of:
 + // size_t len = ulStringGetLength(cast(ULString)handle); // Manual cast, requires @trusted context
 +
 + // Use:
 + size_t len = callLogicallyConstC(handle, &ulStringGetLength); // Cleaner, trust localized
 + ---
 +/
// discard
public RT callLogicallyConstCFn(T, RT, U)(const(T) handle, RT function(U) nothrow cFn) @trusted
{
    if (is(T == U))
    {
        U mutableValue = mutable!U(handle); //cast(U) handle;
        return cFn(mutableValue);
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
 + CFunc(castAwayConst!ResourceType*(handle1), castAwayConst!ResourceType*(handle2));
 + ---
 +/
public U asMutable(U, T)(const(T) handle) @trusted
{
    return cast(U) handle;
}

/// ditto
alias asMut = asMutable;