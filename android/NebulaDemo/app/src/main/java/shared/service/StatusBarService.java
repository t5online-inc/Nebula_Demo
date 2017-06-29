package shared.service;

import java.lang.reflect.InvocationTargetException;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.support.v4.view.ViewCompat;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.FrameLayout;

import com.t5online.nebulacore.R;

@TargetApi(Build.VERSION_CODES.LOLLIPOP)
public class StatusBarService {

    public static final String SERVICE_KEY_STATUSBAR = "StatusBarService";

    private Activity activity;

    public StatusBarService(Activity activity) {
        this.activity = activity;
    }

	/**
	 * StatusBar Set Color
	 * @param statusColor (ex Color.parse("#FFFFFF")
	 */
    public void setStatusBarColor(final int statusColor) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Window window = activity.getWindow();
                ViewGroup mContentView = (ViewGroup) activity.findViewById(Window.ID_ANDROID_CONTENT);

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                    window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                        window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
                        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
                        window.setStatusBarColor(statusColor);
                        View mChildView = mContentView.getChildAt(0);

                        if (mChildView != null) {
                            ViewCompat.setFitsSystemWindows(mChildView, true);
                        }
                    } else {
                        int statusBarHeight = getStatusBarHeight();

                        View mChildView = mContentView.getChildAt(0);

                        if (mChildView != null) {
                            FrameLayout.LayoutParams lp = (FrameLayout.LayoutParams) mChildView.getLayoutParams();

                            if (lp != null && lp.topMargin < statusBarHeight && lp.height != statusBarHeight) {
                                ViewCompat.setFitsSystemWindows(mChildView, false);
                                mChildView.setLayoutParams(lp);
                            }
                        }

                        View statusBarView = mContentView.getChildAt(0);
                        if (statusBarView != null && statusBarView.getLayoutParams() != null && statusBarView.getLayoutParams().height == statusBarHeight) {
                            statusBarView.setBackgroundColor(statusColor);
                            return;
                        }
                        statusBarView = new View(activity);
                        ViewGroup.LayoutParams lp = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, statusBarHeight);
                        statusBarView.setBackgroundColor(statusColor);
                        mContentView.addView(statusBarView, 0, lp);
                    }
                }
            }
        });
    }

    /**
     * Return StatusBar Color
     */
    public int getStatusBarColor() {
    	Window window = activity.getWindow();
        ViewGroup mContentView = (ViewGroup) activity.findViewById(Window.ID_ANDROID_CONTENT);
        
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            	return window.getStatusBarColor();
            } else {
            	View statusBarView = mContentView.getChildAt(0);
            	ColorDrawable viewColor = (ColorDrawable) statusBarView.getBackground();
            	return viewColor.getColor();
            }
        }
        return -1;
    }
    
    /**
     * Resturn Hex StatusBar Color
     */
    public String getStatusBarColorToHexString() {
    	int color = getStatusBarColor();
    	if (color != -1) {
    		String hex = String.format("#%06X", 0xFFFFFF & color);
    		return hex;
    	}
    	return null;
    }

    /**
     * StatusBar Get Height
     * @return StatusBar Height
     */
    public int getStatusBarHeight() {
        int result = 0;
        int resId = activity.getResources().getIdentifier("status_bar_height", "dimen", "android");
        if (resId > 0) {
            result = activity.getResources().getDimensionPixelOffset(resId);
        }
        return result;
    }

    public void hiddenStatusbar(final boolean isHidden) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if(isHidden){
                    activity.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
                }else{
                    activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
                }
            }
        });
    }
}