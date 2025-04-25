module ultralightd.wrapper.appcore.settings;

import ultralightd.bindings.appcore;

public struct Settings
{
    private ULSettings settings;
    
    public this(int a)
    {
        auto raw = ulCreateSettings();
        if (raw is null)
        {
            throw new Exception("Failed to create ULSettings");
        }
        
        this.settings = raw;
    }
    
    public const(ULSettings) raw() const @property => this.settings;
    
    public void setDeveloperName(string name)
    {
        
    }
}