//
//  UIBarButtonItem+EdgeExention.h
//  百思不得姐
//
//  Created by Edge on 2017/4/22.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (EdgeExention)
+(instancetype)iteamWithImageNamed:(NSString *)imageName hightLightImageName:(NSString *)hightNamed target:(id)target action:(SEL)action;

+(instancetype)iteamWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
