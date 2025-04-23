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
    
    public ULSettings raw() @property => this.settings;
    
    public void setDeveloperName(string name)
    {
        
    }
    
    public void setCachePath(string path) 
    {
        //ulSettingsSetCachePath(this.raw, path.toStringz());
    }
    
    public void setPersistentStoragePath(string path) 
    {
        //ulSettingsSetPersistentStoragePath(this.raw, path.toStringz());
    }
}