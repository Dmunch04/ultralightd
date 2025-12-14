module ultralightd.wrapper.ul.error;

public class NullReferenceError : Exception
{
    this(string msg)
    {
        super("Null reference: " ~ msg);
    }
}

public class InvalidOperationError : Exception
{
    this(string msg)
    {
        super("Invalid operation: " ~ msg);
    }
}

public class JavaScriptError : Exception
{
    this(string msg)
    {
        super("JavaScript error: " ~ msg);
    }
}

public class InvalidUtf8Error : Exception
{
    this(string msg)
    {
        super("Invalid UTF-8: " ~ msg);
    }
}

public class IoError : Exception
{
    this(string msg)
    {
        super("I/O error: " ~ msg);
    }
}

public class InvalidArgumentError : Exception
{
    this(string msg)
    {
        super("Invalid argument: " ~ msg);
    }
}

public class ResourceDestroyedError : Exception
{
    this(string msg)
    {
        super("Resource destroyed: " ~ msg);
    }
}

public class UltralightError : Exception
{
    this(string msg)
    {
        super("Ultralight error: " ~ msg);
    }
}
