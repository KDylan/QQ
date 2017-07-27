//
//  EdgemoreViewController.m
//  仿QQ
//
//  Created by Edge on 2017/5/24.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgemoreViewController.h"
#import "EdgeLoginViewConViewController.h"

#import "EdgeRootViewController.h"
@interface EdgemoreViewController ()

@end

@implementation EdgemoreViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
      [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title = @"更多";
    
    NSLog(@"more-%@",self.navigationController.childViewControllers);
}
//  注销登录
- (IBAction)singOut:(id)sender {
  
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出当前用户" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //                            NSLog(@"点击取消");
                            }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user removeObjectForKey:@"isLogin"];
    
        //  执行退出操作登录
        
    //    EdgeLoginViewConViewController *revise =[[EdgeLoginViewConViewController alloc]init];
       
     //   self.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController popToRootViewControllerAnimated:NO];
      //  [self.navigationController pushViewController:revise animated:YES];
        //跳转隐藏tabbar
      //  self.hidesBottomBarWhenPushed = NO;

    }];
    
    [alert addAction:cancel];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
