#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    NSError *error;
//    [NSFileManager.defaultManager removeItemAtPath:[NSString stringWithFormat:@"%@/Library/SplashBoard",NSHomeDirectory()] error:&error];
//    if (error) {
//        NSLog(@"Failed : %@",error);
//    }
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSString *)gainLibraryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

@end
