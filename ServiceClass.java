package com.fuse.OpenEducation;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.PixelFormat;
import android.graphics.Point;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.ResultReceiver;
import android.provider.Settings;
import android.util.Base64;
import android.view.Display;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.webkit.WebView;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.Toast;
import android.util.Log;

import java.util.Random;


public class ServiceClass extends Service {

    Context cont;
    LinearLayout ll;
    Button stop;
    LinearLayout.LayoutParams linearLayoutLayoutParams;
    WindowManager wm;

    // Example Variable Declaration
    public static boolean run = false;

    

    @Override
    public void onCreate() {
        // TODO Auto-generated method stub
        super.onCreate();
        
        cont = this;

        if (!Settings.canDrawOverlays(this)) {
            Intent canDrawOverlaysintent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:" + getPackageName() ));
            this.startActivity(canDrawOverlaysintent);
        }

        int LAYOUT_FLAG;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            LAYOUT_FLAG = WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY;
        } else {
            LAYOUT_FLAG = WindowManager.LayoutParams.TYPE_PHONE;
        }

        wm = (WindowManager) getSystemService(cont.WINDOW_SERVICE);

        Display display = wm.getDefaultDisplay();
        Point size = new Point();
        display.getSize(size);
        int width = size.x;
        int height = size.y;

        // PUT HERE ALL YOUR LONG RUNNING JAVA CODE! Like so...

        // Example Start
        Toast.makeText(cont,"Now starting the onCreate in the ServiceClass!", Toast.LENGTH_SHORT).show();

        ll = new LinearLayout(this);
        //ll.setBackgroundColor(Color.BLUE);
        LinearLayout.LayoutParams linearLayoutLayoutParams = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
        ll.setOrientation(LinearLayout.VERTICAL);

        Random rndm = new Random();
        //ll.setBackgroundColor(Color.argb(80,0,0,255));
        //ll.setBackgroundColor(Color.argb(90,rndm.nextInt(255),rndm.nextInt(255),rndm.nextInt(255)));
        ll.setLayoutParams(linearLayoutLayoutParams);

        WebView myWebView = new WebView(this);
        myWebView.setBackgroundColor(Color.TRANSPARENT);
        myWebView.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT, LinearLayout.LayoutParams.FILL_PARENT));
        // Create an unencoded HTML string
        // then convert the unencoded HTML string into bytes, encode
        // it with Base64, and load the data.

        myWebView.loadUrl("file:///android_asset/window.html");

        // Create an unencoded HTML string
        // then convert the unencoded HTML string into bytes, encode
        // it with Base64, and load the data.
        //String unencodedHtml ="<html&gt;&lt;body&gt;'%23' is the percent code for ‘#‘ &lt;/body&gt;&lt;/html&gt;";
        //String encodedHtml = Base64.encodeToString(unencodedHtml.getBytes(),Base64.NO_PADDING);
        //myWebView.loadData(encodedHtml, "text/html", "base64");

        //myWebView.loadUrl("https://www.google.com");

        final WindowManager.LayoutParams parameters = new WindowManager.LayoutParams(
                width / 2, height / 4, LAYOUT_FLAG,
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
                PixelFormat.TRANSLUCENT);
        parameters.gravity = Gravity.TOP | Gravity.LEFT;
        parameters.x = 0;
        parameters.y = 0;

        stop = new Button(this);
        stop.setText("Stop");
        ViewGroup.LayoutParams btnParameters = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.FILL_PARENT,ViewGroup.LayoutParams.WRAP_CONTENT);
        stop.setLayoutParams(btnParameters);

        ll.addView(stop);
        ll.addView(myWebView);

        wm.addView(ll, parameters);

        myWebView.setOnTouchListener(new View.OnTouchListener() {
            WindowManager.LayoutParams updatedParameters = parameters;
            double x;
            double y;
            double pressedX;
            double pressedY;

            @Override
            public boolean onTouch(View v, MotionEvent event) {

                switch (event.getAction()) {
                    case MotionEvent.ACTION_DOWN:

                        x = updatedParameters.x;
                        y = updatedParameters.y;

                        pressedX = event.getRawX();
                        pressedY = event.getRawY();

                        break;

                    case MotionEvent.ACTION_MOVE:
                        updatedParameters.x = (int) (x + (event.getRawX() - pressedX));
                        updatedParameters.y = (int) (y + (event.getRawY() - pressedY));

                        wm.updateViewLayout(ll, updatedParameters);

                    default:
                        break;
                }

                return false;
            }
        });

        stop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                wm.removeView(ll);
                stopSelf();
                run = false;
                System.exit(0);
            }
        });

    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        stopSelf();
        run = false;
        Toast.makeText(cont,"The ServiceClass > onDestroy is Excecuted !", Toast.LENGTH_SHORT).show();
        System.exit(0);
    }


    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    public static boolean getState(){
        return run;
    }

}
/*
class Alarm extends BroadcastReceiver
{
    @Override
    public void onReceive(Context context, Intent intent)
    {
        PowerManager pm = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
        PowerManager.WakeLock wl = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "");
        wl.acquire();
        // Put here YOUR code.
        Toast.makeText(context,"...and again", Toast.LENGTH_SHORT).show();
        Toast.makeText(context, "Alarm !!!!!!!!!!", Toast.LENGTH_LONG).show(); // For example
        wl.release();
    }
    public void setAlarm(Context context)
    {
        AlarmManager am =( AlarmManager)context.getSystemService(Context.ALARM_SERVICE);
        Intent i = new Intent(context, Alarm.class);
        PendingIntent pi = PendingIntent.getBroadcast(context, 0, i, 0);
        am.setRepeating(AlarmManager.RTC_WAKEUP, System.currentTimeMillis(), 5000, pi); // Millisec * Second * Minute
    }
    public void cancelAlarm(Context context)
    {
        Intent intent = new Intent(context, Alarm.class);
        PendingIntent sender = PendingIntent.getBroadcast(context, 0, intent, 0);
        AlarmManager alarmManager = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        alarmManager.cancel(sender);
    }
}
*/