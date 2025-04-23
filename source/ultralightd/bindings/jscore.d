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

public enum JSType
{
    kJSTypeUndefined,
    kJSTypeNull,
    kJSTypeBoolean,
    kJSTypeNumber,
    kJSTypeString,
    kJSTypeObject,
    kJSTypeSymbol,
}

public enum JSTypedArrayType
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

/++
 + A set of JSPropertyAttributes. Combine multiple attributes by logically ORing them together.
 +/
public enum JSPropertyAttributes : uint
{
    /// Specifies that a property has no special attributes.
    kJSPropertyAttributeNone = 0,
    
    /// Specifies that a property is read-only.
    kJSPropertyAttributeReadOnly = 1 << 1,
    
    /// Specifies that a property should not be enumerated by JSPropertyEnumerators and JavaScript for...in loops.
    kJSPropertyAttributeDontEnum = 1 << 2,
    
    /// Specifies that the delete operation should fail on a property.
    kJSPropertyAttributeDontDelete = 1 << 3,
}

/++
 + A set of JSClassAttributes. Combine multiple attributes by logically ORing them together.
 +/
public enum JSClassAttributes : uint
{
    /// Specifies that a class has no special attributes.
    kJSClassAttributeNone = 0,
    
    /// Specifies that a class has no special attributes.
    kJSClassAttributeNoAutomaticPrototype = 1 << 1,
}

/++
 + This structure describes a statically declared value property.
 +/
extern(C) public struct JSStaticValue
{
    /// A null-terminated UTF8 string containing the property's name.
    public const(char)* name;
    
    /// A JSObjectGetPropertyCallback to invoke when getting the property's value.
    public JSObjectGetPropertyCallback getProperty;
    
    /// A JSObjectSetPropertyCallback to invoke when setting the property's value. May be NULL if the ReadOnly attribute is set.
    public JSObjectSetPropertyCallback setProperty;
    
    /// A logically ORed set of JSPropertyAttributes to give to the property.
    public uint attributes;
}

/++
 + This structure describes a statically declared function property.
 +/
extern(C) public struct JSStaticFunction
{
    /// A null-terminated UTF8 string containing the property's name.
    public const(char)* name;
    
    /// A JSObjectCallAsFunctionCallback to invoke when the property is called as a function.
    public JSObjectCallAsFunctionCallback callAsFunction;
    
    /// A logically ORed set of JSPropertyAttributes to give to the property.
    public JSPropertyAttributes attributes;
}

/++
 + This structure contains properties and callbacks that define a type of object. All fields other than the version field are optional. Any pointer may be NULL.
 +
 + The staticValues and staticFunctions arrays are the simplest and most efficient means for vending custom properties. Statically declared properties autmatically service requests like getProperty, setProperty, and getPropertyNames. Property access callbacks are required only to implement unusual properties, like array indexes, whose names are not known at compile-time.
 +
 + If you named your getter function "GetX" and your setter function "SetX", you would declare a JSStaticValue array containing "X" like this:
 +
 + JSStaticValue StaticValueArray[] = {
 +     { "X", GetX, SetX, kJSPropertyAttributeNone },
 +     { 0, 0, 0, 0 }
 + };
 +
 + Standard JavaScript practice calls for storing function objects in prototypes, so they can be shared. The default JSClass created by JSClassCreate follows this idiom, instantiating objects with a shared, automatically generating prototype containing the class's function objects.
 + The kJSClassAttributeNoAutomaticPrototype attribute specifies that a JSClass should not automatically generate such a prototype. The resulting JSClass instantiates objects with the default object prototype, and gives each instance object its own copy of the class's function objects.
 +
 + A NULL callback specifies that the default object callback should substitute, except in the case of hasProperty, where it specifies that getProperty should substitute.
 +
 + It is not possible to use JS subclassing with objects created from a class definition that sets callAsConstructor by default. Subclassing is supported via the JSObjectMakeConstructor function, however.
 +/
extern(C) public struct JSClassDefinition
{
    /// The version number of this structure. The current version is 0.
    public int _version;
    
    /// A logically ORed set of JSClassAttributes to give to the class.
    public uint attributes;
    
    /// A null-terminated UTF8 string containing the class's name.
    public const(char)* className;
    
    /// A JSClass to set as the class's parent class. Pass NULL use the default object class.
    public JSClassRef parentClass;
    
    /// A JSStaticValue array containing the class's statically declared value properties. Pass NULL to specify no statically declared value properties. The array must be terminated by a JSStaticValue whose name field is NULL.
    public const(JSStaticValue)* staticValues;
    
    /// A JSStaticFunction array containing the class's statically declared function properties. Pass NULL to specify no statically declared function properties. The array must be terminated by a JSStaticFunction whose name field is NULL.
    public const(JSStaticFunction)* staticFunctions;
    
    /// The callback invoked when an object is first created. Use this callback to initialize the object.
    public JSObjectInitializeCallback initialize;
    
    /// The callback invoked when an object is finalized (prepared for garbage collection). Use this callback to release resources allocated for the object, and perform other cleanup.
    public JSObjectFinalizeCallback finalize;
    
    /// The callback invoked when determining whether an object has a property. If this field is NULL, getProperty is called instead. The hasProperty callback enables optimization in cases where only a property's existence needs to be known, not its value, and computing its value is expensive.
    public JSObjectHasPropertyCallback hasProperty;
    
    /// The callback invoked when getting a property's value.
    public JSObjectGetPropertyCallback getProperty;
    
    /// The callback invoked when setting a property's value.
    public JSObjectSetPropertyCallback setProperty;
    
    /// The callback invoked when deleting a property.
    public JSObjectDeletePropertyCallback deleteProperty;
    
    /// The callback invoked when collecting the names of an object's properties.
    public JSObjectGetPropertyNamesCallback getPropertyNames;
    
    /// The callback invoked when an object is called as a function.
    public JSObjectCallAsFunctionCallback callAsFunction;
    
    /// The callback invoked when an object is used as the target of an 'instanceof' expression
    public JSObjectCallAsConstructorCallback callAsConstructor;
    
    /// The callback invoked when an object is used as a constructor in a 'new' expression.
    public JSObjectHasInstanceCallback hasInstance;
    
    /// The callback invoked when converting an object to a particular JavaScript type.
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
extern(C) nothrow @safe
{
    public JSContextGroupRef JSContextGroupCreate();
    public JSContextGroupRef JSContextGroupRetain(JSContextGroupRef group);
    public void JSContextGroupRelease(JSContextGroupRef group);
    
    public JSGlobalContextRef JSGlobalContextCreate(JSClassRef globalObjectClass);
    public JSGlobalContextRef JSGlobalContextCreateInGroup(JSContextGroupRef group, JSClassRef globalObjectClass);
    public JSGlobalContextRef JSGlobalContextRetain(JSGlobalContextRef ctx);
    public void JSGlobalContextRelease(JSGlobalContextRef ctx);
    public JSObjectRef JSGlobalContextGetGlobalObject(JSGlobalContextRef ctx);
    public JSContextGroupRef JSContextGetGroup(JSContextRef ctx);
    public JSGlobalContextRef JSContextGetGlobalContext(JSContextRef ctx);
    public JSStringRef JSGlobalContextCopyName(JSGlobalContextRef ctx);
    public void JSGlobalContextSetName(JSGlobalContextRef ctx, JSStringRef name);
    public bool JSGlobalContextIsInspectable(JSGlobalContextRef ctx);
    public void JSGlobalContextSetInspectable(JSGlobalContextRef ctx, bool inspectable);
}

/// Function declarations for the String API
extern(C) nothrow @safe
{
    public JSStringRef JSStringCreateWithCharacters(const(JSChar)* chars, size_t numChars);
    public JSStringRef JSStringCreateWithUTF8CString(const(char)* string);
    public JSStringRef JSStringRetain(JSStringRef string);
    public void JSStringRelease(JSStringRef string);
    public size_t JSStringGetLength(JSStringRef string);
    public const(JSChar)* JSStringGetCharactersPtr(JSStringRef string);
    public size_t JSStringGetMaximumUTF8CStringSize(JSStringRef string);
    public size_t JSStringGetUTF8CString(JSStringRef string, char* buffer, size_t bufferSize);
    public bool JSStringIsEqual(JSStringRef a, JSStringRef b);
    public bool JSStringIsEqualToUTF8CString(JSStringRef a, const(char)* b);
}

/// Function declarations for the Object API
extern(C) nothrow @safe
{
    public JSClassRef JSClassCreate(const(JSClassDefinition)* definition);
    public JSClassRef JSClassRetain(JSClassRef jsClass);
    public void JSClassRelease(JSClassRef jsClass);
    public JSObjectRef JSObjectMake(JSContextRef ctx, JSClassRef jsClass, void* data);
    public JSObjectRef JSObjectMakeFunctionWithCallback(JSContextRef ctx, JSStringRef name, JSObjectCallAsFunctionCallback callback);
    public JSObjectRef JSMakeConstructor(JSContextRef ctx, JSClassRef jsClass, JSObjectCallAsConstructorCallback callAsConstructor);
    public JSObjectRef JSObjectMakeArray(JSContextRef ctx, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public JSObjectRef JSObjectMakeDate(JSContextRef ctx, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public JSObjectRef JSObjectMakeError(JSContextRef ctx, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public JSObjectRef JSObjectMakeRegExp(JSContextRef ctx, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public JSObjectRef JSObjectMakeDeferredPromise(JSContextRef ctx, JSObjectRef* resolve, JSObjectRef* reject, JSValueRef* exception);
    public JSObjectRef JSObjectMakeFunction(JSContextRef ctx, JSStringRef name, uint paramaterCount, const(JSStringRef)[] parameterNames, JSStringRef body, JSStringRef sourceURL, int startingLineNumber, JSValueRef* exception);
    public JSObjectRef JSObjectGetPrototype(JSContextRef ctx, JSObjectRef object);
    public void JSObjectSetPrototype(JSContextRef ctx, JSObjectRef object, JSObjectRef value);
    public bool JSObjectHasProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName);
    public JSValueRef JSObjectGetProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);
    public void JSObjectSetProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value, JSPropertyAttributes attributes, JSValueRef* exception);
    public bool JSObjectDeleteProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef* exception);
    public bool JSObjectHasPropertyForKey(JSContextRef ctx, JSObjectRef object, JSValueRef propertyKey, JSValueRef* exception);
    public JSValueRef JSObjectGetPropertyForKey(JSContextRef ctx, JSObjectRef object, JSValueRef propertyKey, JSValueRef* exception);
    public void JSObjectSetPropertyForKey(JSContextRef ctx, JSObjectRef object, JSValueRef propertyKey, JSValueRef value, JSPropertyAttributes attributes, JSValueRef* exception);
    public bool JSObjectDeletePropertyForKey(JSContextRef ctx, JSObjectRef object, JSValueRef propertyKey, JSValueRef* exception);
    public JSValueRef JSObjectGetPropertyAtIndex(JSContextRef ctx, JSObjectRef object, uint propertyIndex, JSValueRef* exception);
    public void JSObjectSetPropertyAtIndex(JSContextRef ctx, JSObjectRef object, uint propertyIndex, JSValueRef value, JSValueRef* exception);
    public bool JSObjectSetPrivate(JSObjectRef object, void* data);
    public bool JSObjectIsFunction(JSContextRef ctx, JSObjectRef object);
    public JSValueRef JSObjectCallAsFunction(JSContextRef ctx, JSObjectRef object, JSObjectRef thisObject, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public bool JSObjectIsConstructor(JSContextRef ctx, JSObjectRef object);
    public JSValueRef JSObjectCallAsConstructor(JSContextRef ctx, JSObjectRef object, size_t argumentCount, const(JSValueRef)[] arguments, JSValueRef* exception);
    public JSPropertyNameArrayRef JSObjectCopyPropertyNames(JSContextRef ctx, JSObjectRef object);
    public JSPropertyNameArrayRef JSPropertyNameArrayRetain(JSPropertyNameArrayRef array);
    public void JSPropertyNameArrayRelease(JSPropertyNameArrayRef array);
    public size_t JSPropertyNameArrayGetCount(JSPropertyNameArrayRef array);
    public JSStringRef JSPropertyNameArrayGetNameAtIndex(JSPropertyNameArrayRef array, size_t index);
    public void JSPropertyNameAccumulatorAddName(JSPropertyNameAccumulatorRef accumulator, JSStringRef propertyName);
    
    /// ObjectRef Private API
    public bool JSObjectSetPrivateProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName, JSValueRef value);
    public JSValueRef JSObjectGetPrivateProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName);
    public bool JSObjectDeletePrivateProperty(JSContextRef ctx, JSObjectRef object, JSStringRef propertyName);
    public JSObjectRef JSObjectGetProxyTarget(JSObjectRef object);
    public JSGlobalContextRef JSObjectGetGlobalContext(JSObjectRef object);
}

/// Function declarations for the Value API
extern(C) nothrow @safe
{
    public JSType JSValueGetType(JSContextRef ctx, JSValueRef value);
    public bool JSValueIsUndefined(JSContextRef ctx, JSValueRef value);
    public bool JSValueIsNull(JSContextRef ctx, JSValueRef value);
    public bool JSValueIsBoolean(JSContextRef ctx, JSValueRef value);
    public bool JSValueIsNumber(JSContextRef ctx, JSValueRef value);
    public bool JSValueIsString(JSContextRef ctx, JSValueRef value);
    public bool JSValueIsSymbol(JSContextRef ctx, JSValueRef value);
    public bool JSValueIsObject(JSContextRef ctx, JSValueRef value);
    public bool JSValueIsObjectOfClass(JSContextRef ctx, JSValueRef value, JSClassRef jsClass);
    public bool JSValueIsArray(JSContextRef ctx, JSValueRef value);
    public bool JSValueIsDate(JSContextRef ctx, JSValueRef value);
    public JSTypedArrayType JSValueGetTypedArrayType(JSContextRef ctx, JSValueRef value, JSValueRef* exception);
    public bool JSValueIsEqual(JSContextRef ctx, JSValueRef a, JSValueRef b, JSValueRef* exception);
    public bool JSValueIsStrictEqual(JSContextRef ctx, JSValueRef a, JSValueRef b);
    public bool JSValueIsInstanceOfConstructor(JSContextRef ctx, JSValueRef value, JSObjectRef constructor, JSValueRef* exception);
    public JSValueRef JSValueMakeUndefined(JSContextRef ctx);
    public JSValueRef JSValueMakeNull(JSContextRef ctx);
    public JSValueRef JSValueMakeBoolean(JSContextRef ctx, bool boolean);
    public JSValueRef JSValueMakeNumber(JSContextRef ctx, double number);
    public JSValueRef JSValueMakeString(JSContextRef ctx, JSStringRef string);
    public JSValueRef JSValueMakeSymbol(JSContextRef ctx, JSStringRef description);
    public JSValueRef JSValueMakeFromJSONString(JSContextRef ctx, JSStringRef string);
    public JSStringRef JSValueCreateJSONString(JSContextRef ctx, JSValueRef value, uint indent, JSValueRef* exception);
    public bool JSValueToBoolean(JSContextRef ctx, JSValueRef value);
    public double JSValueToNumber(JSContextRef ctx, JSValueRef value, JSValueRef* exception);
    public JSStringRef JSValueToStringCopy(JSContextRef ctx, JSValueRef value, JSValueRef* exception);
    public JSValueRef JSValueToObject(JSContextRef ctx, JSValueRef value, JSValueRef* exception);
    public void JSValueProtect(JSContextRef ctx, JSValueRef value);
    public void JSValueUnprotect(JSContextRef ctx, JSValueRef value);
}

/// Function declarations for the Typed Array API
extern(C) nothrow @safe
{
    public JSObjectRef JSObjectMakeTypedArray(JSContextRef ctx, JSTypedArrayType arrayType, size_t length, JSValueRef* exception);
    public JSObjectRef JSObjectMakeTypedArrayWithBytesNoCopy(JSContextRef ctx, JSTypedArrayType arrayType, void* bytes, size_t byteLength, JSTypedArrayBytesDeallocator bytesDeallocator, void* deallocatorContext, JSValueRef* exception);
    public JSObjectRef JSObjectMakeTypedArrayWithArrayBuffer(JSContextRef ctx, JSTypedArrayType arrayType, JSObjectRef buffer, JSValueRef* exception);
    public JSObjectRef JSObjectMakeTypedArrayWithArrayBufferAndOffset(JSContextRef ctx, JSTypedArrayType arrayType, JSObjectRef buffer, size_t byteOffset, size_t length, JSValueRef* exception);
    public void* JSObjectGetTypedArrayBytesPtr(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    public size_t JSObjectGetTypedArrayLength(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    public size_t JSObjectGetTypedArrayByteLength(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    public size_t JSObjectGetTypedArrayByteOffset(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    public JSObjectRef JSObjectGetTypedArrayBuffer(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    
    public JSObjectRef JSObjectMakeArrayBufferWithBytesNoCopy(JSContextRef ctx, void* bytes, size_t byteLength, JSTypedArrayBytesDeallocator bytesDeallocator, void* deallocatorContext, JSValueRef* exception);
    public void* JSObjectGetArrayBufferBytesPtr(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
    public size_t JSObjectGetArrayBufferByteLength(JSContextRef ctx, JSObjectRef object, JSValueRef* exception);
}

/// Function declarations for Script Evaluation
extern(C) nothrow @safe
{
    public JSValueRef JSEvaluateScript(JSContextRef ctx, JSStringRef script, JSObjectRef thisObject, JSStringRef sourceURL, int startingLineNumber, JSValueRef* exception);
    public bool JSCheckScriptSyntax(JSContextRef ctx, JSStringRef script, JSStringRef sourceURL, int startingLineNumber, JSValueRef* exception);
    public void JSGarbageCollect(JSContextRef ctx);
}