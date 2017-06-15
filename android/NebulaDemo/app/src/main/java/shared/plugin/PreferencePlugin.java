package shared.plugin;

import com.t5online.nebulacore.Nebula;
import com.t5online.nebulacore.plugin.Plugin;

import org.json.JSONException;
import org.json.JSONObject;

import shared.service.PreferenceService;

/**
 * Created by JoAmS on 2017. 6. 15..
 */

public class PreferencePlugin extends Plugin {

    public static final String PLUGIN_GROUP_PREFERENCE = "preference";

    public void get(String key, String defaultValue) {
        String ret = "";
        try {
            PreferenceService preferenceService = (PreferenceService) Nebula.getService(PreferenceService.SERVICE_KEY_PREFERENCE);
            ret = preferenceService.getPreference(key, defaultValue);
            JSONObject object1 = new JSONObject();
            object1.put("value", ret);
            resolve(object1);
        } catch (JSONException e) {
            e.printStackTrace();
            reject();
        }
    }

    public void set(String key, String value) {
        PreferenceService preferenceService = (PreferenceService) Nebula.getService(PreferenceService.SERVICE_KEY_PREFERENCE);
        preferenceService.setPreference(key, value);
        resolve();
    }

    public void remove(String key) {
        PreferenceService preferenceService = (PreferenceService) Nebula.getService(PreferenceService.SERVICE_KEY_PREFERENCE);
        preferenceService.removePreference(key);
        resolve();
    }

    public void removeAll() {
        PreferenceService preferenceService = (PreferenceService) Nebula.getService(PreferenceService.SERVICE_KEY_PREFERENCE);
        preferenceService.removeAllPreference();
        resolve();
    }
}
