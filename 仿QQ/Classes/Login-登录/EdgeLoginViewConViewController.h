//
//  EdgeLoginViewConViewController.h
//  Login
//
//  Created by Edge on 17/5/23.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EdgeLoginViewConViewController : UIViewController
//账户名
@property (strong, nonatomic) IBOutlet UITextField *userName;
// 用户密码
@property (strong, nonatomic) IBOutlet UITextField *userPassward;
//  头镖View
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@property(assign,nonatomic,getter=isLogin)BOOL isLogin;

@end
