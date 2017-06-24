//
//  EdgeForgetPassTWOViewController.m
//  Login
//
//  Created by Edge on 2017/5/24.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeForgetPassTWOViewController.h"

@interface EdgeForgetPassTWOViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *changePassword;
@property (weak, nonatomic) IBOutlet UITextField *changeTwoPassward;

@end

@implementation EdgeForgetPassTWOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.changePassword.delegate = self;
    self.changeTwoPassward.delegate = self;
    self.navigationItem.title = @"忘记密码2/2";
  //  NSLog(@"%@",self.userNumber);
}
// 确定
- (IBAction)changeSucress:(id)sender {
    if ([_changePassword.text isEqualToString:_changeTwoPassward.text]) {
        
        [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
        [self dismissforOneSecond];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSDictionary * dic = @{@"user":_userNumber,@"password":_changeTwoPassward.text};
        [user setObject:dic forKey:@"login"];
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
        
    }else{
        
        //验证成功后的回调；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码不一致" message:@"请重新输入" preferredStyle:UIAlertControllerStyleAlert];
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
-(void)dismissforOneSecond{
    //  1s后消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}
#pragma mark -
#pragma mark 当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.changePassword resignFirstResponder];
    [self.changeTwoPassward resignFirstResponder];
    return YES;
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.textSummary resignFirstResponder];
    [self.view endEditing:YES];
}


@end
