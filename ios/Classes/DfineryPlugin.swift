import Flutter
import UIKit
@_spi(Pendable)import DfinerySDK

public class DfineryPlugin: NSObject, FlutterPlugin {
    
    private var deviceToken: Data? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "dfinery_plugin", binaryMessenger: registrar.messenger())
        let instance = DfineryPlugin()
        
        registrar.addApplicationDelegate(instance)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        application.registerForRemoteNotifications()
        
        Dfinery.shared().pend()
        
        return true
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if Dfinery.shared().canHandleNotification(response: response) {
            completionHandler()
        }
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if Dfinery.shared().canHandleForeground(notification, completionHandler: completionHandler) {
            return
        }
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.deviceToken = deviceToken
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "init":
            handleInit(call, result: result)

        case "initWithConfig":
            handleInitWithConfig(call, result: result)

        case "logEvent":
            handleLogEvent(call, result: result)

        case "setUserProfile":
            handleSetUserProfile(call, result: result)

        case "setUserProfiles":
            handleSetUserProfiles(call, result: result)

        case "setIdentity":
            handleSetIdentity(call, result: result)

        case "setIdentities":
            handleSetIdentities(call, result: result)

        case "resetIdentity":
            handleResetIdentity(result: result)

        case "setPushToken":
            handleSetPushToken(call, result: result)

        case "getPushToken":
            handleGetPushToken(result: result)

        case "enableSDK":
            handleEnableSDK(result: result)

        case "disableSDK":
            handleDisableSDK(result: result)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func handleInit(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let serviceId = args["serviceId"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "ServiceId is required", details: nil))
            return
        }
        
        Dfinery.shared().sdkInit(serviceId: serviceId)
        
        result(nil)
    }

    private func handleInitWithConfig(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let serviceId = args["serviceId"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "ServiceId is required", details: nil))
            return
        }
        let config = args["config"] as? [String: Any]
        
        Dfinery.shared().sdkInit(serviceId: serviceId, config: config ?? [:])
        
        result(nil)
    }

    private func handleLogEvent(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let eventName = args["eventName"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "EventName is required", details: nil))
            return
        }
        let properties = args["properties"] as? [String: Any]
        
        Dfinery.shared().logEvent(name: eventName, properties: properties ?? [:])
        
        result(nil)
    }


    private func handleSetUserProfile(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let key = args["key"] as? String,
              let value = args["value"] else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key and Value are required", details: nil))
            return
        }
        
        Dfinery.shared().setUserProfile(key: key, value: value)
        result(nil)
    }

    private func handleSetUserProfiles(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let values = args["values"] as? [String: Any] else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Values are required", details: nil))
            return
        }
        
        Dfinery.shared().set(userProfiles: values)
        result(nil)
    }

    private func handleSetIdentity(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let key = args["key"] as? String,
              let value = args["value"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Key and Value are required", details: nil))
            return
        }
        
        Dfinery.shared().setIdentity(key: key, value: value)
        result(nil)
    }

    private func handleSetIdentities(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let values = args["values"] as? [String: String] else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Values are required", details: nil))
            return
        }
        
        Dfinery.shared().set(identities: values)
        result(nil)
    }

    private func handleResetIdentity(result: @escaping FlutterResult) {
        Dfinery.shared().resetIdentity()
        result(nil)
    }

    private func handleSetPushToken(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let pushToken = args["pushToken"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "PushToken is required", details: nil))
            return
        }
        
        var data = Data()
        var tempString = ""

        for (index, char) in pushToken.enumerated() {
            tempString.append(char)
            if index % 2 != 0 {
                let byte = UInt8(tempString, radix: 16)
                data.append(byte!)
                tempString = ""
            }
        }
        
        if data.isEmpty,
           let token = deviceToken {
            Dfinery.shared().set(pushToken: token)
        } else {
            Dfinery.shared().set(pushToken: data)
        }
            
        result(nil)
    }

    private func handleGetPushToken(result: @escaping FlutterResult) {
        guard let deviceToken = self.deviceToken else {
            result(nil)
            return
        }
        let pushToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()

        result(pushToken)
    }

    private func handleEnableSDK(result: @escaping FlutterResult) {
        Dfinery.shared().enableSDK()
        result(nil)
    }

    private func handleDisableSDK(result: @escaping FlutterResult) {
        Dfinery.shared().disableSDK()
        result(nil)
    }
}
