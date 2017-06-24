//
//  modelFream.h
//  自动回复
//
//  Created by Edge on 2017/5/28.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class dataModel;
@interface modelFream : NSObject
/** 时间的Frame */
@property (nonatomic,assign)CGRect timeFrame;
/** 头像的Frame */
@property (nonatomic,assign)CGRect headImageFrame;
/** 按钮(内容)的Frame */
@property (nonatomic,assign)CGRect btnFrame;
/** 是否是自己发送的信息 */
@property (nonatomic,assign)BOOL myself;
/** cell的高度 */
@property (nonatomic,assign)CGFloat cellHeight;
/** 模型数据 */
@property (nonatomic,strong)dataModel *dataModel;

-(instancetype)initWithFreamModel:(dataModel *)modelData timeIsEqual:(BOOL)timeBool;

+(instancetype)modelFrame:(dataModel *)modelData timeIsEqual:(BOOL)timeBool;
@end
