import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class BundleIdLaunch {
  static const MethodChannel _channel = MethodChannel('bundle_id_launch');

  /// 忽略
  // static Future<String?> get platformVersion async {
  //   final String? version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }
  /// 拉起某个应用 此方法只适用于android平台
  static Future<bool> launch({required String bundleId}) async {
    // if (!Platform.isIOS) return false;
    if (Platform.isIOS) return false;
    final bool res = await _channel.invokeMethod('launch',bundleId);
    return res;
  }
  static Future<bool> launchByUrlScheme({required String url}) async{
    if(await canLaunchUrl(Uri.parse(url))){
      return await launchUrl(Uri.parse(url));
    }
    return false;
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
