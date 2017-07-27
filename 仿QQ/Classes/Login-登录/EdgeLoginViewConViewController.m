//
//  EdgeLoginViewConViewController.m
//  Login
//
//  Created by Edge on 17/5/23.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeLoginViewConViewController.h"
#import "EdgeRootTabBarViewController.h"
#import "EdgeForgetPasswardViewController.h"
#import "EdgeRegisteredViewController.h"
#import "EdgeInfomationViewController.h"
@interface EdgeLoginViewConViewController ()<UITextFieldDelegate>



@end

@implementation EdgeLoginViewConViewController

-(void)viewWillAppear:(BOOL)animated{
   
    [super viewWillAppear:animated];
    
    [self.navigationItem setHidesBackButton:YES];
    
   // self.navigationController.view.backgroundColor = [UIColor redColor];
    
   // [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userName.delegate = self;
    self.userPassward.delegate = self;
    NSLog(@"%@", self.navigationController.childViewControllers);

  //  self.title = @"login";
    
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = _iconImageView.frame.size.width/2;
}
//  登录
- (IBAction)LoginInAction:(UIButton *)sender {
   // NSLog(@"登录");
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
  
    NSDictionary *dic = [user objectForKey:@"login"];
 
    NSLog(@"%@-%@",dic[@"user"],dic[@"password"]);
   
    NSLog(@"%@-%@",_userName.text,_userPassward.text);
    
    if ([_userName.text isEqualToString: dic[@"user"]]&&[_userPassward.text isEqualToString: dic[@"password"]]){
    
      //  if (_userName.text==dic[@"user"]&&_userPassward.text==dic[@"password"])
        [sender setTitle:@"登录中..." forState:UIControlStateNormal];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            EdgeRootTabBarViewController *endView = [[EdgeRootTabBarViewController alloc]init];
        
            [user setBool:YES forKey:@"isLogin"];
        
            [self.navigationController pushViewController:endView animated:NO];
           // [endView.navigationController setNavigationBarHidden:YES];
            //self.navigationController.navigationBar.translucent = YES;
          //  [endView.navigationController.navigationItem setLeftBarButtonItem:nil];
              [sender setTitle:@"登录" forState:UIControlStateNormal];
        });
    }else{
        //验证成功后的回调；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"账号或密码错误" preferredStyle:UIAlertControllerStyleAlert];
        //                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //                            NSLog(@"点击取消");
        //                        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //       [alert addAction:cancel];
        [alert addAction:sure];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

//  注册
- (IBAction)registeredAction:(id)sender {
   // NSLog(@"注册");
    EdgeRegisteredViewController *registerVC = [[EdgeRegisteredViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
 }

//  忘记密码
- (IBAction)forgetPasswardAction:(id)sender {
  //  NSLog(@"忘记密码");
    
    EdgeForgetPasswardViewController *endView = [[EdgeForgetPasswardViewController alloc]init];
    
    [self.navigationController pushViewController:endView animated:YES];
}

-(void)dismissforOneSecond{
    //  1s后消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}
/**
 *手机号码验证
 */
+ (BOOL)validateMobile:(NSString *)mobile
{
    if (mobile.length != 11) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|6|7|8|9][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
#pragma mark -
#pragma mark 当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.userName resignFirstResponder];
    [self.userPassward resignFirstResponder];
    return YES;
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.textSummary resignFirstResponder];
    [self.view endEditing:YES];
}
@end
