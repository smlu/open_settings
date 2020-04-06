import Flutter
import UIKit

public class SwiftOpenSettingPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "open_settings", binaryMessenger: registrar.messenger())
        let instance = SwiftOpenSettingPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "openSettings":
            #if swift(>=4.2)
            let url = URL(string: UIApplication.openSettingsURLString)
            #else
            let url = URL(string: UIApplicationOpenSettingsURLString)
            #endif
            if(url != nil){
                if (UIApplication.shared.canOpenURL(url!)) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    }
                    result(nil)
                }
            }
        default:
            result("iOS " + UIDevice.current.systemVersion)
        }
    }
}
