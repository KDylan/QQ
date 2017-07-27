//
//  EdgeChatViewController.h
//  自动回复
//
//  Created by Edge on 2017/5/28.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EdgeChatViewController : UIViewController
/**
 *  tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *customTableView;
/**
 *  输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *inputMess;
/**
 *  背景颜色
 */
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewH;

/**
 *  聊天人名字
 */
@property(strong,nonatomic)NSString *chatName;
@end
