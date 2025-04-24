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
    public const(ULString) raw() const @property => this.handle;

    /// Determines if this String owns the ULString handle.
    public bool isOwned() const @property => this.owned;

    /// Get the underlying ULString's data as a D string.
    public string asString() const @property
    {
        if (this.handle is null) return "";
        if (isEmpty()) return "";

        size_t len = length();
        // UNSAFE-CAST: cast(ULString) is required to avoid a compiler error
        // ulStringGetData(cast(ULString) this.handle);
        const(char)* cstr = ulStringGetData(this.handle.asMut!ULString);
        assert(cstr !is null, "ulStringGetData returned null");

        const(char)[] cSlice = cstr[0 .. len];
        return cSlice.idup;
    }

    /// Get the length of the string.
    public size_t length() const @property
    {
        if (this.handle is null)
        {
            return 0;
        }

        // UNSAFE-CAST: cast(ULString) is required to avoid a compiler error
        //return ulStringGetLength(cast(ULString) this.handle);
        return ulStringGetLength(this.handle.asMut!ULString);
    }

    /// Determines if the string is empty.
    public bool isEmpty() const @property
    {
        if (this.handle is null)
        {
            return true;
        }

        // UNSAFE-CAST: cast(ULString) is required to avoid a compiler error
        //return ulStringIsEmpty(cast(ULString) this.handle);
        return ulStringIsEmpty(this.handle.asMut!ULString);
    }

    /++
     + Assigns the contents of another String to this String.
     +/
    public void assign(const ref String other)
    {
        if (this.handle is null || other.handle is null)
        {
            throw new Exception("Cannot assign null ULString");
        }

        // UNSAFE-CAST: cast(ULString) is required to avoid a compiler error
        //ulStringAssignString(this.handle, cast(ULString) other.handle);
        ulStringAssignString(this.handle, other.handle.asMut!ULString);
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
        sink(asString());
    }
}
