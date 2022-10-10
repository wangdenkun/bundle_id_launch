import Flutter
import UIKit

public class SwiftBundleIdLaunchPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "bundle_id_launch", binaryMessenger: registrar.messenger())
    let instance = SwiftBundleIdLaunchPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if (call.method == "getPlatformVersion"){
          result("iOS " + UIDevice.current.systemVersion)
      }else if (call.method == "launch"){
          result(false);
      }else if (call.method == "openSystemSetting"){
          guard let url = URL(string: UIApplication.openSettingsURLString) else {
              result(false)
              return
          }
          
          if #available(iOS 10.0, *) {
              UIApplication.shared.open(url, options: [:]){ res in
                  result(res)
              }
          } else {
              let res = UIApplication.shared.openURL(url)
              result(res)
          }
      }else{
          result(false)
      }
  }
}
