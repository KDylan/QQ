//
//  UIImage+EdgeImage.h
//  仿QQ
//
//  Created by Edge on 2017/5/18.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EdgeImage)
/**
 *  保持图片不渲染
 */
@property(nonatomic,strong,readonly)UIImage *originalImage;
// 保持图片不渲染
+(UIImage *)imageOriginalImaged:(NSString *)imageName;
@end
