package com.example.plugin_practice

import android.content.Context
import android.content.Intent
import android.os.BatteryManager
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.*
import kotlin.concurrent.fixedRateTimer
import android.os.Handler
import android.os.Looper

class PluginPracticePlugin: FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private var timeEventChannel: EventChannel? = null
    private var timeStreamHandler: TimeStreamHandler? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext

        // MethodChannel
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "plugin_practice")
        channel.setMethodCallHandler(this)

        // EventChannel for time
        timeEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "plugin_practice/timeStream")
        timeStreamHandler = TimeStreamHandler()
        timeEventChannel?.setStreamHandler(timeStreamHandler)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {

            // 🔋 Get Battery Level
            "getBatteryLevel" -> {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            }

            // 💡 Enable Battery Saver (opens settings page)
            "enableBatterySaver" -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                    val intent = Intent(Settings.ACTION_BATTERY_SAVER_SETTINGS)
                    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    context.startActivity(intent)
                    result.success(null)
                } else {
                    result.error("UNAVAILABLE", "Battery saver not supported on this device.", null)
                }
            }

            else -> result.notImplemented()
        }
    }

    private fun getBatteryLevel(): Int {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            -1
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        timeEventChannel?.setStreamHandler(null)
    }

    // -----------------------------
    // EventChannel StreamHandler
    // -----------------------------
    inner class TimeStreamHandler : EventChannel.StreamHandler {

        private var timer: Timer? = null
        private val mainHandler = Handler(Looper.getMainLooper()) // <--- Main thread handler

        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
            timer = fixedRateTimer("timeTimer", true, 0L, 1000L) {
                val sdf = SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault())
                val currentTime = sdf.format(Date())

                // Post to main thread to avoid crash
                mainHandler.post {
                    events?.success(currentTime)
                }
            }
        }

        override fun onCancel(arguments: Any?) {
            timer?.cancel()
            timer = null
        }
    }
}