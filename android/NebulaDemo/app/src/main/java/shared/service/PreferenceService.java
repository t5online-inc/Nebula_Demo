package shared.service;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;

/**
 * Created by JoAmS on 2017. 6. 15..
 */

public class PreferenceService {

    public static final String SERVICE_KEY_PREFERENCE = "PreferenceService";

    private Context context;
    private SharedPreferences prefs;

    public PreferenceService(Context context) {
        this.context = context;
        prefs = ((Activity)context).getPreferences(Context.MODE_PRIVATE);
    }

    public boolean setPreference(String key, String value) {
        if (key == null || value  == null) return false;
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString(key, value);
        editor.apply();
        return true;
    }

    public String getPreference(String key) {
        return getPreference(key, null);
    }

    public String getPreference(String key, String defaultValue) {
        return prefs.getString(key, defaultValue);
    }

    public boolean removePreference(String key) {
        SharedPreferences.Editor editor = prefs.edit();
        editor.remove(key);
        editor.apply();
        return true;
    }

    public boolean removeAllPreference() {
        SharedPreferences.Editor editor = prefs.edit();
        editor.clear();
        editor.apply();
        return true;
    }

}
