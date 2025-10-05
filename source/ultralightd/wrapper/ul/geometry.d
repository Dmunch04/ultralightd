module ultralightd.wrapper.ul.geometry;

import ultralightd.bindings.ultralight;

/// A rectangle with floating-point coordinates.
public struct Rect
{
    public float left;
    public float top;
    public float right;
    public float bottom;

    public this(float left, float top, float right, float bottom)
    {
        this.left = left;
        this.top = top;
        this.right = right;
        this.bottom = bottom;
    }

    /// Create a rectangle from a raw ULRect.
    public static Rect fromRaw(ULRect raw) => Rect(raw.left, raw.top, raw.right, raw.bottom);

    /// Create a new empty rectangle.
    public static Rect empty() => Rect.fromRaw(ulRectMakeEmpty());
    
    /// Creates a copy of the rectangle in the ULRect format, which can be used with the Ultralight API
    public ULRect toRaw() => ULRect(left, top, right, bottom);
    
    /// Check if the rectangle is empty.
    public bool isEmpty() => ulRectIsEmpty(toRaw);
    
    /// Get the width of the rectangle.
    public float width() => right - left;
    
    /// Get the height of the rectangle.
    public float height() => bottom - top;
}

/// A rectangle with integer coordinates.
public struct IntRect
{
    public int left;
    public int top;
    public int right;
    public int bottom;
    
    public this(int left, int top, int right, int bottom)
    {
        this.left = left;
        this.top = top;
        this.right = right;
        this.bottom = bottom;
    }

    /// Create a rectangle from a raw ULRect.
    public static IntRect fromRaw(ULIntRect raw) => IntRect(raw.left, raw.top, raw.right, raw.bottom);

    /// Create a new empty rectangle.
    public static IntRect empty() => IntRect.fromRaw(ulIntRectMakeEmpty());
    
    /// Creates a copy of the rectangle in the ULIntRect format, which can be used with the Ultralight API
    public ULIntRect toRaw() => ULIntRect(left, top, right, bottom);
    
    /// Check if the rectangle is empty.
    public bool isEmpty() => ulIntRectIsEmpty(toRaw);
    
    /// Get the width of the rectangle.
    public float width() => right - left;
    
    /// Get the height of the rectangle.
    public float height() => bottom - top;
}
