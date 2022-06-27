import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';

class BundleIdLaunch {
  static const MethodChannel _channel = MethodChannel('bundle_id_launch');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future<bool> launch({required String bundleId}) async {
    // if (!Platform.isIOS) return false;
    final bool res = await _channel.invokeMethod('launch',bundleId);
    return res;
  }
  static Future<bool> openSystemSetting() async{
    // if (!Platform.isIOS) return false;
    final bool res = await _channel.invokeMethod('openSystemSetting','');
    return res;
  }
}
