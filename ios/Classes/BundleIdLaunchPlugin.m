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
+ (BOOL)openApp:(NSString *)bundleId {
    // 获取私有类名
    NSString *classNameString = [[NSString alloc] initWithFormat:@"%@%@", @"LSApplicatio", @"nWorkspace"];
    NSObject * workspace = [NSClassFromString(classNameString) new];

    // 获取私有方法名
    NSString *selNameString = [[NSString alloc] initWithFormat:@"%@%@", @"openApplication", @"WithBundleID:"];
    SEL selector = NSSelectorFromString(selNameString);

    IMP imp = [workspace methodForSelector:selector];

    BOOL (*func)(id, SEL, NSString *) = (void *)imp;

    BOOL result = workspace ?
    func(workspace, selector, bundleId) : false;

    return result;
}
@end
