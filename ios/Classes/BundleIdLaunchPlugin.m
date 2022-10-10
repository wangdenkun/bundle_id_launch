#import "BundleIdLaunchPlugin.h"
#if __has_include(<bundle_id_launch/bundle_id_launch-Swift.h>)
#import <bundle_id_launch/bundle_id_launch-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bundle_id_launch-Swift.h"
#endif

@implementation BundleIdLaunchPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBundleIdLaunchPlugin registerWithRegistrar:registrar];
}
@end
