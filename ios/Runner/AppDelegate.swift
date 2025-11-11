import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //by default
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController
    let registrar = controller.registrar(forPlugin: "AppDelegatePlugin")

    // ✅ Register Battery and Charging channels
    BatteryChannelHandler.register(with: registrar!)
    ChargingEventHandler.register(with: registrar!)

    // ✅ Register Inline System Info channel (here only)
    let systemInfoChannel = FlutterMethodChannel(name: "samples.flutter.dev/systemInfo", binaryMessenger: controller.binaryMessenger)
    systemInfoChannel.setMethodCallHandler { call, result in
        switch call.method {
        case "getSystemInfo":
            let device = UIDevice.current
            let info: [String: String] = [
                "device": device.model,
                "systemName": device.systemName,
                "systemVersion": device.systemVersion
            ]
            result(info)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
