//
//  UIView+EdgeExpention.m
//  百思不得姐
//
//  Created by Edge on 16/4/20.
//  Copyright © 2016年 Edge. All rights reserved.
//

#import "UIView+EdgeExpention.h"

@implementation UIView (EdgeExpention)
// get和set方法获取frame
-(CGFloat)x
{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y
{
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)wdith
{
    return  self.frame.size.width;
}
-(void)setWdith:(CGFloat)wdith{
    CGRect frame =self.frame;
    frame.size.width = wdith;
    self.frame=frame;
}

-(CGFloat)height
{
    return  self.frame.size.height;
}
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGSize)size{
    return  self.frame.size;
}
-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGFloat)centerX
{
    return self.center.x;
}
-(CGFloat)centery
{
    return self.center.y;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(void)setCentery:(CGFloat)centery{
    CGPoint center = self.center;
    center.y = centery;
    self.center = center;
}
-(CGFloat)top{
    return self.frame.origin.y;
}
-(void)setTop:(CGFloat)top{
    
   self.frame = CGRectMake(self.left, top, self.wdith, self.height);
}
- (void)setBottom:(CGFloat)b {
    self.frame = CGRectMake(self.left, b - self.height, self.wdith, self.height);
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLeft:(CGFloat)l {
    self.frame = CGRectMake(l, self.top, self.wdith, self.height);
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)r {
    self.frame = CGRectMake(r - self.wdith, self.top, self.wdith, self.height);
}

- (CGFloat)right {
    
    return self.frame.origin.x + self.frame.size.width;
}
- (CGFloat)tx {
    return self.transform.tx;
}

- (void)setTx:(CGFloat)tx {
    CGAffineTransform transform = self.transform;
    transform.tx = tx;
    self.transform = transform;
}

- (CGFloat)ty {
    return self.transform.ty;
}

- (void)setTy:(CGFloat)ty {
    CGAffineTransform transform = self.transform;
    transform.ty = ty;
    self.transform = transform;
}

@end
