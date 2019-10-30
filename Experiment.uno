using Uno;
using Uno.UX;
using Uno.Collections;
using Fuse;
using Fuse.Scripting;
using Uno.Threading;

using Uno.Compiler.ExportTargetInterop;


	[UXGlobalModule]
	public class Experiment: NativeModule
	{
		static readonly Experiment _instance;
		public Experiment(){
			if (_instance != null) return;
			_instance = this;
			Resource.SetGlobalKey(_instance, "ForeignCodeExperimentModule");
			AddMember( new NativeFunction("toastText", (NativeCallback)toastText) );
			AddMember( new NativeFunction("Notify", (NativeCallback)Notify) );
			AddMember( new NativeFunction("GetWindow", (NativeCallback)GetWindow) );

			AddMember( new NativeFunction("OpenWifiSettings", (NativeCallback)OpenWifiSettings) );
			AddMember( new NativeFunction("OpenSyncSettings", (NativeCallback)OpenSyncSettings) );
			AddMember( new NativeFunction("OpenSettings", (NativeCallback)OpenSettings) );
			AddMember( new NativeFunction("OpenSoundSettings", (NativeCallback)OpenSoundSettings) );
			AddMember( new NativeFunction("OpenAccessibilitySettings", (NativeCallback)OpenAccessibilitySettings) );
			AddMember( new NativeFunction("OpenAddAccountSettings", (NativeCallback)OpenAddAccountSettings) );
			AddMember( new NativeFunction("OpenAirplaineModeSettings", (NativeCallback)OpenAirplaineModeSettings) );
			AddMember( new NativeFunction("OpenAPNSettings", (NativeCallback)OpenAPNSettings) );
			AddMember( new NativeFunction("OpenApplicationSettings", (NativeCallback)OpenApplicationSettings) );
			AddMember( new NativeFunction("OpenApplicationNotificationSettings", (NativeCallback)OpenApplicationNotificationSettings) );
			AddMember( new NativeFunction("canDrawOverlays", (NativeCallback)canDrawOverlays) );
			

		}

		static object toastText(Context c, object[] args)
		{
			if defined(Android)
			{
				foreach (var arg in args){
					ExperimentImpl.toastText((string)arg);
				}
				
			}else{
				debug_log("====> toastText function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object Notify(Context c, object[] args)
		{
			if defined(Android)
			{
				foreach (var arg in args){
					ExperimentImpl.Notify((string)arg);
				}
				
			}else{
				debug_log("====> Notify function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object GetWindow(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.GetWindow();
				
			}else{
				debug_log("====> GetWindow function cannot be loged because is not Android <====");
			}
			return null;
		}



		static object OpenWifiSettings(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.OpenWifiSettings();
				
			}else{
				debug_log("====> OpenWifiSettings function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object OpenSyncSettings(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.OpenSyncSettings();
				
			}else{
				debug_log("====> OpenSyncSettings function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object OpenSettings(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.OpenSettings();
				
			}else{
				debug_log("====> OpenSettings function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object OpenSoundSettings(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.OpenSoundSettings();
				
			}else{
				debug_log("====> OpenSoundSettings function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object OpenAccessibilitySettings(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.OpenAccessibilitySettings();
				
			}else{
				debug_log("====> OpenAccessibilitySettings function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object OpenAddAccountSettings(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.OpenAddAccountSettings();
				
			}else{
				debug_log("====> OpenAddAccountSettings function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object OpenAirplaineModeSettings(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.OpenAirplaineModeSettings();
				
			}else{
				debug_log("====> OpenAirplaineModeSettings function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object OpenAPNSettings(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.OpenAPNSettings();
				
			}else{
				debug_log("====> OpenAPNSettings function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object OpenApplicationSettings(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.OpenApplicationSettings();
				
			}else{
				debug_log("====> OpenApplicationSettings function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object OpenApplicationNotificationSettings(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.OpenApplicationNotificationSettings();
				
			}else{
				debug_log("====> OpenApplicationNotificationSettings function cannot be loged because is not Android <====");
			}
			return null;
		}
		static object canDrawOverlays(Context c, object[] args)
		{
			if defined(Android)
			{
					ExperimentImpl.canDrawOverlays();
				
			}else{
				debug_log("====> canDrawOverlays function cannot be loged because is not Android <====");
			}
			return null;
		}


	}

	//[ForeignInclude(Language.Java, "android.content.Intent")]
	//[ForeignInclude(Language.Java, "android.app.Activity")]
	//[ForeignInclude(Language.Java, "android.content.Context")]
	[ForeignInclude(Language.Java, "android.content.*")]
	[ForeignInclude(Language.Java, "android.app.*")]
	[ForeignInclude(Language.Java, "android.util.*")]
	[ForeignInclude(Language.Java, "android.os.*")]
	[ForeignInclude(Language.Java, "android.view.*")]
	[ForeignInclude(Language.Java, "android.widget.*")]
	[ForeignInclude(Language.Java, "android.graphics.*")]
	[ForeignInclude(Language.Java, "android.view.WindowManager")]
	[ForeignInclude(Language.Java, "android.provider.Settings")]
	[Require("AndroidManifest.Permission", "android.permission.SYSTEM_ALERT_WINDOW")]
	//[Require("Gradle.Dependency.Compile", "com.android.support:support-compat:28.0.0")]
	//[Require("Gradle.Dependency.Compile", "com.github.lecho:hellocharts-library:1.5.8@aar")]
	//[ForeignInclude(Language.Java, "com.fuse.Activity")]
	//[Require("Gradle.Dependency","compile('com.facebook.android:facebook-android-sdk:4.8.+') { exclude module: 'support-v4' }")]
	//[Require("Gradle.Dependency","compile('com.facebook.android:facebook-android-sdk:4.8.+') { exclude module: 'support-v4' }")]
	//[Require("Gradle.Repository","mavenCentral()")]
	public extern(Android) class ExperimentImpl
	{	
		[Foreign(Language.Java)]
		public static extern(Android) void toastText(string text)
		@{
			Activity a = com.fuse.Activity.getRootActivity();
			String activityClassName = a.getClass().toString();
			a.runOnUiThread(new Runnable() {
				@Override
		        public void run() {
		            Toast.makeText(com.fuse.Activity.getRootActivity(), text, Toast.LENGTH_LONG).show();
		        }
			});
			Log.d("==> ForeignCodeExample <==", activityClassName + " " + text);
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void Notify(string text)
		@{
			Activity a = com.fuse.Activity.getRootActivity();
			String activityClassName = a.getClass().toString();
			a.runOnUiThread(new Runnable() {
				@Override
		        public void run() {
		            Toast.makeText(com.fuse.Activity.getRootActivity(), text, Toast.LENGTH_LONG).show();
		        }
			});
			Log.d("==> ForeignCodeExample <==", activityClassName + " " + text);
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void GetWindow()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			String activityClassName = a.getClass().toString();
			a.runOnUiThread(new Runnable() {
				@Override
		        public void run() {
		            
					int LAYOUT_FLAG;
					if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
	                    // Show alert dialog to the user saying a separate permission is needed
	                    // Launch the settings activity if the user prefers
	                    //Intent myIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
	                    Intent myIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
	                    a.startActivity(myIntent);
	                }
	                /*final WindowManager wm = (WindowManager) com.fuse.Activity.getRootActivity().getSystemService(com.fuse.Activity.getRootActivity().WINDOW_SERVICE);
					Log.d("==> ForeignCodeExample <==", wm + " " + text);
			        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
			            LAYOUT_FLAG = WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY;
			        } else {
			            LAYOUT_FLAG = WindowManager.LayoutParams.TYPE_PHONE;
			        }*/
			       
			        
		        }
			});
		@}



		[Foreign(Language.Java)]
		public static extern(Android) void OpenAccessibilitySettings()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			a.startActivityForResult(new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS),0);
			
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void OpenAddAccountSettings()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			a.startActivityForResult(new Intent(Settings.ACTION_ADD_ACCOUNT),0);
			
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void OpenAirplaineModeSettings()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			a.startActivityForResult(new Intent(Settings.ACTION_AIRPLANE_MODE_SETTINGS),0);
			
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void OpenAPNSettings()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			a.startActivityForResult(new Intent(Settings.ACTION_APN_SETTINGS),0);
			
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void OpenWifiSettings()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			a.startActivityForResult(new Intent(Settings.ACTION_WIFI_SETTINGS),0);
			
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void OpenSyncSettings()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			a.startActivityForResult(new Intent(Settings.ACTION_SYNC_SETTINGS),0);
			
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void OpenSettings()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			a.startActivityForResult(new Intent(Settings.ACTION_SETTINGS),0);
			
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void OpenSoundSettings()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			a.startActivityForResult(new Intent(Settings.ACTION_SOUND_SETTINGS),0);
			
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void OpenApplicationSettings()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			a.startActivityForResult(new Intent(Settings.ACTION_APPLICATION_SETTINGS),0);
			
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void OpenApplicationNotificationSettings()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			Intent intent = new Intent();
			intent.setAction("android.settings.APP_NOTIFICATION_SETTINGS");

			//for Android 5-7
			intent.putExtra("app_package", a.getPackageName());
			intent.putExtra("app_uid", a.getApplicationInfo().uid);

			// for Android 8 and above
			intent.putExtra("android.provider.extra.APP_PACKAGE", a.getPackageName());
			a.startActivityForResult(intent,0);
			
		@}
		[Foreign(Language.Java)]
		public static extern(Android) void canDrawOverlays()
		@{
			final Activity a = com.fuse.Activity.getRootActivity();
			if (android.os.Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if(Settings.canDrawOverlays(a)){
                    Toast.makeText(a,"The canDrawOverlays Permission is already granted",Toast.LENGTH_LONG).show();
                }else if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    // Show alert dialog to the user saying a separate permission is needed
                    // Launch the settings activity if the user prefers
                    Intent myIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
                    a.startActivity(myIntent);
                }else{
                	Toast.makeText(a,"The canDrawOverlays Permission is already granted",Toast.LENGTH_LONG).show();
                }
            }
			
		@}

	}
