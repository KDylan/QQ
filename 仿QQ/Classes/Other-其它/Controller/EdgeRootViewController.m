//
//  EdgeRootViewController.m
//  仿QQ
//
//  Created by comit on 2017/7/26.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeRootViewController.h"
#import "EdgeLoginViewConViewController.h"

#import "EdgeRootTabBarViewController.h"

@interface EdgeRootViewController ()

@end

@implementation EdgeRootViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    // 判断是否登录
    EdgeLoginViewConViewController *loginIn = [[EdgeLoginViewConViewController alloc]init];
    
        NSArray*documentArr =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSLog(@"%@",documentArr);

        NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
        loginIn.isLogin = [user objectForKey:@"isLogin"];
    
    if (!loginIn.isLogin) {
        
        [self.navigationController pushViewController:loginIn animated:NO];
    }else{
        
        EdgeRootTabBarViewController *RootTabbar = [[EdgeRootTabBarViewController alloc]init];
      
        // [endView.navigationController setNavigationBarHidden:YES];
        //self.navigationController.navigationBar.translucent = YES;
     //    [RootTabbar.navigationController.navigationItem setLeftBarButtonItem:nil];
        
        [self.navigationController pushViewController:RootTabbar animated:NO];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
 
}


@end
