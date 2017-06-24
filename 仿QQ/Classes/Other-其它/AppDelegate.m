//
//  AppDelegate.m
//  仿QQ
//
//  Created by Edge on 2017/5/17.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "AppDelegate.h"
#import "EdgeRootTabBarViewController.h"
#import "EdgeLoginViewConViewController.h"
#import <SMS_SDK/SMSSDK.h>

#import "EdgeLeftSlideView.h"
#import "UIView+EdgeExpention.h"
#import "EdgeLeftSlideManager.h"
@interface AppDelegate ()

@end
static NSString *appKey = @"1e1b6fe5f8ced";
static NSString *appSecret = @"e25fa54a6c24d0d7adbc3615386defbf";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
//    EdgeLoginViewConViewController *loginIn = [[EdgeLoginViewConViewController alloc]init];
//    
//    if (loginIn.isLogin) {
//    
        [self addRootViewController];
        
//    }else{
//        
//        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginIn];
//        self.window.rootViewController = nav;
//        [self.window makeKeyAndVisible];
//        
//    }
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:appKey
             withSecret:appSecret];
    
    return YES;
}


-(void)addRootViewController{
    
     self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    
//    EdgeLeftSlideView *leftView = [[EdgeLeftSlideView alloc] initWithFrame:CGRectMake(-self.window.wdith * (1 - leftWidthScale), 0, self.window.wdith, self.window.height)];
//    
//   
//    EdgeRootTabBarViewController *tabbarVC = [[EdgeRootTabBarViewController alloc]init];
    
    EdgeLoginViewConViewController *rootViewController = [[EdgeLoginViewConViewController alloc]init];    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rootViewController];    self.window.rootViewController = nav;
    
//    [[EdgeLeftSlideManager instance]installMainViewController:tabbarVC leftView:leftView];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
