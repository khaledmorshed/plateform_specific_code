package com.example.platform_specific_code

import android.content.*
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import android.util.Log

class MainActivity : FlutterActivity() {
    private val CHARGING_CHANNEL = "samples.flutter.dev/charging"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.d("MyAppLog", "Flutter Engine configured!")
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHARGING_CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {
                    private var chargingStateChangeReceiver: BroadcastReceiver? = null

                    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                        chargingStateChangeReceiver = createChargingStateChangeReceiver(events)
                        registerReceiver(chargingStateChangeReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                    }

                    override fun onCancel(arguments: Any?) {
                        unregisterReceiver(chargingStateChangeReceiver)
                        chargingStateChangeReceiver = null
                    }
                }
            )
    }

    private fun createChargingStateChangeReceiver(events: EventChannel.EventSink?): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
                Log.d("BatteryReceiver", "Battery status changed: $status")
                val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                        status == BatteryManager.BATTERY_STATUS_FULL
                events?.success(if (isCharging) "charging" else "discharging")
            }
        }
    }
}