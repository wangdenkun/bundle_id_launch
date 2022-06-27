package com.mushi.bundle_id_launch

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.Nullable

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.Exception

/** BundleIdLaunchPlugin */
class BundleIdLaunchPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var binding: FlutterPlugin.FlutterPluginBinding

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    binding = flutterPluginBinding
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "bundle_id_launch")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "launch" -> {
        val bundleId = call.arguments as String?
        bundleId?.let {
          val res = launchByBundleId(it)
          result.success(res)
        };
        result.success(false)
      }
      "openSystemSetting" -> {
        try {
          openSystemSetting()
          result.success(true)
        } catch (e: Exception) {
          result.success(false)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun launchByBundleId(@NonNull bundleId: String): Boolean{
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      val context = this.binding.applicationContext
      val startIntent = context.packageManager.getLaunchIntentForPackage(bundleId)
      if (startIntent != null){
        startIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startIntent.addFlags(Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT)
        startIntent.addCategory(Intent.CATEGORY_LAUNCHER)
        context.startActivity(startIntent)
        return true
      }else{
        return false
      }
    } else {
      return false
//            TODO("VERSION.SDK_INT < LOLLIPOP")
    }
  }
  private fun openSystemSetting(){
    val context = this.binding.applicationContext
    context.startActivity(Intent(android.provider.Settings.ACTION_SETTINGS));
  }
}
