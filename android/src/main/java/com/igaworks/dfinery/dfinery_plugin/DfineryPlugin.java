package com.igaworks.dfinery.dfinery_plugin;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.util.Base64;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.LifecycleOwner;

import com.igaworks.dfinery.Dfinery;
import com.igaworks.dfinery.DfineryActivityLifecycleCallbacks;
import com.igaworks.dfinery.DfineryBridge;
import com.igaworks.dfinery.DfineryProperties;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** DfineryPlugin */
public class DfineryPlugin implements FlutterPlugin, MethodCallHandler {
  private static final String TAG = "dfn_DfineryPlugin";
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private DfineryBridge dfineryBridge;
  private Context context;
  private DfineryActivityLifecycleCallbacks lifecycleCallbacks;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "dfinery_plugin");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
    lifecycleCallbacks = new DfineryActivityLifecycleCallbacks();
    ((Application)context).registerActivityLifecycleCallbacks(lifecycleCallbacks);
    dfineryBridge = DfineryBridge.getInstance();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if(dfineryBridge == null){
        Log.d(TAG, "dfineryBridge is null");
        return;
    }
    if (call.method.equals("logEvent")) {
      String eventName = call.argument("eventName");
      Map<String, Object> properties = call.argument("properties");
      if(properties == null){
        Dfinery.getInstance().logEvent(eventName);
      } else{
        JSONObject param = new JSONObject(properties);
        Dfinery.getInstance().logEvent(eventName, param);
      }
    } else if(call.method.equals("enableSDK")){
      Dfinery.getInstance().enableSDK();
    } else if(call.method.equals("disableSDK")) {
      Dfinery.getInstance().disableSDK();
    } else if (call.method.equals("setUserProfile")) {
      String key = call.argument("key");
      Object value = call.argument("value");
      dfineryBridge.setUserProfile(key, value);
    } else if(call.method.equals("setUserProfiles")){
      Map<String, Object> values = call.argument("values");
      Log.d(TAG, "user profiles value is null");
      JSONObject root = new JSONObject(values);
      dfineryBridge.setUserProfiles(root);
    } else if(call.method.equals("setIdentity")){
      String key = call.argument("key");
      String value = call.argument("value");
      dfineryBridge.setIdentity(key, value);
    } else if(call.method.equals("setIdentities")){
      Map<String, String> values = call.argument("values");
      if(values == null){
        Log.d(TAG, "identities value is null");
        return;
      }
      JSONObject root = new JSONObject(values);
      dfineryBridge.setIdentities(root);
    } else if(call.method.equals("resetIdentity")){
      DfineryProperties.resetIdentity();
    } else if(call.method.equals("setGoogleAdvertisingId")){
      String googleAdvertisingId = call.argument("googleAdvertisingId");
      Boolean isLimitAdTrackingEnabled = call.argument("isLimitAdTrackingEnabled");
      DfineryProperties.setGoogleAdvertisingId(googleAdvertisingId, isLimitAdTrackingEnabled);
    } else if(call.method.equals("setPushToken")){
      String pushToken = call.argument("pushToken");
      DfineryProperties.setPushToken(pushToken);
    } else if (call.method.equals("handleRemoteMessage")) {
      String message = call.argument("message");
      boolean callback = dfineryBridge.handleRemoteMessage(context, message);
      result.success(callback);
    } else if (call.method.equals("init")) {
      String serviceId = call.argument("serviceId");
      dfineryBridge.init(context, serviceId);
    } else if (call.method.equals("initWithConfig")) {
      String serviceId = call.argument("serviceId");
      Map<String, Object> config = call.argument("config");
      if(config == null){
        dfineryBridge.init(context, serviceId);
      } else{
        JSONObject param = new JSONObject(config);
        dfineryBridge.init(context, serviceId, param.toString());
      }
    } else if (call.method.equals("getGoogleAdvertisingId")) {
      dfineryBridge.getGoogleAdvertisingId(context, new DfineryBridge.DfineryGetGoogleAdvertisingIdCallback() {
        @Override
        public void onCallback(String googleAdvertisingId, boolean isLimitAdTrackingEnabled) {
          Map<String, Object> map = new HashMap<>();
          map.put("googleAdvertisingId", googleAdvertisingId);
          map.put("isLimitAdTrackingEnabled", isLimitAdTrackingEnabled);
          result.success(map);
        }
      });
    } else if (call.method.equals("getPushToken")) {
      dfineryBridge.getPushToken(new DfineryBridge.DfineryBridgeCallback() {
        @Override
        public void onCallback(String token) {
          result.success(token);
        }
      });
    } else if (call.method.equals("createNotificationChannel")) {
      String properties = call.argument("properties");
      dfineryBridge.createNotificationChannel(context, properties);
    } else if (call.method.equals("deleteNotificationChannel")) {
      String channelId = call.argument("channelId");
      dfineryBridge.deleteNotificationChannel(context, channelId);
    } else if (call.method.equals("createNotificationChannelGroup")) {
      String properties = call.argument("properties");
      dfineryBridge.createNotificationChannelGroup(context, properties);
    } else if (call.method.equals("deleteNotificationChannelGroup")) {
      String channelId = call.argument("channelGroupId");
      dfineryBridge.deleteNotificationChannelGroup(context, channelId);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    ((Application)binding.getApplicationContext()).unregisterActivityLifecycleCallbacks(lifecycleCallbacks);
    lifecycleCallbacks = null;
    context = null;
    dfineryBridge = null;
    channel = null;
  }
}
