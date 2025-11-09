package com.example.platform_specific_code

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val SYSTEM_INFO_CHANNEL = "samples.flutter.dev/systemInfo"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // ✅ 1️⃣ Register MethodChannel handler (Battery)
        val batteryChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            BatteryChannelHandler.CHANNEL_NAME
        )
        BatteryChannelHandler.register(batteryChannel, this)

        // ✅ 2️⃣ Register EventChannel handler (Charging)
        val chargingChannel = EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            ChargingEventHandler.CHANNEL_NAME
        )
        ChargingEventHandler.register(chargingChannel, this)

        //  one more MethodChannel implemented directly here
        val systemInfoChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            SYSTEM_INFO_CHANNEL
        )

        systemInfoChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getSystemInfo" -> {
                    val info = mapOf(
                        "device" to Build.MODEL,
                        "manufacturer" to Build.MANUFACTURER,
                        "androidVersion" to Build.VERSION.RELEASE
                    )
                    result.success(info)
                }
                else -> result.notImplemented()
            }
        }
    }
}
