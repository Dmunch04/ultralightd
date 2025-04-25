module ultralightd.bindings.jscore;

/// Opaque types
public struct OpaqueJSContextGroup;
public struct OpaqueJSContext;
public struct OpaqueJSString;
public struct OpaqueJSClass;
public struct OpaqueJSPropertyNameArray;
public struct OpaqueJSPropertyNameAccumulator;
public struct OpaqueJSValue;

/// Type aliases
public alias JSContextGroupRef = const(OpaqueJSContextGroup)*;
public alias JSContextRef = const(OpaqueJSContext)*;
public alias JSGlobalContextRef = OpaqueJSContext*;
public alias JSStringRef = OpaqueJSString*;
public alias JSClassRef = OpaqueJSClass*;
public alias JSPropertyNameArrayRef = OpaqueJSPropertyNameArray*;
public alias JSPropertyNameAccumulatorRef = OpaqueJSPropertyNameAccumulator*;
public alias JSValueRef = const(OpaqueJSValue)*;
public alias JSObjectRef = OpaqueJSValue*;
public alias JSChar = ushort;
public alias JSPropertyAttributes = uint;
public alias JSClassAttributes = uint;

/// Callback types
public alias JSTypedArrayBytesDeallocator = extern(C) void function(void* bytes, void* deallocatorContext);
public alias JSObjectInitializeCallback = extern(C) void function(JSContextRef ctx, JSObjectRef object);
public alias JSObjectFinalizeCallback = extern(C) void function(JSObjectRef object);
public alias JSObjectHasPropertyCallback = extern(C) bool function(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName);
public alias JSObjectGetPropertyCallback = extern(C) JSValueRef function(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);
public alias JSObjectSetPropertyCallback = extern(C) bool function(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value, JSValueRef* exception);
public alias JSObjectDeletePropertyCallback = extern(C) bool function(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);
public alias JSObjectGetPropertyNamesCallback = extern(C) void function(JSContextRef ctx, JSObjectRef object, JSPropertyNameAccumulatorRef propertyNames);
public alias JSObjectCallAsFunctionCallback = extern(C) JSValueRef function(JSContextRef ctx, JSObjectRef func, JSObjectRef thisObject, size_t argumentCount, const(JSValueRef)* arguments, JSValueRef* exception);
public alias JSObjectCallAsConstructorCallback = extern(C) JSValueRef function(JSContextRef ctx, JSObjectRef constructor, size_t argumentCount, const(JSValueRef)* arguments, JSValueRef* exception);
public alias JSObjectHasInstanceCallback = extern(C) bool function(JSContextRef ctx, JSObjectRef constructor, JSValueRef possibleInstance, JSValueRef* exception);
public alias JSObjectConvertToTypeCallback = extern(C) JSValueRef function(JSContextRef ctx, JSObjectRef object, JSType type, JSValueRef* exception);

/// Enum definitions
extern(C) public enum JSType
{
    kJSTypeUndefined,
    kJSTypeNull,
    kJSTypeBoolean,
    kJSTypeNumber,
    kJSTypeString,
    kJSTypeObject,
    kJSTypeSymbol,
}

extern(C) public enum JSTypedArrayType
{
    kJSTypedArrayTypeInt8Array,
    kJSTypedArrayTypeInt16Array,
    kJSTypedArrayTypeInt32Array,
    kJSTypedArrayTypeUint8Array,
    kJSTypedArrayTypeUint8ClampedArray,
    kJSTypedArrayTypeUint16Array,
    kJSTypedArrayTypeUint32Array,
    kJSTypedArrayTypeFloat32Array,
    kJSTypedArrayTypeFloat64Array,
    kJSTypedArrayTypeArrayBuffer,
    kJSTypedArrayTypeNone,
    kJSTypedArrayTypeBigInt64Array,
    kJSTypedArrayTypeBigUint64Array,
}

enum kJSPropertyAttributeNone = 0;
enum kJSPropertyAttributeReadOnly = 1 << 1;
enum kJSPropertyAttributeDontEnum = 1 << 2;
enum kJSPropertyAttributeDontDelete = 1 << 3;

enum kJSClassAttributeNone = 0;
enum kJSClassAttributeNoAutomaticPrototype = 1 << 1;

/// Struct definitions
extern(C) public struct JSStaticValue
{
    public const(char)* name;
    public JSObjectGetPropertyCallback getProperty;
    public JSObjectSetPropertyCallback setProperty;
    public JSPropertyAttributes attributes;
}

extern(C) public struct JSStaticFunction
{
    public const(char)* name;
    public JSObjectCallAsFunctionCallback callAsFunction;
    public JSPropertyAttributes attributes;
}

extern(C) public struct JSClassDefinition
{
    public int _version;
    public JSClassAttributes attributes;
    public const(char)* className;
    public JSClassRef parentClass;
    public const(JSStaticValue)* staticValues;
    public const(JSStaticFunction)* staticFunctions;
    public JSObjectInitializeCallback initialize;
    public JSObjectFinalizeCallback finalize;
    public JSObjectHasPropertyCallback hasProperty;
    public JSObjectGetPropertyCallback getProperty;
    public JSObjectSetPropertyCallback setProperty;
    public JSObjectDeletePropertyCallback deleteProperty;
    public JSObjectGetPropertyNamesCallback getPropertyNames;
    public JSObjectCallAsFunctionCallback callAsFunction;
    public JSObjectCallAsConstructorCallback callAsConstructor;
    public JSObjectHasInstanceCallback hasInstance;
    public JSObjectConvertToTypeCallback convertToType;
}

extern(C) public struct JSClassDefinitionEmpty
{
    public int _version;
    public uint attributes;
    public const(char)* className;
    public void* parentClass;
    public const(void)* staticValues;
    public const(void)* staticFunctions;
    public const(void)* initialize;
    public const(void)* finalize;
    public const(void)* hasProperty;
    public const(void)* getProperty;
    public const(void)* setProperty;
    public const(void)* deleteProperty;
    public const(void)* getPropertyNames;
    public const(void)* callAsFunction;
    public const(void)* callAsConstructor;
    public const(void)* hasInstance;
    public const(void)* convertToType;
}

/++
 + A JSClassDefinition structure of the current version, filled with NULL pointers and having no attributes.
 +
 + Use this constant as a convenience when creating class definitions. For example, to create a class definition with only a finalize method:
 +
 + JSClassDefinition definition = kJSClassDefinitionEmpty;
 + definition.finalize = Finalize;
 +/
extern(C) __gshared JSClassDefinitionEmpty kJSClassDefinitionEmpty;

// TODO: add doc comments to function decls

/// Function declarations for the Context API
extern(C) @system
{
    public JSContextGroupRef  JSContextGroupCreate();
    public JSContextGroupRef  JSContextGroupRetain(JSContextGroupRef group);
    public void               JSContextGroupRelease(JSContextGroupRef group);
    
    public JSGlobalContextRef JSGlobalContextCreate(JSClassRef globalObjectClass);
    public JSGlobalContextRef JSGlobalContextCreateInGroup(JSContextGroupRef group, JSClassRef globalObjectClass);
    public JSGlobalContextRef JSGlobalContextRetain(JSGlobalContextRef ctx);
    public void               JSGlobalContextRelease(JSGlobalContextRef ctx);
    public JSObjectRef        JSGlobalContextGetGlobalObject(JSGlobalContextRef ctx);
    public JSContextGroupRef  JSContextGetGroup(JSContextRef ctx);
    public JSGlobalContextRef JSContextGetGlobalContext(JSContextRef ctx);
    public JSStringRef        JSGlobalContextCopyName(JSGlobalContextRef ctx);
    public void               JSGlobalContextSetName(JSGlobalContextRef ctx, JSStringRef name);
    public bool               JSGlobalContextIsInspectable(JSGlobalContextRef ctx);
    public void               JSGlobalContextSetInspectable(JSGlobalContextRef ctx, bool inspectable);
}

/// Function declarations for the String API
extern(C) @system
{
    public JSStringRef    JSStringCreateWithCharacters(const(JSChar)* chars, size_t numChars);
    public JSStringRef    JSStringCreateWithUTF8CString(const(char)* string);
    public JSStringRef    JSStringRetain(JSStringRef string);
    public void           JSStringRelease(JSStringRef string);
    public size_t         JSStringGetLength(JSStringRef string);
    public const(JSChar)* JSStringGetCharactersPtr(JSStringRef string);
    public size_t         JSStringGetMaximumUTF8CStringSize(JSStringRef string);
    public size_t         JSStringGetUTF8CString(JSStringRef string, char* buffer, size_t bufferSize);
    public bool           JSStringIsEqual(JSStringRef a, JSStringRef b);
    public bool           JSStringIsEqualToUTF8CString(JSStringRef a, const(char)* b);
}

/// Function declarations for the Object API
extern(C) @system
{
    public JSClassRef             JSClassCreate(const(JSClassDefinition)* definition);
    public JSClassRef             JSClassRetain(JSClassRef jsClass);
    public void                   JSClassRelease(JSClassRef jsClass);
    public JSObjectRef            JSObjectMake(JSContextRef ctx, JSClassRef jsClass, void* data);
    public JSObjectRef            JSObjectMakeFunctionWithCallback(JSContextRef ctx, JSStringRef name, JSObjectCallAsFunctionCallback callback);
    public JSObjectRef            JSMakeConstructor(JSContextRef ctx, JSClassRef jsClass, JSObjectCallAsConstructorCallback callAsConstructor);
    public JSObjectRef            JSObjectMakeArray(JSContextRef ctx, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public JSObjectRef            JSObjectMakeDate(JSContextRef ctx, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public JSObjectRef            JSObjectMakeError(JSContextRef ctx, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public JSObjectRef            JSObjectMakeRegExp(JSContextRef ctx, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public JSObjectRef            JSObjectMakeDeferredPromise(JSContextRef ctx, JSObjectRef* resolve, JSObjectRef* reject, JSValueRef* exception);
    public JSObjectRef            JSObjectMakeFunction(JSContextRef ctx, JSStringRef name, uint paramaterCount, const(JSStringRef)[] parameterNames, JSStringRef body, JSStringRef sourceURL, int startingLineNumber, JSValueRef* exception);
    public JSObjectRef            JSObjectGetPrototype(JSContextRef ctx, JSObjectRef object);
    public void                   JSObjectSetPrototype(JSContextRef ctx, JSObjectRef object, JSObjectRef value);
    public bool                   JSObjectHasProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName);
    public JSValueRef             JSObjectGetProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);
    public void                   JSObjectSetProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value, JSPropertyAttributes attributes, JSValueRef* exception);
    public bool                   JSObjectDeleteProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);
    public bool                   JSObjectHasPropertyForKey(JSContextRef ctx, JSObjectRef object, JSValueRef propertyKey, JSValueRef* exception);
    public JSValueRef             JSObjectGetPropertyForKey(JSContextRef ctx, JSObjectRef object, JSValueRef propertyKey, JSValueRef* exception);
    public void                   JSObjectSetPropertyForKey(JSContextRef ctx, JSObjectRef object, JSValueRef propertyKey, JSValueRef value, JSPropertyAttributes attributes, JSValueRef* exception);
    public bool                   JSObjectDeletePropertyForKey(JSContextRef ctx, JSObjectRef object, JSValueRef propertyKey, JSValueRef* exception);
    public JSValueRef             JSObjectGetPropertyAtIndex(JSContextRef ctx, JSObjectRef object, uint propertyIndex, JSValueRef* exception);
    public void                   JSObjectSetPropertyAtIndex(JSContextRef ctx, JSObjectRef object, uint propertyIndex, JSValueRef value, JSValueRef* exception);
    public bool                   JSObjectSetPrivate(JSObjectRef object, void* data);
    public bool                   JSObjectIsFunction(JSContextRef ctx, JSObjectRef object);
    public JSValueRef             JSObjectCallAsFunction(JSContextRef ctx, JSObjectRef object, JSObjectRef thisObject, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public bool                   JSObjectIsConstructor(JSContextRef ctx, JSObjectRef object);
    public JSValueRef             JSObjectCallAsConstructor(JSContextRef ctx, JSObjectRef object, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public JSPropertyNameArrayRef JSObjectCopyPropertyNames(JSContextRef ctx, JSObjectRef object);
    public JSPropertyNameArrayRef JSPropertyNameArrayRetain(JSPropertyNameArrayRef array);
    public void                   JSPropertyNameArrayRelease(JSPropertyNameArrayRef array);
    public size_t                 JSPropertyNameArrayGetCount(JSPropertyNameArrayRef array);
    public JSStringRef            JSPropertyNameArrayGetNameAtIndex(JSPropertyNameArrayRef array, size_t index);
    public void                   JSPropertyNameAccumulatorAddName(JSPropertyNameAccumulatorRef accumulator, JSStringRef propertyName);
    
    /// ObjectRef Private API
    public bool                   JSObjectSetPrivateProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value);
    public JSValueRef             JSObjectGetPrivateProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName);
    public bool                   JSObjectDeletePrivateProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName);
    public JSObjectRef            JSObjectGetProxyTarget(JSObjectRef object);
    public JSGlobalContextRef     JSObjectGetGlobalContext(JSObjectRef object);
}

/// Function declarations for the Value API
extern(C) @system
{
    public JSType           JSValueGetType(JSContextRef ctx, JSValueRef value);
    public bool             JSValueIsUndefined(JSContextRef ctx, JSValueRef value);
    public bool             JSValueIsNull(JSContextRef ctx, JSValueRef value);
    public bool             JSValueIsBoolean(JSContextRef ctx, JSValueRef value);
    public bool             JSValueIsNumber(JSContextRef ctx, JSValueRef value);
    public bool             JSValueIsString(JSContextRef ctx, JSValueRef value);
    public bool             JSValueIsSymbol(JSContextRef ctx, JSValueRef value);
    public bool             JSValueIsObject(JSContextRef ctx, JSValueRef value);
    public bool             JSValueIsObjectOfClass(JSContextRef ctx, JSValueRef value, JSClassRef jsClass);
    public bool             JSValueIsArray(JSContextRef ctx, JSValueRef value);
    public bool             JSValueIsDate(JSContextRef ctx, JSValueRef value);
    public JSTypedArrayType JSValueGetTypedArrayType(JSContextRef ctx, JSValueRef value, JSValueRef* exception);
    public bool             JSValueIsEqual(JSContextRef ctx, JSValueRef a, JSValueRef b, JSValueRef* exception);
    public bool             JSValueIsStrictEqual(JSContextRef ctx, JSValueRef a, JSValueRef b);
    public bool             JSValueIsInstanceOfConstructor(JSContextRef ctx, JSValueRef value, JSObjectRef constructor, JSValueRef* exception);
    public JSValueRef       JSValueMakeUndefined(JSContextRef ctx);
    public JSValueRef       JSValueMakeNull(JSContextRef ctx);
    public JSValueRef       JSValueMakeBoolean(JSContextRef ctx, bool boolean);
    public JSValueRef       JSValueMakeNumber(JSContextRef ctx, double number);
    public JSValueRef       JSValueMakeString(JSContextRef ctx, JSStringRef string);
    public JSValueRef       JSValueMakeSymbol(JSContextRef ctx, JSStringRef description);
    public JSValueRef       JSValueMakeFromJSONString(JSContextRef ctx, JSStringRef string);
    public JSStringRef      JSValueCreateJSONString(JSContextRef ctx, JSValueRef value, uint indent, JSValueRef* exception);
    public bool             JSValueToBoolean(JSContextRef ctx, JSValueRef value);
    public double           JSValueToNumber(JSContextRef ctx, JSValueRef value, JSValueRef* exception);
    public JSStringRef      JSValueToStringCopy(JSContextRef ctx, JSValueRef value, JSValueRef* exception);
    public JSValueRef       JSValueToObject(JSContextRef ctx, JSValueRef value, JSValueRef* exception);
    public void             JSValueProtect(JSContextRef ctx, JSValueRef value);
    public void             JSValueUnprotect(JSContextRef ctx, JSValueRef value);
}

/// Function declarations for the Typed Array API
extern(C) @system
{
    public JSObjectRef JSObjectMakeTypedArray(JSContextRef ctx, JSTypedArrayType arrayType, size_t length, JSValueRef* exception);
    public JSObjectRef JSObjectMakeTypedArrayWithBytesNoCopy(JSContextRef ctx, JSTypedArrayType arrayType, void* bytes, size_t byteLength, JSTypedArrayBytesDeallocator bytesDeallocator, void* deallocatorContext, JSValueRef* exception);
    public JSObjectRef JSObjectMakeTypedArrayWithArrayBuffer(JSContextRef ctx, JSTypedArrayType arrayType, JSObjectRef buffer, JSValueRef* exception);
    public JSObjectRef JSObjectMakeTypedArrayWithArrayBufferAndOffset(JSContextRef ctx, JSTypedArrayType arrayType, JSObjectRef buffer, size_t byteOffset, size_t length, JSValueRef* exception);
    public void*       JSObjectGetTypedArrayBytesPtr(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    public size_t      JSObjectGetTypedArrayLength(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    public size_t      JSObjectGetTypedArrayByteLength(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    public size_t      JSObjectGetTypedArrayByteOffset(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    public JSObjectRef JSObjectGetTypedArrayBuffer(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    
    public JSObjectRef JSObjectMakeArrayBufferWithBytesNoCopy(JSContextRef ctx, void* bytes, size_t byteLength, JSTypedArrayBytesDeallocator bytesDeallocator, void* deallocatorContext, JSValueRef* exception);
    public void*       JSObjectGetArrayBufferBytesPtr(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    public size_t      JSObjectGetArrayBufferByteLength(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
}

/// Function declarations for Script Evaluation
extern(C) @system
{
    public JSValueRef JSEvaluateScript(JSContextRef ctx, JSStringRef script, JSObjectRef thisObject, JSStringRef sourceURL, int startingLineNumber, JSValueRef* exception);
    public bool       JSCheckScriptSyntax(JSContextRef ctx, JSStringRef script, JSStringRef sourceURL, int startingLineNumber, JSValueRef* exception);
    public void       JSGarbageCollect(JSContextRef ctx);
}