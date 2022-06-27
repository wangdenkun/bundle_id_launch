#import <Flutter/Flutter.h>

@interface BundleIdLaunchPlugin : NSObject<FlutterPlugin>
+ (BOOL)openApp:(NSString *)bundleId;
@end
