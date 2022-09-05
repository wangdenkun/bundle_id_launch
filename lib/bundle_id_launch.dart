import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';

class BundleIdLaunch {
  static const MethodChannel _channel = MethodChannel('bundle_id_launch');

  /// 忽略
  // static Future<String?> get platformVersion async {
  //   final String? version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }
  /// 拉起某个应用
  static Future<bool> launch({required String bundleId}) async {
    // if (!Platform.isIOS) return false;
    final bool res = await _channel.invokeMethod('launch',bundleId);
    return res;
  }
  /// 打开系统设置
  /// android 打开关于应用的系统设置
  /// iOS 打开系统设置首页
  static Future<bool> openSystemSetting() async{
    // if (!Platform.isIOS) return false;
    final bool res = await _channel.invokeMethod('openSystemSetting','');
    return res;
  }
  /// 是否已安装某个软件 目前只兼容android
  static Future<bool> hasInstall({required String bundleId}) async{
    if (Platform.isIOS) return true;
    final bool res = await _channel.invokeMethod('hasInstall',{'bundleId':bundleId});
    return res;
  }
}
