package com.example.platform_specific_code

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.util.Log
import io.flutter.plugin.common.EventChannel

class ChargingEventHandler(private val context: Context) : EventChannel.StreamHandler {

    companion object {
        const val CHANNEL_NAME = "samples.flutter.dev/charging"

        fun register(channel: EventChannel, context: Context) {
            val handler = ChargingEventHandler(context)
            channel.setStreamHandler(handler)
        }
    }

    private var chargingReceiver: BroadcastReceiver? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        chargingReceiver = createReceiver(events)
        context.registerReceiver(chargingReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        Log.d("ChargingEvent", "Charging listener registered.")
    }

    override fun onCancel(arguments: Any?) {
        if (chargingReceiver != null) {
            context.unregisterReceiver(chargingReceiver)
            chargingReceiver = null
            Log.d("ChargingEvent", "Charging listener unregistered.")
        }
    }

    private fun createReceiver(events: EventChannel.EventSink?): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
                val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                        status == BatteryManager.BATTERY_STATUS_FULL

                Log.d("ChargingEvent", "Battery charging changed: $isCharging")
                events?.success(if (isCharging) "charging" else "discharging")
            }
        }
    }
}
