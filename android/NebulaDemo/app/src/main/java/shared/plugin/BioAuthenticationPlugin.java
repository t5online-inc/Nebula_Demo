package shared.plugin;

import android.Manifest;
import android.annotation.TargetApi;
import android.app.KeyguardManager;
import android.content.pm.PackageManager;
import android.hardware.fingerprint.FingerprintManager;
import android.os.Build;
import android.support.v4.app.ActivityCompat;
import android.util.Log;

import com.t5online.nebulacore.plugin.Plugin;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by JoAmS on 2017. 6. 15..
 */

public class BioAuthenticationPlugin extends Plugin {

    public static final String PLUGIN_GROUP_BIO_AUTHENTICATION = "bioauthentication";

    public void isSupported() {
        Log.d("", "isAvailable");
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            FingerprintManager fingerprintManager = this.bridgeContainer.getActivity().getSystemService(FingerprintManager.class);

            if (ActivityCompat.checkSelfPermission(this.bridgeContainer.getActivity(), Manifest.permission.USE_FINGERPRINT) != PackageManager.PERMISSION_GRANTED) {
                // Check Permit
                try {
                    JSONObject ret = new JSONObject();
                    ret.put("code", STATUS_CODE_ERROR);
                    ret.put("message", "permission denied");
                    resolve(ret);
                } catch (JSONException e) {
                    reject();
                }
                return;
            }

            if (fingerprintManager.isHardwareDetected() && fingerprintManager.hasEnrolledFingerprints()) {
                try {
                    JSONObject ret = new JSONObject();
                    ret.put("code", STATUS_CODE_SUCCESS);
                    ret.put("message", "");
                    resolve(ret);
                } catch (JSONException e) {
                    reject();
                }
            } else {
                try {
                    JSONObject ret = new JSONObject();
                    ret.put("code", STATUS_CODE_ERROR);
                    ret.put("message", "unsupported device");
                    resolve(ret);
                } catch (JSONException e) {
                    reject();
                }
            }
        } else {
            try {
                JSONObject ret = new JSONObject();
                ret.put("code", STATUS_CODE_ERROR);
                ret.put("message", "unsupported device");
                resolve(ret);
            } catch (JSONException e) {
                reject();
            }
        }
    }

    public void authentication(String message) {

    }
}
