//
//  EdgeEditContactController.h
//  仿QQ
//
//  Created by Edge on 17/5/21.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^retureText)(NSString *FiledText);

@class EdgeGroup;
@interface EdgeEditContactController : UIViewController
//@property(nonatomic,strong)EdgeGroup *groups;
/** 接收传过来的 分组模型对象 数组 */
@property (nonatomic, strong) NSMutableArray *groupModelArr;
@property (nonatomic, strong) NSMutableArray *contactModelArr;
@property(nonatomic,copy)retureText returnText;
@end
