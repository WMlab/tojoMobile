//
//  AppDelegate.m
//  TojoMobile
//
//  Created by 纪鹏 on 15/1/5.
//  Copyright (c) 2015年 Tongjo. All rights reserved.
//

#import "AppDelegate.h"
#import "TJDefine.h"
#import "TJDataBase.h"
#import "TJUserSender.h"
#import <EaseMob.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UITabBar appearance] setTintColor:TJColorHex(0x1ec399)];
    
    //初始化缓存数据库
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self initDatabase];
    });
    //启动App，登陆
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self getUserLoginInfo];
    });
    
    //registerSDKWithAppKey:注册的appKey, apnsCertName:推送证书名(不需要加后缀)
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"tongjo#tongjo" apnsCertName:@"tongjomobile"];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

-(void)initDatabase{
    [[TJDataBase getInstance] initDatabase];
}

-(void)getUserLoginInfo {
    NSUserDefaults * usrDefault = [NSUserDefaults standardUserDefaults];
    NSString * usr = [usrDefault objectForKey:@"usr"];
    NSString * pwd = [usrDefault objectForKey:@"pwd"];
    if ([usr length] > 0 && [pwd length] > 0) {
        [[TJUserSender getInstance] sendUserLoginWithEmail:usr password:pwd completeBlock:^(BOOL success, NSString *message) {
            
        }];
    }
    
}

@end
