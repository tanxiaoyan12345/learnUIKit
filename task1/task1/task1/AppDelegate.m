//
//  AppDelegate.m
//  task1
//
//  Created by tanxiaoyan on 2019/12/16.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "RootNavigationViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 MARK:@ydhz
    1. 新建类遵循苹果命名规范，三个大写字母前缀
    2. 编码规范通篇参考
        Standard https://github.com/raywenderlich/objective-c-style-guide/blob/master/README.md
               https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html
        Maya https://bytedance.feishu.cn/docs/2BsP1ElLe1dy7ILFcckmig
 */


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    RootViewController *rootVc = [[RootViewController alloc]init];
    rootVc.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:rootVc];
    [self.window setRootViewController:rootNav];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground");
 
}
 
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
 
}
 
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
 
}
 
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
 
}
/**
 MARK:@ydhz iOS 13系统同时实现上、下这些方法会黑屏
 TODO:@txy 了解UISceneDelegate的原理
 */

//#pragma mark - UISceneSession lifecycle
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
