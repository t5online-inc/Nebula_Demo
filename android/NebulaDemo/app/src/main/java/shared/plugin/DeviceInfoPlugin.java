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
        JSONObject ret = new JSONObject();
        try {
            ret.put("phoneName", Build.MODEL);
            ret.put("platform", "Android");
            ret.put("platformVersion", Build.VERSION.RELEASE);
            ret.put("appName", getAppName());
            ret.put("modelName", Build.MODEL);
            ret.put("appVersion", getAppVersion());
            ret.put("appBuildNo", getBuildNo());
            ret.put("deviceId", getDeviceId());
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
