package org.dobots.templatemodule;

import java.util.Timer;
import java.util.TimerTask;

import android.os.Bundle;
import android.app.Activity;
import android.app.ActivityManager;
import android.app.ActivityManager.RunningServiceInfo;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import org.dobots.templatemodule.aim.*;

public class MainActivity extends Activity {
private static final String TAG = "MainActivity";
private static final String MODULE_NAME = "TemplateModule";

TextView mCallbackText;
Button mButtonStartStop;

boolean mServiceIsRunning;
Timer mCheckServiceTimer;
CheckServiceTimerTask mCheckServiceTimerTask;

@Override
protected void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	setContentView(R.layout.activity_main);
	
	mCallbackText = (TextView) findViewById(R.id.messageOutput);
	mButtonStartStop = (Button) findViewById(R.id.buttonStartStop);
	
	mButtonStartStop.setOnClickListener(new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			if (mServiceIsRunning) {
				stopService();
			}
			else {
				startService();
			}
			checkServiceRunning();
		}
	});
	
	checkServiceRunning();
	mCheckServiceTimer = new Timer();
}

	@Override
	public void onStart() {
		super.onStart();
		Log.d(TAG,"onStart");
	}

	@Override
	public void onResume() {
		super.onResume();
		Log.d(TAG,"onResume");
		mCheckServiceTimerTask = new CheckServiceTimerTask();
		mCheckServiceTimer.schedule(mCheckServiceTimerTask ,0, 1000);
	}

	@Override
	public void onPause() {
		super.onPause();
		Log.d(TAG,"onPause");
		mCheckServiceTimerTask.cancel();
	}

	@Override
	public void onStop() {
		super.onStop();
		Log.d(TAG,"onStop");
	}

	@Override
	protected void onDestroy() {
		super.onDestroy();
		Log.d(TAG, "onDestroy");
		mCheckServiceTimer.cancel();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	private void startService() {
		Intent intent = new Intent();
		intent.setClassName("org.dobots.templatemodule", "org.dobots.templatemodule.aim.TemplateModuleService");
		intent.putExtra("id", 0); // Default id
		ComponentName name = startService(intent);
		Log.i(TAG, "Starting: " + intent.toString());
	}

    private void stopService() {
		Intent intent = new Intent();
		intent.setClassName("org.dobots.templatemodule", "org.dobots.templatemodule.aim.TemplateModuleService");
		stopService(intent);
		Log.i(TAG, "Stopping service: " + intent.toString());
//		finish();
	}
    
	private void timedCheck() {
		this.runOnUiThread(new Runnable() {
			@Override
			public void run() {
				checkServiceRunning();
			}
		});
	}
	private class CheckServiceTimerTask extends TimerTask {
		@Override
		public void run() {
			timedCheck();
			//checkServiceRunning(); // Can't do this, it has to run on the UI thread
		}
	}
    
    private boolean checkServiceRunning() {
		Log.d(TAG, "Checking if service is running");
		ActivityManager manager = (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
		for (RunningServiceInfo service : manager.getRunningServices(Integer.MAX_VALUE)) {
			if (TemplateModuleService.class.getName().equals(service.service.getClassName())) {
				mServiceIsRunning = true;
				mButtonStartStop.setText("Stop module");
				mCallbackText.setText("Module is running");
				return true;
			}
		}
		mServiceIsRunning = false;
		mButtonStartStop.setText("Start module");
		mCallbackText.setText("Module stopped");
		return false;
	}
}
