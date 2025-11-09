package com.example.platform_specific_code

import android.content.Context
import android.os.BatteryManager
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class BatteryChannelHandler(private val context: Context) : MethodChannel.MethodCallHandler {

    companion object {
        const val CHANNEL_NAME = "samples.flutter.dev/battery"

        fun register(channel: MethodChannel, context: Context) {
            val handler = BatteryChannelHandler(context)
            channel.setMethodCallHandler(handler)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getBatteryLevel" -> {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            }

            else -> result.notImplemented()
        }
    }

    private fun getBatteryLevel(): Int {
        return try {
            val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            val batteryLevel =
                batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
            Log.d("BatteryChannel", "Battery level: $batteryLevel%")
            batteryLevel
        } catch (e: Exception) {
            Log.e("BatteryChannel", "Error getting battery level", e)
            -1
        }
    }
}
