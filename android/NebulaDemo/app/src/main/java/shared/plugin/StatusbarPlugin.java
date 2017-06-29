package shared.plugin;

import android.app.Activity;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.os.Build;
import android.support.v4.content.ContextCompat;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;

import com.t5online.nebulacore.Nebula;
import com.t5online.nebulacore.plugin.Plugin;

import org.json.JSONObject;

import shared.service.StatusBarService;

/**
 * Created by sungju on 2017. 6. 7..
 */

public class StatusbarPlugin extends Plugin {

    public static final String PLUGIN_GROUP_STATUSBAR = "statusbar";

    public void setStatusBar(boolean isHidden, String backgroundColor, boolean isDefault) {

        StatusBarService statusBarService = (StatusBarService) Nebula.getService(StatusBarService.SERVICE_KEY_STATUSBAR);
        try {
            if (bridgeContainer.getSync()) {
                JSONObject ret = new JSONObject();
                ret.put("code", STATUS_CODE_ERROR);
                ret.put("message", "unsupported synchronous");
                resolve(ret);
                return;
            }
            statusBarService.hiddenStatusbar(isHidden);
            statusBarService.setStatusBarColor(Color.parseColor(backgroundColor));
            if (isDefault) {
                statusBarService.setStatusBarColor(com.t5online.nebulacore.R.color.colorPrimary);
            }
            resolve();
        } catch (Exception e) {
            reject();
        }

    }
}
