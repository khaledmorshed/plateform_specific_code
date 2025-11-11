import Flutter
import UIKit

class ChargingEventHandler: NSObject, FlutterStreamHandler {
    static let CHANNEL_NAME = "samples.flutter.dev/charging"
    private var eventSink: FlutterEventSink?

    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterEventChannel(name: CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let instance = ChargingEventHandler()
        channel.setStreamHandler(instance)
    }

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self,  selector: #selector(batteryStateDidChange), name: UIDevice.batteryStateDidChangeNotification, object: nil)
        sendBatteryState()
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        NotificationCenter.default.removeObserver(self)
        eventSink = nil
        return nil
    }

    @objc private func batteryStateDidChange() {
        sendBatteryState()
    }

    private func sendBatteryState() {
        guard let sink = eventSink else { return }
        let state = UIDevice.current.batteryState
        switch state {
        case .charging, .full:
            sink("charging")
        default:
            sink("discharging")
        }
    }
}
