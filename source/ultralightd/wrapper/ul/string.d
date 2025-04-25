module ultralightd.wrapper.ul.string;

import ultralightd.bindings.ultralight;
import ultralightd.wrapper.util;

/++
 + A wrapper for the ULString type.
 +/
public struct String
{
    package ULString handle;
    private bool owned;

    mixin Handled!(ULString, "ulCreateStringFromCopy", "ulDestroyString");

    /++
     + Creates a new empty String
     +/
    public static String empty()
    {
        return fromString("");
    }

    /++
     + Creates a new String from a D string
     +/
    public static String fromString(string s)
    {
        import std.string : toStringz;

        auto cstr = s.toStringz();
        auto raw = ulCreateString(cstr);
        if (raw is null)
        {
            throw new Exception("Failed to create ULString");
        }

        return String(raw, true);
    }

    /++
     + Creates a copy of another String
     +/
    public static String fromCopy(String str)
    {
        auto raw = ulCreateStringFromCopy(str.handle);
        return String(raw, true);
    }

    /// Get a reference to the raw ULString handle.
    public ULString raw() => this.handle;

    /// Determines if this String owns the ULString handle.
    public bool isOwned() => this.owned;

    /++
     + Get the underlying ULString's data as a D string.
     +/
    public string asString()
    {
        if (this.handle is null) return "";
        if (isEmpty()) return "";

        size_t len = length();
        const(char)* cstr = ulStringGetData(this.handle);
        assert(cstr !is null, "ulStringGetData returned null");

        const(char)[] cSlice = cstr[0 .. len];
        return cSlice.idup;
    }

    /++
     + Get the length of the string.
     +/
    public size_t length()
    {
        if (this.handle is null)
        {
            return 0;
        }

        return ulStringGetLength(this.handle);
    }

    /++
     + Determines if the string is empty.
     +/
    public bool isEmpty()
    {
        if (this.handle is null)
        {
            return true;
        }

        return ulStringIsEmpty(this.handle);
    }

    /++
     + Assigns the contents of another String to this String.
     +/
    public void assign(ref String other)
    {
        if (this.handle is null || other.handle is null)
        {
            throw new Exception("Cannot assign null ULString");
        }

        ulStringAssignString(this.handle, other.handle);
    }

    /++
     + Assigns the contents of a D string to this String.
     +/
    public void assignString(string s)
    {
        import std.string : toStringz;

        if (this.handle is null)
        {
            throw new Exception("Cannot assign null ULString");
        }

        auto cstr = s.toStringz();
        ulStringAssignCString(this.handle, cstr);
    }

    public void toString(scope void delegate(const(char)[]) sink) const
    {
        // cast `this` to non-const to call `asString`
        sink((cast() this).asString());
    }
}
