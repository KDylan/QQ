//
//  EdgeRegisteredViewController.m
//  Login
//
//  Created by Edge on 17/5/24.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeRegisteredViewController.h"
#import "EdgeResiterTwoViewController.h"

#import <SMS_SDK/SMSSDK.h>
@interface EdgeRegisteredViewController ()<UITextFieldDelegate>
//  获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property(assign, nonatomic) NSInteger timeCount;

@end

@implementation EdgeRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberText.delegate = self;
    self.Verification_code.delegate = self;
   self.navigationItem.title = @"注册1/2";
   
}
//  获取验证码
- (IBAction)getMSMCode:(UIButton *)sender {
    //  输入手机号正确
    if ([self validateMobile:self.numberText.text]) {
        
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.numberText.text zone:@"86" customIdentifier:nil result:^(NSError *error){
        
    if (!error) {
        
            _getCodeBtn.enabled = NO;
            self.timeCount = 60;
        
    [_getCodeBtn setTitle:@"60秒" forState:UIControlStateDisabled];
       
    [_getCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reduceTime:) userInfo:nil repeats:YES];
        
                NSLog(@"获取验证码成功");
                //发送验证码成功的回调；
            } else {
                //发送验证码失败的回调；如果你输入错误的手机号码或者任意数字，就会回调；
                [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
                [self dismissforOneSecond];
            }
        }];
    }

}
//  时间递减
- (void)reduceTime:(NSTimer *)codeTimer {
    
    if (_timeCount!=1) {
        _timeCount-=1;
       
      [_getCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒",_timeCount] forState:UIControlStateDisabled];

    } else {
        [codeTimer invalidate];
        _getCodeBtn.enabled = YES;

        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}
//  下一步
- (IBAction)nextStepAction:(id)sender {
    if ([_Verification_code.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入验证码"];
        [self dismissforOneSecond];
        //  return;
    }else{
        [self pushMessage];
    }
}
-(void)pushMessage{
    [SMSSDK commitVerificationCode:_Verification_code.text phoneNumber:_numberText.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        if (!error) {
            NSLog(@"验证成功");

    EdgeResiterTwoViewController *tworegister = [[EdgeResiterTwoViewController alloc]init];
            tworegister.userNumber = self.numberText.text;
    [self.navigationController pushViewController:tworegister animated:YES];
            
        } else {
            
                        //验证成功后的回调；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"验证码错误" preferredStyle:UIAlertControllerStyleAlert];
            
                        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            NSLog(@"点击确定");
                        }];
                 //       [alert addAction:cancel];
                        [alert addAction:sure];
                        [self presentViewController:alert animated:YES completion:nil];

            //验证失败后的回调；
            NSLog(@"验证失败");
        }
    }];
}

//手机号码验证
- (BOOL)validateMobile:(NSString *)mobile
{
    if (mobile.length != 11) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        [self dismissforOneSecond];
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
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
    [self.numberText resignFirstResponder];
    [self.Verification_code resignFirstResponder];
    return YES;
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.textSummary resignFirstResponder];
    [self.view endEditing:YES];
}

@end
