//
//  UIView+EdgeExpention.h
//  百思不得姐
//
//  Created by Edge on 16/4/20.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EdgeExpention)
//X坐标
@property(assign,nonatomic) CGFloat x;
//Y坐标
@property(assign,nonatomic) CGFloat y;
//宽度
@property(assign,nonatomic) CGFloat wdith;
//高度
@property(assign,nonatomic) CGFloat height;
//尺寸
@property(assign,nonatomic) CGSize size;
//中心点X
@property(assign,nonatomic)CGFloat centerX;
//中心点Y
@property(assign,nonatomic)CGFloat centery;
//顶部
@property (nonatomic, assign) CGFloat top;
//底部
@property (nonatomic, assign) CGFloat bottom;
//  左边
@property (nonatomic, assign) CGFloat left;
//  右边
@property (nonatomic, assign) CGFloat right;
//  旋转
@property (nonatomic, assign) CGFloat tx;

@property (nonatomic, assign) CGFloat ty;


@end
