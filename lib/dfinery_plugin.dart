import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dfinery_plugin/src/callbacks.dart';
import 'package:flutter/services.dart';

import 'src/enums.dart';

export 'src/constants.dart';
export 'src/enums.dart';
export 'src/callbacks.dart';

/// Dfinery SDK for Flutter.
///
/// This class provides access to Dfinery analytics and marketing automation features.
/// Initialize the SDK with [init] or [initWithConfig] before using other methods.
class Dfinery {
  static const MethodChannel _channel = MethodChannel('dfinery_plugin');

  /// Initializes the Dfinery SDK
  static void init({required String serviceId}) {
    final Map<String, dynamic> params = <String, dynamic>{
      "serviceId": serviceId
    };
    _channel.invokeMethod("init", params);
  }

  /// Initializes the Dfinery SDK with the provided configuration settings.
  static void initWithConfig(
      {required String serviceId, Map<String, dynamic>? config}) {
    final Map<String, dynamic> params = <String, dynamic>{
      "serviceId": serviceId,
      "config": config
    };
    _channel.invokeMethod("initWithConfig", params);
  }

  /// Reports an event. You can use your own custom event or also can use predefined events.
  static void logEvent(
      {required String eventName, Map<String, dynamic>? properties}) {
    final Map<String, dynamic> params = <String, dynamic>{
      "eventName": eventName
    };
    if (properties != null) {
      if (_containsDateTime(properties)) {
        Map<String, dynamic> convertedProperties =
            _convertDatesToIsoString(properties);
        params["properties"] = convertedProperties;
      } else {
        params["properties"] = properties;
      }
    }
    _channel.invokeMethod("logEvent", params);
  }

  /// If the SDK is disabled, re-enable it and communicate with the server.
  /// If the SDK is enabled, no action is taken.
  static void enableSDK() {
    _channel.invokeMethod("enableSDK");
  }

  /// In some extreme cases you might want to shut down all SDK functions due to legal and privacy compliance. This can be achieved with the disable API. Once this API is invoked, our SDK no longer communicates with our servers, stops functioning and also removes personal user data.
  /// You can re-enable the SDK at any time by calling the enable API.
  static void disableSDK() {
    _channel.invokeMethod("disableSDK");
  }

  /// Sets the user's profile property value.
  static void setUserProfile({required String key, required dynamic value}) {
    dynamic converted = value;
    if (value is DateTime) {
      converted = _normalizeDateTimeToIsoString(value);
    }
    final Map<String, dynamic> params = <String, dynamic>{
      "key": key,
      "value": converted
    };
    _channel.invokeMethod("setUserProfile", params);
  }

  /// Sets multiple user profile property values.
  static void setUserProfiles({required Map<String, dynamic> values}) {
    Map<String, dynamic> converted = {};

    if (_containsDateTime(values)) {
      converted = _convertDatesToIsoString(values);
    } else {
      converted = values;
    }

    final Map<String, dynamic> params = <String, dynamic>{"values": converted};
    _channel.invokeMethod("setUserProfiles", params);
  }

  static String _identityToString(DFIdentity identity) {
    switch (identity) {
      case DFIdentity.externalId:
        return 'external_id';
      case DFIdentity.email:
        return 'email';
      case DFIdentity.phoneNo:
        return 'phone_no';
      case DFIdentity.kakaoUserId:
        return 'kakao_user_id';
      case DFIdentity.lineUserId:
        return 'line_user_id';
      default:
        return '';
    }
  }

  /// Sets additional information used to identify users. This value will be encrypted and stored in local storage.
  static void setIdentity({required DFIdentity key, required String value}) {
    String convertedParam = _identityToString(key);
    final Map<String, dynamic> params = <String, dynamic>{
      "key": convertedParam,
      "value": value
    };
    _channel.invokeMethod("setIdentity", params);
  }

  /// Sets multiple additional information used to identify users. These values will be encrypted and stored in local storage.
  static void setIdentities({required Map<DFIdentity, String> values}) {
    Map<String, String> convertedParam = {};
    values.forEach((key, value) {
      convertedParam[_identityToString(key)] = value;
    });
    final Map<String, dynamic> params = <String, dynamic>{
      "values": convertedParam
    };
    _channel.invokeMethod("setIdentities", params);
  }

  /// Resets identifier information.
  static void resetIdentity() {
    _channel.invokeMethod("resetIdentity");
  }

  /// Sets the Google Advertising ID and associated ad-tracking enabled field for this device.
  ///
  /// **Android only.** This method does nothing on iOS.
  static void setGoogleAdvertisingId(
      {required String googleAdvertisingId,
      required bool isLimitAdTrackingEnabled}) {
    if (!Platform.isAndroid) {
      return;
    }
    final Map<String, dynamic> params = <String, dynamic>{
      "googleAdvertisingId": googleAdvertisingId,
      "isLimitAdTrackingEnabled": isLimitAdTrackingEnabled
    };
    _channel.invokeMethod("setGoogleAdvertisingId", params);
  }

  /// Gets the Google Advertising ID and associated ad-tracking enabled field for this device.
  ///
  /// **Android only.** Returns `null` on iOS.
  static Future<DFGetGoogleAdvertisingIdCallback?>
      getGoogleAdvertisingId() async {
    if (!Platform.isAndroid) {
      return null;
    }
    Map<dynamic, dynamic>? callback = await _channel
        .invokeMethod("getGoogleAdvertisingId") as Map<dynamic, dynamic>?;
    if (callback == null) {
      return null;
    }
    DFGetGoogleAdvertisingIdCallback advertisingIdInfo =
        DFGetGoogleAdvertisingIdCallback(callback["googleAdvertisingId"],
            callback["isLimitAdTrackingEnabled"]);
    return advertisingIdInfo;
  }

  /// Sets the FCM registration token to be used for push notification targeting.
  static void setPushToken({required String pushToken}) {
    final Map<String, String> params = <String, String>{"pushToken": pushToken};
    _channel.invokeMethod("setPushToken", params);
  }

  /// Gets the FCM registration token to be used for push notification targeting.
  static Future<String?> getPushToken() async {
    String? pushToken = await _channel.invokeMethod("getPushToken") as String?;
    return pushToken;
  }

  /// Creates a notification channel used on devices running Android 8.0 and higher.
  ///
  /// **Android only.** This method does nothing on iOS.
  static void createNotificationChannel(
      {required Map<String, dynamic> properties}) {
    if (!Platform.isAndroid) {
      return;
    }
    final Map<String, dynamic> params = <String, dynamic>{
      "properties": jsonEncode(properties)
    };
    _channel.invokeMethod("createNotificationChannel", params);
  }

  /// Deletes a notification channel used on devices running Android 8.0 and higher.
  ///
  /// **Android only.** This method does nothing on iOS.
  static void deleteNotificationChannel({required String channelId}) {
    if (!Platform.isAndroid) {
      return;
    }
    final Map<String, dynamic> params = <String, dynamic>{
      "channelId": channelId
    };
    _channel.invokeMethod("deleteNotificationChannel", params);
  }

  /// Creates a notification channel group used on devices running Android 8.0 and higher.
  ///
  /// **Android only.** This method does nothing on iOS.
  static void createNotificationChannelGroup(
      {required Map<String, dynamic> properties}) {
    if (!Platform.isAndroid) {
      return;
    }
    final Map<String, dynamic> params = <String, dynamic>{
      "properties": jsonEncode(properties)
    };
    _channel.invokeMethod("createNotificationChannelGroup", params);
  }

  /// Deletes a notification channel group used on devices running Android 8.0 and higher.
  ///
  /// **Android only.** This method does nothing on iOS.
  static void deleteNotificationChannelGroup({required String channelGroupId}) {
    if (!Platform.isAndroid) {
      return;
    }
    final Map<String, dynamic> params = <String, dynamic>{
      "channelGroupId": channelGroupId
    };
    _channel.invokeMethod("deleteNotificationChannelGroup", params);
  }

  static String _normalizeDateTimeToIsoString(DateTime dateTime) {
    final normalizedDateTime = DateTime.utc(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
    );
    return normalizedDateTime.toIso8601String();
  }

  static bool _containsDateTime(dynamic value) {
    if (value is DateTime) {
      return true;
    } else if (value is Map) {
      for (var mapValue in value.values) {
        if (_containsDateTime(mapValue)) {
          return true;
        }
      }
    } else if (value is List) {
      for (var listItem in value) {
        if (_containsDateTime(listItem)) {
          return true;
        }
      }
    }
    return false;
  }

  static Map<String, dynamic> _convertDatesToIsoString(
      Map<String, dynamic> originalMap) {
    Map<String, dynamic> convertedMap = {};

    originalMap.forEach((key, value) {
      if (value is DateTime) {
        convertedMap[key] = _normalizeDateTimeToIsoString(value);
      } else if (value is Map<String, dynamic>) {
        if (_containsDateTime(value)) {
          convertedMap[key] = _convertDatesToIsoString(value);
        } else {
          convertedMap[key] = value;
        }
      } else if (value is List) {
        if (_containsDateTime(value)) {
          convertedMap[key] = _convertListValues(value);
        } else {
          convertedMap[key] = value;
        }
      } else {
        convertedMap[key] = value;
      }
    });

    return convertedMap;
  }

  static List _convertListValues(List originalList) {
    List convertedList = [];

    for (var item in originalList) {
      if (item is DateTime) {
        convertedList.add(_normalizeDateTimeToIsoString(item));
      } else if (item is Map<String, dynamic>) {
        if (_containsDateTime(item)) {
          convertedList.add(_convertDatesToIsoString(item));
        } else {
          convertedList.add(item);
        }
      } else if (item is List) {
        if (_containsDateTime(item)) {
          convertedList.add(_convertListValues(item));
        } else {
          convertedList.add(item);
        }
      } else {
        convertedList.add(item);
      }
    }

    return convertedList;
  }
}
