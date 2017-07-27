//
//  EdgeResiterTwoViewController.h
//  Login
//
//  Created by Edge on 2017/5/24.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^RetureTextName) (NSString *userNumber,NSString *password);
@interface EdgeResiterTwoViewController : UIViewController
// 密码
@property (weak, nonatomic) IBOutlet UITextField *passward;
//  验证密码
@property (weak, nonatomic) IBOutlet UITextField *validationPassward;
//  用户号码
@property(strong,nonatomic)NSString *userNumber;

//@property(nonatomic,copy)RetureTextName retureTextName;

@end
