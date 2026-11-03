# Dfinery Flutter SDK

![Pub Version](https://img.shields.io/pub/v/dfinery_plugin)

**Dfinery Flutter SDK** is the official plugin that enables Flutter applications to easily integrate Dfinery's powerful customer data analytics and marketing automation capabilities.

**DFINERY** makes customer data integration (CDP) and CRM campaign management easier and more efficient. This SDK allows you to seamlessly integrate these powerful features into your Flutter applications.

## Information

- [Dfinery User Guide](https://docs.dfinery.ai/user-guide)
- [Dfinery Developer Guide](https://docs.dfinery.ai/developer-guide/platform/flutter)

## Requirements

| Component | Version |
|-----------|---------|
| Dart SDK | ≥3.4.0 |
| Flutter SDK | ≥3.24.0 |

### Android

- Android SDK 4.4 / API 19
- Compile SDK Version 35

### iOS

- iOS 12.0
- Xcode 16.0

---

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  dfinery_plugin: ^2.0.0
```

Then run:

```bash
flutter pub get
```

---

## iOS Installation

### Swift Package Manager (Recommended)

SPM is the recommended dependency manager for iOS. Flutter 3.24.0+ supports SPM.

#### Enabling SPM

| Flutter Version | SPM Status |
|-----------------|------------|
| 3.24.0 ~ 3.43.x | Manual activation required |
| 3.44.0+ | Enabled by default |

**For Flutter 3.24.0 ~ 3.43.x:**

Run the following command to enable SPM:

```bash
flutter config --enable-swift-package-manager
```

After enabling SPM, rebuild your iOS project:

```bash
cd ios && rm -rf Pods Podfile.lock && cd ..
flutter clean
flutter pub get
flutter build ios
```

#### SPM Dependencies

The plugin automatically resolves the following SPM dependencies:

| Package | Version | Repository |
|---------|---------|------------|
| DfinerySDK | 2.6.0 | https://github.com/IGAWorksDev/dfinery-ios-sdk |

> **Note:** `DfinerySDKServiceExtension` is not included in the plugin. It must be added separately to your Notification Service Extension target. See [DfinerySDKServiceExtension Setup](#dfinerysdkserviceextension-setup) for details.

### CocoaPods (Legacy)

CocoaPods is supported for backward compatibility.

Ensure your `ios/Podfile` includes:

```ruby
platform :ios, '12.0'
```

Then install dependencies:

```bash
cd ios && pod install
```

---

## Migration Guide: CocoaPods to SPM

For existing projects using CocoaPods, follow these steps to migrate to SPM:

### Step 1: Update Flutter

Ensure Flutter version is 3.24.0 or higher:

```bash
flutter upgrade
flutter --version  # Verify version ≥3.24.0
```

### Step 2: Enable SPM (Flutter 3.24.0 ~ 3.43.x)

```bash
flutter config --enable-swift-package-manager
```

### Step 3: Clean CocoaPods Artifacts

```bash
cd ios
rm -rf Pods
rm -rf Podfile.lock
rm -rf .symlinks
cd ..
```

### Step 4: Clean and Rebuild

```bash
flutter clean
flutter pub get
flutter build ios
```

### Step 5: Verify Migration

Open the iOS project in Xcode and verify:

1. **Package Dependencies** section appears in the project navigator
2. `DfinerySDK` and `DfinerySDKServiceExtension` are listed under Package Dependencies
3. No CocoaPods-related errors in build logs

### Rollback to CocoaPods

If you need to revert to CocoaPods:

```bash
flutter config --no-enable-swift-package-manager
cd ios && pod install
flutter clean
flutter build ios
```

---

## DfinerySDKServiceExtension Setup

To enable rich push notifications with images and action buttons, configure the Notification Service Extension.

### Step 1: Add Notification Service Extension Target

1. Open your iOS project in Xcode (`ios/Runner.xcworkspace`)
2. **File → New → Target**
3. Select **Notification Service Extension**
4. Set Product Name (e.g., `NotificationServiceExtension`)
5. Set Minimum Deployment Target to **iOS 12.0**
6. Click **Finish**

### Step 2: Add DfinerySDKServiceExtension Dependency

#### For SPM Projects

1. Select the **Notification Service Extension target** in Xcode
2. Go to **General → Frameworks, Libraries, and Embedded Content**
3. Click **+** and add `DfinerySDKServiceExtension`

#### For CocoaPods Projects

Add to your `Podfile`:

```ruby
target 'NotificationServiceExtension' do
  use_frameworks!
  pod 'DfinerySDKServiceExtension', '2.6.0'
end
```

Then run:

```bash
cd ios && pod install
```

### Step 3: Implement NotificationService

Replace the contents of `NotificationService.swift` with:

```swift
import UserNotifications
import DfinerySDKServiceExtension

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
    ) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            DfineryNotificationServiceExtension.didReceive(request, with: bestAttemptContent) {
                contentHandler(bestAttemptContent)
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
```

### Step 4: Configure App Groups (Optional)

For shared data between main app and extension:

1. Select **Runner** target → **Signing & Capabilities** → **+ Capability** → **App Groups**
2. Add a group identifier (e.g., `group.com.yourcompany.yourapp`)
3. Repeat for **NotificationServiceExtension** target with the same group identifier

### Step 5: Build and Test

```bash
flutter build ios
```

Test push notifications with an image URL to verify the extension is working correctly.

---

## Troubleshooting

### SPM Resolution Fails

If SPM dependency resolution fails:

```bash
# Clear SPM cache
rm -rf ~/Library/Caches/org.swift.swiftpm
rm -rf ~/Library/Developer/Xcode/DerivedData

# Rebuild
flutter clean
flutter pub get
flutter build ios
```

### Duplicate Symbol Errors

If both SPM and CocoaPods are resolving dependencies:

```bash
# Ensure only one package manager is active
flutter config --enable-swift-package-manager  # OR
flutter config --no-enable-swift-package-manager

# Clean and rebuild
cd ios && rm -rf Pods Podfile.lock && cd ..
flutter clean
flutter build ios
```

### Flutter Version Constraint Error

If you see a version constraint error:

```
The current Flutter SDK version is X.X.X.
Because dfinery_plugin requires Flutter SDK version >=3.24.0
```

Upgrade Flutter:

```bash
flutter upgrade
```

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
