package shared.plugin;

import android.location.Location;
import android.location.LocationListener;
import android.os.Bundle;

import com.t5online.nebulacore.Nebula;
import com.t5online.nebulacore.plugin.Plugin;
import com.t5online.nebulacore.service.GeolocationService;
import com.t5online.nebulacore.service.NativeEventService;

import org.json.JSONObject;

/**
 * Created by sungju on 2017. 6. 26..
 */

public class GeolacationPlugin extends Plugin {

    public static final String PLUGIN_GROUP_GEOLOACTION = "geolocation";

    public void start(int interval) {

        try {
            GeolocationService geolocationService = (GeolocationService) Nebula.getService(GeolocationService.SERVICE_KEY_GEOLOCATION);
            final NativeEventService nativeEventService = (NativeEventService) Nebula.getService(NativeEventService.SERVICE_KEY_NATIVEEVENT);
            nativeEventService.addEventWithBridgeContainer(bridgeContainer, PLUGIN_GROUP_GEOLOACTION);

            geolocationService.startObserve(interval*1000, new GeolocationService.GeolocationListener() {
                @Override
                public void geolocationService(Location location) {
                    try {
                        JSONObject object = new JSONObject();
                        object.put("lat", location.getLatitude());
                        object.put("long", location.getLongitude());
                        nativeEventService.sendEventWithName("GEOLOCATION_EVENT", object.toString(), PLUGIN_GROUP_GEOLOACTION);
                    }catch (Exception e){
                        e.getStackTrace();
                    }
                }
            });
            JSONObject ret = new JSONObject();
            ret.put("code", STATUS_CODE_SUCCESS);
            ret.put("message", "");
            resolve(ret);
        }catch (Exception ex){
            ex.getStackTrace();
            reject();
        }

    }

    public void stop(){
        try {
            GeolocationService geolocationService = (GeolocationService) Nebula.getService(GeolocationService.SERVICE_KEY_GEOLOCATION);
            geolocationService.stopObserve();
            JSONObject ret = new JSONObject();
            ret.put("code", STATUS_CODE_SUCCESS);
            ret.put("message", "");
            resolve(ret);
        }catch (Exception e){
            e.getStackTrace();
            reject();
        }

    }
}
