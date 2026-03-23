package com.example.plugin_practice

import android.content.Context
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PluginPracticePlugin: FlutterPlugin, MethodChannel.MethodCallHandler {

  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "plugin_practice")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

    // 🔋 Battery method
    if (call.method == "getBatteryLevel") {
      val batteryLevel = getBatteryLevel()

      if (batteryLevel != -1) {
        result.success(batteryLevel)
      } else {
        result.error("UNAVAILABLE", "Battery level not available.", null)
      }
    }

    else {
      result.notImplemented()
    }
  }

  // 🔥 Actual battery logic
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
  }
}