import Flutter
import UIKit

class BatteryChannelHandler {
    static let CHANNEL_NAME = "samples.flutter.dev/battery"

    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let instance = BatteryChannelHandler()
        channel.setMethodCallHandler(instance.handle)
    }

    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getBatteryLevel":
            UIDevice.current.isBatteryMonitoringEnabled = true
            let level = Int(UIDevice.current.batteryLevel * 100)
            if level < 0 {
                result(FlutterError(code: "UNAVAILABLE", message: "Battery info unavailable", details: nil))
            } else {
                result(level)
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
