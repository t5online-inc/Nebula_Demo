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
        String value = "";
        try {
            PreferenceService preferenceService = (PreferenceService) Nebula.getService(PreferenceService.SERVICE_KEY_PREFERENCE);
            value = preferenceService.getPreference(key, defaultValue);
            JSONObject ret = new JSONObject();
            ret.put("code", STATUS_CODE_SUCCESS);
            ret.put("message", value);
            resolve(ret);
        } catch (JSONException e) {
            e.printStackTrace();
            reject();
        }
    }

    public void set(String key, String value) {
        PreferenceService preferenceService = (PreferenceService) Nebula.getService(PreferenceService.SERVICE_KEY_PREFERENCE);
        preferenceService.setPreference(key, value);
        try {
            JSONObject ret = new JSONObject();
            ret.put("code", STATUS_CODE_SUCCESS);
            ret.put("message", "");
            resolve(ret);
        }catch (Exception e){
            e.printStackTrace();
            reject();
        }
    }

    public void remove(String key) {
        PreferenceService preferenceService = (PreferenceService) Nebula.getService(PreferenceService.SERVICE_KEY_PREFERENCE);
        preferenceService.removePreference(key);
        try {
            JSONObject ret = new JSONObject();
            ret.put("code", STATUS_CODE_SUCCESS);
            ret.put("message", "");
            resolve(ret);
        }catch (Exception e){
            e.printStackTrace();
            reject();
        }
    }

    public void removeAll() {
        PreferenceService preferenceService = (PreferenceService) Nebula.getService(PreferenceService.SERVICE_KEY_PREFERENCE);
        preferenceService.removeAllPreference();
        try {
            JSONObject ret = new JSONObject();
            ret.put("code", STATUS_CODE_SUCCESS);
            ret.put("message", "");
            resolve(ret);
        }catch (Exception e){
            e.printStackTrace();
            reject();
        }
    }
}
