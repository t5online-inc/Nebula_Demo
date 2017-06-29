package shared.plugin;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.provider.Settings;

import com.t5online.nebulacore.plugin.Plugin;

import org.json.JSONObject;

/**
 * Created by JoAmS on 2017. 6. 15..
 */

public class DeviceInfoPlugin extends Plugin {

    public static final String PLUGIN_GROUP_DEVICEINFO = "deviceinfo";

    public void getDeviceInfo() {
        JSONObject deviceInfo = new JSONObject();
        try {
            deviceInfo.put("phoneName", Build.MODEL);
            deviceInfo.put("platform", "Android");
            deviceInfo.put("platformVersion", Build.VERSION.RELEASE);
            deviceInfo.put("appName", getAppName());
            deviceInfo.put("modelName", Build.MODEL);
            deviceInfo.put("appVersion", getAppVersion());
            deviceInfo.put("appBuildNo", getBuildNo());
            deviceInfo.put("deviceId", getDeviceId());

            JSONObject ret = new JSONObject();
            ret.put("code", STATUS_CODE_SUCCESS);
            ret.put("message", deviceInfo);
            resolve(ret);
        }catch (Exception e){
            reject();
        }
    }

    String getAppName() {
        String appName = "";
        Context context = this.bridgeContainer.getActivity();
        if (context!=null) {
            ApplicationInfo applicationInfo = context.getApplicationInfo();
            int stringId = applicationInfo.labelRes;
            appName = stringId == 0 ? applicationInfo.nonLocalizedLabel.toString() : context.getString(stringId);
        }
        return appName;
    }

    String getBuildNo() {
        String buildNo = "";
        Context context = this.bridgeContainer.getActivity();
        if (context!=null) {
            PackageManager packageManager = context.getPackageManager();
            String packageName = context.getPackageName();
            try {
                PackageInfo pi = packageManager.getPackageInfo(packageName, 0);
                buildNo = ""+pi.versionCode;
            } catch (PackageManager.NameNotFoundException e) {
                e.printStackTrace();
            }
        }
        return buildNo;
    }

    String getAppVersion() {
        String version = "";
        Context context = this.bridgeContainer.getActivity();
        if (context!=null) {
            PackageManager packageManager = context.getPackageManager();
            String packageName = context.getPackageName();
            try {
                PackageInfo pi = packageManager.getPackageInfo(packageName, 0);
                version = pi.versionName;
            } catch (PackageManager.NameNotFoundException e) {
                e.printStackTrace();
            }
        }
        return version;
    }

    String getDeviceId() {
        return android.provider.Settings.Secure.getString(this.bridgeContainer.getActivity().getContentResolver(), Settings.Secure.ANDROID_ID);
    }

}
