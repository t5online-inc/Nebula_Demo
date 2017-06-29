package com.t5online.nebulacore.service;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.ActivityCompat;
import android.util.Log;

import java.util.Timer;
import java.util.TimerTask;

/**
 * Created by sungju on 2017. 6. 26..
 */

public class GeolocationService {

    public static final String SERVICE_KEY_GEOLOCATION = "GeolocationService";

    Context context;
    LocationManager locationManager;
    boolean isGPSEnabled;
    boolean isNetworkEnabled;
    boolean isChecking = false;
    private Location mLocation;
    Timer timer;
    TimerTask timerTask;
    private int time;

    private GeolocationListener mGeolocationListener;

    public interface GeolocationListener {
        public void geolocationService(Location location);
    }

    public GeolocationService(Context context) {
        this.context = context;
        locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);
    }

    public void startObserve(final int time, final GeolocationListener listener) {
        isGPSEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
        isNetworkEnabled = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
        if (!isGPSEnabled && !isNetworkEnabled) {

        } else {
            this.time = time;
            this.mGeolocationListener = listener;
            ((Activity)context).runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 1000, 0, mlocationListener);
                }
            });
        }
    }

    public void stopObserve(){
        timerTask.cancel();
        timerTask = null;
        timer.cancel();
        timer.purge();
        timer = null;
        isChecking = false;
        locationManager.removeUpdates(mlocationListener);
        time = 0;
        mGeolocationListener = null;
    }

    private void checkLocation(int time, final GeolocationListener listener){
        if(!isChecking) {
            timer = new Timer(true);
            timerTask = new TimerTask() {
                @Override
                public void run() {
                    isChecking = true;
                    listener.geolocationService(mLocation);
                }
            };
            timer.schedule(timerTask, 0, time);
        }
    }

    private final LocationListener mlocationListener = new LocationListener() {
        @Override
        public void onLocationChanged(Location location) {
            mLocation = location;
            checkLocation(time, mGeolocationListener);
        }

        @Override
        public void onStatusChanged(String provider, int status, Bundle extras) {

        }

        @Override
        public void onProviderEnabled(String provider) {

        }

        @Override
        public void onProviderDisabled(String provider) {

        }
    };
}
