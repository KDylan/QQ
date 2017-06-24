//
//  EdgeLeftSlideManager.h
//  侧边栏
//
//  Created by Edge on 2017/5/30.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EdgeManagerShowType) {
    EdgeManagerShowLeft = 0, // 动画显示
    EdgeManagerShowCenter = 1,
    EdgeManagerShowLeftWithoutAnimation = 2, // 不带有动画显示
    EdgeManagerShowCenterWithoutAnimation = 3,
};
/**
 *  侧边栏显示这个屏幕的比例
 */
static CGFloat const leftWidthScale = 0.75;

@interface EdgeLeftSlideManager : NSObject
//主视图
@property (nonatomic, weak) UIViewController *mainViewController;
//  侧边显示View
@property (nonatomic, weak) UIView *leftView;


/**
 *  单例
 */
+(instancetype)instance;
/**
 *  设置主视图和左侧视图
 *
 *  @param VC       主控制器
 *  @param leftView 左侧视图
 */
-(void)installMainViewController:(UIViewController *)VC leftView:(UIView *)leftView;
/**
 *  隐藏侧边阴影
 */
-(void)hiddenShadow;
/**
 *  显示侧边阴影
 */
-(void)showShadow;
/**
 *  开启拖拽事件
 */
-(void)beginGragRespanse;
/**
 *  关闭拖拽事件
 */
-(void)cancelDrawReponse;
/**
 *  显示状态
 *
 *  @param shouType 枚举类型；选择显示状态
 */
-(void)resetShowType:(EdgeManagerShowType)shouType;
@end
