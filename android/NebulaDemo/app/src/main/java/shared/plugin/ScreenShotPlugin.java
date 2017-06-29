package shared.plugin;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.support.constraint.ConstraintLayout;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.FrameLayout;

import com.t5online.nebulacore.bridge.NebulaActivity;
import com.t5online.nebulacore.plugin.Plugin;

import org.json.JSONObject;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by sungju on 2017. 6. 7..
 */

public class ScreenShotPlugin extends Plugin {

    public static final String PLUGIN_GROUP_SCREENSHOT = "screenshot";

    public void takePicture(){
        NebulaActivity activity = (NebulaActivity) this.bridgeContainer.getActivity();
        try {
            JSONObject ret = new JSONObject();
            if (snap(activity, activity.getWebViewFrameID())) {
                ret.put("code", STATUS_CODE_SUCCESS);
                ret.put("message", "");
                resolve(ret);
            } else {
                ret.put("code", STATUS_CODE_ERROR);
                ret.put("message", "");
                resolve(ret);
            }
        }catch (Exception e){
            e.printStackTrace();
            reject();
        }
    }

    protected boolean snap(Activity context, int screenId) {
        ConstraintLayout screen = (ConstraintLayout) context.findViewById(screenId);
        if (screen!=null) {

            Bitmap bitmap = Bitmap.createBitmap(((View)screen).getWidth(),
                    ((View)screen).getHeight(), Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmap);
            ((View)screen).draw(canvas);
            String filepath = saveImage(bitmap);
            rescanImage(context, filepath);
            return true;
        }
        return false;
    }

    protected String saveImage(Bitmap bmScreen2) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddhhmmss");
        String fname = formatter.format(new Date());
        File filePath = new File(
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)
                        + "/" + fname + ".png");
        if (filePath.exists())
            filePath.delete();
        try {
            FileOutputStream out = new FileOutputStream(filePath);
            bmScreen2.compress(Bitmap.CompressFormat.PNG, 100, out);
            out.flush();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return filePath.getAbsolutePath();
    }

    protected void rescanImage(Context context, String filePath) {
        if (filePath==null) return;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            File file = new File(filePath);
            if (file!=null) {
                Intent mediaScanIntent = new Intent(
                        Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
                Uri contentUri = Uri.fromFile(file);
                mediaScanIntent.setData(contentUri);
                context.sendBroadcast(mediaScanIntent);
            }
        } else {
            context.sendBroadcast(new Intent(
                    Intent.ACTION_MEDIA_MOUNTED,
                    Uri.parse("file://"
                            + Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES))));
        }
    }
}
