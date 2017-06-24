//
//  EdgeLeftSlideManager.m
//  侧边栏
//
//  Created by Edge on 2017/5/30.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeLeftSlideManager.h"
#import "UIView+EdgeExpention.h"
#import "EdgeInfomationViewController.h"
#define AppDelegate [[UIApplication sharedApplication] delegate]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface EdgeLeftSlideManager ()

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation EdgeLeftSlideManager

- (UIPanGestureRecognizer *)pan {
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
    }
    return _pan;
}


#pragma mark 单例
+(instancetype)instance{
    
    static EdgeLeftSlideManager *manager = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        manager = [[EdgeLeftSlideManager alloc]init];
    });
    return manager;
}

#pragma mark extention manager
-(void)installMainViewController:(UIViewController *)VC leftView:(UIView *)leftView{
    
   self.mainViewController = VC;
    self.leftView = leftView;
  //  EdgeInfomationViewController *infoVC = [[EdgeInfomationViewController alloc]init];
    [AppDelegate window].rootViewController = VC;
    [[AppDelegate window] addSubview:leftView];
    [self showShadow];
    // 添加手势
    [self.mainViewController.view addGestureRecognizer:self.pan];
}

-(void)hiddenShadow{
    if (!self.mainViewController) { return;}
    self.mainViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainViewController.view.layer.shadowOffset = CGSizeMake(0, 0);
    //    透明度（如果要显示就一定要加)
    self.mainViewController.view.layer.shadowOpacity = 0;
    // 圆角半径
    self.mainViewController.view.layer.shadowRadius = 0;
}

-(void)showShadow{
    if (!self.mainViewController.view) { return; }
    self.mainViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainViewController.view.layer.shadowOffset = CGSizeMake(6, 6);
    self.mainViewController.view.layer.shadowOpacity = 0.7;
    self.mainViewController.view.layer.shadowRadius = 6.f;
}

-(void)cancelDrawReponse{
     if (!self.mainViewController.view) { return; }
    [self.mainViewController.view removeGestureRecognizer:self.pan ];
}

-(void)beginGragRespanse{
 if (!self.mainViewController.view) { return; }
    [self.mainViewController.view addGestureRecognizer:self.pan];
}

-(void)resetShowType:(EdgeManagerShowType)shouType{
 if (!self.mainViewController.view) { return; }
    
    CGAffineTransform leftScopeTransform = CGAffineTransformMakeTranslation(ScreenWidth * leftWidthScale, 0);
    switch (shouType) {
        case EdgeManagerShowLeft:{
            [UIView animateWithDuration:0.2f animations:^{
                self.mainViewController.view.transform = leftScopeTransform;
                [AppDelegate window].subviews.firstObject.tx = self.mainViewController.view.tx / 3;
            }];

            break;}
        case EdgeManagerShowCenter:{
            [UIView animateWithDuration:0.2f animations:^{
                //CGAffineTransformIdentity 形变参数都是0
                self.mainViewController.view.transform = CGAffineTransformIdentity;
                [AppDelegate window].subviews.firstObject.tx = self.mainViewController.view.tx / 3;
//                          NSLog(@"222self.centerViewController.view.tx / 3;=%f",self.mainViewController.view.tx / 3);
            }];
            
            break;}
        case EdgeManagerShowLeftWithoutAnimation:{
            [UIView animateWithDuration:0.2f animations:^{
                self.mainViewController.view.transform = leftScopeTransform;
                [AppDelegate window].subviews.firstObject.tx = self.mainViewController.view.tx / 3;
            }];
            
            break;}
        case EdgeManagerShowCenterWithoutAnimation:{
            [UIView animateWithDuration:0.2f animations:^{
                self.mainViewController.view.transform = CGAffineTransformIdentity;
                [AppDelegate window].subviews.firstObject.tx = self.mainViewController.view.tx / 3;
            }];
            
            break;}
       
    }

}

-(void)handlePanAction:(UIPanGestureRecognizer *)sender{
    // 1. 获取手指拖拽的时候，平移的值
    CGPoint translation = [sender translationInView:sender.view];
    // 2. 让当前视图进行平移
    sender.view.transform = CGAffineTransformTranslate(sender.view.transform, translation.x, 0);
    [AppDelegate window].subviews.firstObject.tx = sender.view.tx / 3;
    // 3. 让平移的值不要累加
    [sender setTranslation:CGPointZero inView:sender.view];
    // 4. 获取最右边的范围
    CGAffineTransform rightScopeTransform = CGAffineTransformTranslate([AppDelegate window].transform, ScreenWidth * leftWidthScale, 0);
    
    if (sender.view.tx > rightScopeTransform.tx) {
        // 当移动到右边极限时
        // 限制最右边的范围
        sender.view.transform = rightScopeTransform;
        [AppDelegate window].subviews.firstObject.tx = sender.view.tx / 3;
    } else if (sender.view.tx < 0.0) {
        // 限制最左边的范围
        sender.view.transform = CGAffineTransformTranslate([AppDelegate window].transform, 0, 0);
        [AppDelegate window].subviews.firstObject.tx = sender.view.tx / 3;
    }
    
    // 拖拽结束时
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2f animations:^{
            if (sender.view.left > ScreenWidth * 0.5) {
                sender.view.transform = rightScopeTransform;
                [AppDelegate window].subviews.firstObject.tx = sender.view.tx / 3;
            } else {
                sender.view.transform = CGAffineTransformIdentity;
                [AppDelegate window].subviews.firstObject.tx = sender.view.tx / 3;
            }
        }];
    }

}
@end
