module ultralightd.bindings.jscore.base;
/*
alias JSContextGroupRef = const(OpaqueJSContextGroup*);
alias JSContextRef = const(OpaqueJSContext*);
alias JSGlobalContextRef = OpaqueJSContext*;
alias JSStringRef = OpaqueJSString*;
alias JSClassRef = OpaqueJSClass*;
alias JSPropertyNameArrayRef = OpaqueJSPropertyNameArray*;
alias JSPropertyNameAccumulatorRef = OpaqueJSPropertyNameAccumulator*;
alias JSValueRef = const(OpaqueJSValue*);
alias JSObjectRef = OpaqueJSValue*;

public extern(C) nothrow
{
    struct OpaqueJSContextGroup;
    struct OpaqueJSContext;
    struct OpaqueJSContext;
    struct OpaqueJSString;
    struct OpaqueJSClass;
    struct OpaqueJSPropertyNameArray;
    struct OpaqueJSPropertyNameAccumulator;
    struct OpaqueJSValue;
    struct OpaqueJSValue;

    /++
     + A function used to deallocate bytes passed to a Typed Array constructor.
     + The function should take two arguments.
     + The first is a pointer to the bytes that were originally passed to the Typed Array constructor.
     + The second is a pointer to additional information desired at the time the bytes are to be freed.
     +/
    alias JSTypedArrayBytesDeallocator = void function(void*, void*);

    /++
     + @function JSEvaluateScript
     + @abstract Evaluates a string of JavaScript.
     + @param ctx The execution context to use.
     + @param script A JSString containing the script to evaluate.
     + @param thisObject The object to use as "this," or NULL to use the global object as "this."
     + @param sourceURL A JSString containing a URL for the script's source file. This is used by debuggers and when reporting exceptions. Pass NULL if you do not care to include source file information.
     + @param startingLineNumber An integer value specifying the script's starting line number in the file located at sourceURL. This is only used when reporting exceptions. The value is one-based, so the first line is line 1 and invalid values are clamped to 1.
     + @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
     + @result The JSValue that results from evaluating script, or NULL if an exception is thrown.
     +/
    JSValueRef JSEvaluateScript(JSContextRef, JSStringRef, JSObjectRef, JSStringRef, int, JSValueRef*);

    /++
     + @function JSCheckScriptSyntax
     + @abstract Checks for syntax errors in a string of JavaScript.
     + @param ctx The execution context to use.
     + @param script A JSString containing the script to check for syntax errors.
     + @param sourceURL A JSString containing a URL for the script's source file. This is only used when reporting exceptions. Pass NULL if you do not care to include source file information in exceptions.
     + @param startingLineNumber An integer value specifying the script's starting line number in the file located at sourceURL. This is only used when reporting exceptions. The value is one-based, so the first line is line 1 and invalid values are clamped to 1.
     + @param exception A pointer to a JSValueRef in which to store a syntax error exception, if any. Pass NULL if you do not care to store a syntax error exception.
     + @result true if the script is syntactically correct, otherwise false.
     +/
    bool JSCheckScriptSyntax(JSContextRef, JSStringRef, JSStringRef, int, JSValueRef*);

    /++
     + @function JSGarbageCollect
     + @abstract Performs a JavaScript garbage collection.
     + @param ctx The execution context to use.
     + @discussion JavaScript values that are on the machine stack, in a register,
     +  protected by JSValueProtect, set as the global object of an execution context,
     +  or reachable from any such value will not be collected.
     +  During JavaScript execution, you are not required to call this function; the
     +  JavaScript engine will garbage collect as needed. JavaScript values created
     +  within a context group are automatically destroyed when the last reference
     +  to the context group is released.
     +/
    void JSGarbageCollect(JSContextRef);
}
*/