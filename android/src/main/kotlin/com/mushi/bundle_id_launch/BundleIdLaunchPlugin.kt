package com.mushi.bundle_id_launch

import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** BundleIdLaunchPlugin */
class BundleIdLaunchPlugin: FlutterPlugin, MethodCallHandler {
  private val TAG: String = "BundleIdLaunchPlugin"

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
//      "getPlatformVersion" -> {
//        result.success("Android ${android.os.Build.VERSION.RELEASE}")
//      }
      "launch" -> {
        val bundleId = call.arguments as String?
        if (bundleId != null){
          val res = launchByBundleId(bundleId)
          result.success(res)
        }else{
          result.success(false)
        }
      }
      "openSystemSetting" -> {
        try {
          openSystemSetting()
          result.success(true)
        } catch (e: Exception) {
          result.success(false)
        }
      }
      "hasInstall" -> {
        try{
          val bundleID: String? = call.argument<String>("bundleId");
          if (bundleID != null){
            result.success(hasInstall(bundleID))
          }else{
            result.success(false)
          }
        }catch (e: Exception){
          result.success(false)
        }
      }
      else -> {
        result.notImplemented()
        return
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
    }
  }
  private fun openSystemSetting(){
    val context = this.binding.applicationContext
    val settingsIntent = Intent()
    settingsIntent.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
    settingsIntent.addCategory(Intent.CATEGORY_DEFAULT)
    settingsIntent.data = Uri.parse("package:" + context.packageName)
    settingsIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    settingsIntent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY)
    settingsIntent.addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS)
    context.startActivity(settingsIntent)
  }
  /// https://blog.csdn.net/yufumatou/article/details/101277235
  private fun hasInstall(bundleId: String): Boolean {
    val packageManager: PackageManager = this.binding.applicationContext.packageManager;
    return try {
      packageManager.getPackageInfo(bundleId, 0)
      true
    } catch (e: PackageManager.NameNotFoundException) {
      false
    }
  }
}
