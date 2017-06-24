//
//  UIImage+EdgeImage.m
//  仿QQ
//
//  Created by Edge on 2017/5/18.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "UIImage+EdgeImage.h"

@implementation UIImage (EdgeImage)
-(UIImage *)originalImage{
    return [self imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
}
+(UIImage *)imageOriginalImaged:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    return image;
}
@end
