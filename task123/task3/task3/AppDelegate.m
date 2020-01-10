//
//  AppDelegate.m
//  task3
//
//  Created by tanxiaoyan on 2019/12/31.
//  Copyright © 2019 tanxiaoyan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
       // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    ViewController *rootVc = [[ViewController alloc]init];
    UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:rootVc];
    rootVc.view.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:rootNav];
    [self.window makeKeyAndVisible];
    return YES;
}






@end
