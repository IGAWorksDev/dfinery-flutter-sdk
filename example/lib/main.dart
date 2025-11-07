import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dfinery_plugin/dfinery_plugin.dart';

void main() {
  runApp(const DfineryApp());
}

class DfineryApp extends StatefulWidget {
  const DfineryApp({super.key});

  @override
  State<DfineryApp> createState() => _DfineryAppState();
}

class _DfineryAppState extends State<DfineryApp> {
  @override
  void initState() {
    super.initState();

    // Dfinery init runs once when the app widget is created.
    final config = <String, dynamic>{
      DFConfig.iosLogEnable: true,
      DFConfig.androidLogEnable: true,
      DFConfig.androidLogLevel: DFAndroidLogLevel.verbose,
      DFConfig.androidNotificationIconName: 'ic_dfinery',
      DFConfig.androidNotificationChannelId: 'dfinery',
    };
    Dfinery.initWithConfig(serviceId: "SERVICE_ID", config: config);

    Dfinery.getPushToken().then((token) {
      if (token != null) {
        Dfinery.setPushToken(pushToken: token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'DFinery Sample', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void dfineryLogin() {
    Dfinery.logEvent(eventName: DFEvent.login);
  }

  void dfineryPurchase() {
    final item = {
      DFEventProperty.itemId: "상품번호",
      DFEventProperty.itemName: "상품이름",
      DFEventProperty.itemCategory1: "식품",
      DFEventProperty.itemCategory2: "과자",
      DFEventProperty.itemPrice: 5000.0,
      DFEventProperty.itemDiscount: 500.0,
      DFEventProperty.itemQuantity: 5,
    };
    final items = [item];
    final param = {
      DFEventProperty.items: items,
      DFEventProperty.orderId: "상품번호",
      DFEventProperty.paymentMethod: "BankTransfer",
      DFEventProperty.totalPurchaseAmount: 25500.0,
      DFEventProperty.deliveryCharge: 3000.0,
      DFEventProperty.itemDiscount: 0,
    };

    Dfinery.logEvent(eventName: DFEvent.purchase, properties: param);
  }

  void dfineryCustomEvent() {
    Dfinery.logEvent(
      eventName: "custom_event",
      properties: {
        "custom_property_1": 34000,
        "custom_property_2": 42.195,
        "custom_property_3": "Seoul",
        "custom_property_4": true,
        "custom_property_5": DateTime.now(),
        "custom_property_6": "1991-01-01",
        "custom_property_7": [20, 30, 40],
        "custom_property_8": [1.1, 1.2, 1.3],
        "custom_property_9": ["Hello", "World"],
      },
    );
  }

  void dfinerySetSingleUserProfile() {
    Dfinery.setUserProfile(key: DFUserProfile.name, value: "Tester");
  }

  void dfinerySetMultipleUserProfiles() {
    Dfinery.setUserProfiles(
      values: {
        DFUserProfile.gender: "Female",
        DFUserProfile.birth: "1999-01-01",
        DFUserProfile.membership: "VIP",
        DFUserProfile.pushAdsOptin: true,
        DFUserProfile.smsAdsOptin: false,
        DFUserProfile.kakaoAdsOptin: true,
        DFUserProfile.pushNightAdsOptin: false,
        "custom_user_profile_1": 34000,
        "custom_user_profile_2": 42.195,
        "custom_user_profile_3": DateTime.now(),
        "custom_user_profile_4": [20, 30],
        "custom_user_profile_5": [1.1, 1.2],
        "custom_user_profile_6": ["Hello", "World"],
      },
    );
  }

  void dfinerySetSingleIdentity() {
    Dfinery.setIdentity(key: DFIdentity.externalId, value: "user_a1b2c3d4");
  }

  void dfinerySetMultpleIdentities() {
    Dfinery.setIdentities(
      values: {
        DFIdentity.email: "user@example.com",
        DFIdentity.phoneNo: "821012345678",
        DFIdentity.kakaoUserId: "kakao_u98765",
        DFIdentity.lineUserId: "line_i10293",
      },
    );
  }

  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      Dfinery.getPushToken().then((token) {
        if (token != null) {
          Dfinery.setPushToken(pushToken: token);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dfinery Sample')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('LogEvent'),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: dfineryLogin, child: const Text('Login')),
          ElevatedButton(
            onPressed: dfineryPurchase,
            child: const Text('Purchase'),
          ),
          ElevatedButton(
            onPressed: dfineryCustomEvent,
            child: const Text('CustomEvent'),
          ),
          const SizedBox(height: 24),
          const Text('UserProfile'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: dfinerySetSingleUserProfile,
            child: const Text('Set Single UserProfile'),
          ),
          ElevatedButton(
            onPressed: dfinerySetMultipleUserProfiles,
            child: const Text('Set Multiple UserProfiles'),
          ),
          const SizedBox(height: 24),
          const Text('Identity'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: dfinerySetSingleIdentity,
            child: const Text('Set Single Identity'),
          ),
          ElevatedButton(
            onPressed: dfinerySetMultipleUserProfiles,
            child: const Text('Set Multiple Identities'),
          ),
          const SizedBox(height: 24),
          const Text('PushPermission'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: requestNotificationPermission,
            child: const Text('Request Notification Permssion'),
          ),
        ],
      ),
    );
  }
}
