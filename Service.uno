using Fuse;
using Fuse.Scripting;
using Fuse.Reactive;
using Uno.UX;
using Uno;
using Uno.Compiler.ExportTargetInterop;

using Uno.Collections;
using Uno.Threading;


[extern(Android) Require("AndroidManifest.ApplicationElement",
 "<service android:name=\"com.fuse.OpenEducation.ServiceClass\" android:enabled=\"true\" android:process=\":backgProc\" />")]
[Require("AndroidManifest.Permission", "android.permission.SYSTEM_ALERT_WINDOW")]
[extern(Android) ForeignInclude(Language.Java, 
    "android.content.Intent", 
    "android.content.Context", 
    "android.os.Bundle",
    "android.app.Activity",
    "java.lang.*",
    "android.widget.Toast",
    //"Java.lang.*",
    //"android.content.SharedPreferences",
    //"android.os.Handler",
    //"android.os.ResultReceiver",
    "com.fuse.OpenEducation.ServiceClass")]
[UXGlobalModule]
public class Service : NativeEventEmitterModule
{ 
    static readonly Service _instance;
    public static bool Service_status;

    public Service() : base(true, "Service")
    { 
        if(_instance != null) {
            return;
        } else {
            _instance = this;
        }
        Service_status = false;
        Uno.UX.Resource.SetGlobalKey(_instance, "Service");
        if defined(Android) {Emit("Service", false);}
        AddMember(new NativeFunction("StartService", (NativeCallback)StartService));
        AddMember(new NativeFunction("StopService", (NativeCallback)StopService));
        AddMember(new NativeFunction("SendService_status", (NativeCallback)SendService_status));
        
    }

    
    object StartService(Context c, object[] args)
    {
        if defined(Android) StartServiceJ();
        return null;
    }

    object StopService(Context c, object[] args)
    {
        if defined(Android) StopServiceJ();
        return null;
    }

    object[] SendService_status(Fuse.Scripting.Context context, object[] args)
    {

            if (Service_status){
                Emit("Service", true);
            }
            else if (!Service_status){
                Emit("Service", false);
            }
            
            return null;
    }

    void Emit(bool args) {
        Emit("Service", args);
    }

    
    [Foreign(Language.Java)]
    extern(Android) void StartServiceJ()
    @{
        try{

            if(!@{Service_status:Get()}) {
               Activity a = com.fuse.Activity.getRootActivity();
               a.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        com.fuse.Activity.getRootActivity().startService(new Intent(com.fuse.Activity.getRootActivity(), ServiceClass.class));    
                    }
                });
               
               android.util.Log.d("BackgService", "UnoService started");
               ServiceClass.run=true;
               @{Service_status:Set(true)};
               //Emit("Service", true);
               @{Service:Of(_this).Emit(bool):Call(true)};
            } else {
                android.util.Log.d("BackgService", "UnoService already started");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    @}

    
    [Foreign(Language.Java)]
    extern(Android) void StopServiceJ()
    @{
        try{
            if(@{Service_status:Get()}) {
               Activity a = com.fuse.Activity.getRootActivity();
               a.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        com.fuse.Activity.getRootActivity().stopService(new Intent(com.fuse.Activity.getRootActivity(), ServiceClass.class));    
                    }
                });
                
                android.util.Log.d("BackgService", "UnoService stopped");
                 ServiceClass.run=false;
                 @{Service_status:Set(false)};
                 //Emit("Service", false);
                 @{Service:Of(_this).Emit(bool):Call(false)};
            } else {
                android.util.Log.d("BackgService", "UnoService already stopped");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    @}



    
}