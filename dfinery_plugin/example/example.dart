// ignore_for_file: unused_local_variable
/// Dfinery Flutter Plugin - Usage Examples
///
/// This file demonstrates how to integrate the Dfinery SDK into your Flutter app.
/// For a complete runnable example, see `lib/main.dart`.

import 'package:dfinery_plugin/dfinery_plugin.dart';

/// Initialize the Dfinery SDK with configuration.
///
/// Call this early in your app's lifecycle, typically in the main widget's initState.
void initializeDfinery() {
  // Basic initialization
  Dfinery.init(serviceId: "YOUR_SERVICE_ID");

  // Or with configuration
  final config = <String, dynamic>{
    DFConfig.iosLogLevel: DFiOSLogLevel.verbose,
    DFConfig.androidLogEnable: true,
    DFConfig.androidLogLevel: DFAndroidLogLevel.verbose,
    DFConfig.androidNotificationIconName: 'ic_notification',
    DFConfig.androidNotificationChannelId: 'default_channel',
  };
  Dfinery.initWithConfig(serviceId: "YOUR_SERVICE_ID", config: config);
}

/// Track events using predefined or custom event names.
void trackEvents() {
  // Track login event
  Dfinery.logEvent(eventName: DFEvent.login);

  // Track purchase event with properties
  final item = {
    DFEventProperty.itemId: "product_001",
    DFEventProperty.itemName: "Sample Product",
    DFEventProperty.itemPrice: 29.99,
    DFEventProperty.itemQuantity: 1,
  };

  Dfinery.logEvent(
    eventName: DFEvent.purchase,
    properties: {
      DFEventProperty.items: [item],
      DFEventProperty.orderId: "order_12345",
      DFEventProperty.totalPurchaseAmount: 29.99,
    },
  );

  // Track custom event
  Dfinery.logEvent(
    eventName: "custom_event",
    properties: {
      "custom_key": "custom_value",
      "timestamp": DateTime.now(),
    },
  );
}

/// Set user profile information for personalization and targeting.
void setUserProfile() {
  // Set single profile
  Dfinery.setUserProfile(key: DFUserProfile.name, value: "John Doe");

  // Set multiple profiles
  Dfinery.setUserProfiles(values: {
    DFUserProfile.gender: DFGender.male,
    DFUserProfile.birth: "1990-01-15",
    DFUserProfile.membership: "Premium",
    DFUserProfile.pushAdsOptin: true,
  });
}

/// Set user identity for cross-device tracking.
void setUserIdentity() {
  // Set single identity
  Dfinery.setIdentity(key: DFIdentity.externalId, value: "user_abc123");

  // Set multiple identities
  Dfinery.setIdentities(values: {
    DFIdentity.email: "user@example.com",
    DFIdentity.phoneNo: "821012345678",
  });

  // Reset identity on logout
  Dfinery.resetIdentity();
}

/// Configure push notifications (Android).
void setupPushNotifications() {
  // Create notification channel for Android 8.0+
  Dfinery.createNotificationChannel(properties: {
    DFAndroidNotificationChannelProperty.id: "marketing",
    DFAndroidNotificationChannelProperty.name: "Marketing",
    DFAndroidNotificationChannelProperty.description: "Marketing notifications",
    DFAndroidNotificationChannelProperty.importance:
        DFAndroidNotificationChannelImportance.high,
  });

  // Set push token after obtaining from FCM
  Dfinery.getPushToken().then((token) {
    if (token != null) {
      Dfinery.setPushToken(pushToken: token);
    }
  });
}

/// Handle App Tracking Transparency authorization (iOS).
void handleAttAuthorization(bool authorized) {
  // Call after requesting ATT permission
  Dfinery.attAuthorized(authorized: authorized);
}

/// SDK lifecycle management.
void sdkLifecycle() {
  // Disable SDK for privacy compliance
  Dfinery.disableSDK();

  // Re-enable SDK
  Dfinery.enableSDK();
}
