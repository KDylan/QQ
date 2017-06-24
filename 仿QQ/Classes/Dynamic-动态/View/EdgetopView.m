//
//  EdgetopView.m
//  仿QQ
//
//  Created by Edge on 2017/5/18.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgetopView.h"

@implementation EdgetopView

+(instancetype)loadTopViewXib{
    
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
- (void)awakeFromNib {
    [super awakeFromNib];
     self.autoresizingMask = UIViewAutoresizingNone;
}
//  好友
- (IBAction)dynamicAction:(id)sender {
    NSLog(@"%s",__func__);
}
//  附近
- (IBAction)nearAction:(id)sender {
    NSLog(@"%s",__func__);
}
//  兴趣
- (IBAction)interstAction:(id)sender {
    NSLog(@"%s",__func__);
}

@end
