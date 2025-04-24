module ultralightd.wrapper.ul.string;

import ultralightd.bindings.ultralight;

public struct String
{
    private ULString str;
    private bool owned;
    
    this(this) @trusted
    {
        if (this.str !is null)
        {
            ULString newHandle = ulCreateStringFromCopy(this.str);
            assert (newHandle !is null, "New ULString handle was null");
            
            this.str = newHandle;
            this.owned = true;
        }
        else
        {
            this.owned = true;
        }
    }
    
    ~this()
    {
        if (this.owned && this.str !is null)
        {
            ulDestroyString(this.str);
        }
    }
    
    public static String empty()
    {
        return fromString("");
    }
    
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
    
    public static String fromCopy(String str)
    {
        auto raw = ulCreateStringFromCopy(str.str);
        return String(raw, true);
    }
    
    public ULString raw() @property => this.str;
    
    public bool isOwned() @property => this.owned;
    
    public string toDString() @property
    {
        import core.stdc.string : strlen;
        import std.string : toStringz;
        
        if (this.str is null)
        {
            return "";
        }
        
        auto cstr = ulStringGetData(this.str);
        return cast(string) (cstr ? cstr[0 .. strlen(cstr)] : "");
    }
    
    public string asString() @property
    {
        if (this.str is null) return "";
        if (isEmpty()) return "";
        
        size_t len = length();
        const(char)* cstr = ulStringGetData(this.str);
        assert(cstr !is null, "ulStringGetData returned null");
        
        const(char)[] cSlice = cstr[0 .. len];
        return cSlice.idup;
    }
    
    public size_t length() @property
    {
        if (this.str is null)
        {
            return 0;
        }
        
        return ulStringGetLength(this.str);
    }
    
    public bool isEmpty() @property
    {
        if (this.str is null)
        {
            return true;
        }
        
        return length() == 0;
    }
    
    public void assign(String other)
    {
        if (this.str is null || other.str is null)
        {
            throw new Exception("Cannot assign null ULString");
        }
        
        ulStringAssignString(this.str, other.str);
    }
    
    public void assignString(string s)
    {
        import std.string : toStringz;
        
        if (this.str is null)
        {
            throw new Exception("Cannot assign null ULString");
        }
        
        auto cstr = s.toStringz();
        ulStringAssignCString(this.str, cstr);
    }
    
    public void toString(scope void delegate(const(char)[]) sink)
    {
        sink(asString());
    }
}