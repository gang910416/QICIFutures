//
//  AppDelegate.m
//  LiveOfBeiJing
//
//  Created by Bingo on 2018/11/19.
//

#import "AppDelegate.h"
#import "UIMainConstructor.h"
#import "MainLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *tabBarController = [[UIMainConstructor sharedUIConstructor] constructUI];
    self.window.rootViewController = tabBarController;

    [self.window makeKeyAndVisible];



    return YES;

}


@end
