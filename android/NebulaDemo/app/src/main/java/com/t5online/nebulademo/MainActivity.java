package com.t5online.nebulademo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.t5online.nebulacore.Nebula;
import com.t5online.nebulacore.bridge.NebulaActivity;
import com.t5online.nebulacore.bridge.NebulaWebView;
import com.t5online.nebulacore.service.GeolocationService;
import com.t5online.nebulacore.service.PluginService;

import shared.plugin.*;
import shared.service.*;

public class MainActivity extends NebulaActivity {

    public static final String TARGET_URL = "http://www.t5online.com:9080/nebula/test/index.html";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        webView = (NebulaWebView)findViewById(R.id.webView);
        webView.loadUrl(TARGET_URL);
    }

    @Override
    public int getWebViewFrameID() {
        return R.id.activity_main;
    }

    @Override
    public void registerServices() {
        super.registerServices();
        Nebula.registerService(new PreferenceService(this), PreferenceService.SERVICE_KEY_PREFERENCE);
        Nebula.registerService(new GeolocationService(this), GeolocationService.SERVICE_KEY_GEOLOCATION);
        Nebula.registerService(new StatusBarService(this), StatusBarService.SERVICE_KEY_STATUSBAR);
    }

    @Override
    public void loadPlugins() {
        super.loadPlugins();
        PluginService pluginService = (PluginService) Nebula.getService(PluginService.SERVICE_KEY_PLUGIN);
        pluginService.addPlugin("shared.plugin.DeviceInfoPlugin", DeviceInfoPlugin.PLUGIN_GROUP_DEVICEINFO);
        pluginService.addPlugin("shared.plugin.PreferencePlugin", PreferencePlugin.PLUGIN_GROUP_PREFERENCE);
        pluginService.addPlugin("shared.plugin.GeolacationPlugin", GeolacationPlugin.PLUGIN_GROUP_GEOLOACTION);
        pluginService.addPlugin("shared.plugin.ScreenShotPlugin", ScreenShotPlugin.PLUGIN_GROUP_SCREENSHOT);
        pluginService.addPlugin("shared.plugin.FileSystemPlugin", FileSystemPlugin.PLUGIN_GROUP_FILESYSTEM);
        pluginService.addPlugin("shared.plugin.StatusbarPlugin", StatusbarPlugin.PLUGIN_GROUP_STATUSBAR);
    }
}
