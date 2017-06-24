//
//  EdgeResiterTwoViewController.m
//  Login
//
//  Created by Edge on 2017/5/24.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeResiterTwoViewController.h"
#import "SVProgressHUD.h"
@interface EdgeResiterTwoViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *trgisterBun;

@end

@implementation EdgeResiterTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"注册2/2";
    _passward.delegate = self;
    _validationPassward.delegate = self;
    
    [_passward addTarget:self action:@selector(textChanged) forControlEvents:(UIControlEventEditingChanged)];
     [_validationPassward addTarget:self action:@selector(textChanged) forControlEvents:(UIControlEventEditingChanged)];
    
}
-(void)textChanged{
    
    if (_passward.text.length!=0||_validationPassward.text.length!=0) {
        [_trgisterBun setBackgroundColor:[UIColor blueColor]];
        _trgisterBun.enabled = YES;
    }
}
//  注册
- (IBAction)registerAction:(id)sender {
    
    if ([_passward.text isEqualToString:_validationPassward.text]) {
        
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [self dismissforOneSecond];
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            NSDictionary * dic = @{@"user":_userNumber,@"password":_validationPassward.text};
            [user setObject:dic forKey:@"login"];
//        //  传值
//        if (_retureTextName) {
//            
//            _retureTextName(_userNumber,_passward.text);
//        }
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
//
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
    [self.passward resignFirstResponder];
    [self.validationPassward resignFirstResponder];
    return YES;
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self.textSummary resignFirstResponder];
    [self.view endEditing:YES];
}

@end
