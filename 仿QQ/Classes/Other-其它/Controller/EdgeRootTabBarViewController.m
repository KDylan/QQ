//
//  EdgeRootTabBarViewController.m
//  仿QQ
//
//  Created by Edge on 2017/5/17.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeRootTabBarViewController.h"
#import "EdgeContactViewController.h"
#import "EdgeDynamicViewController.h"
#import "EdgeInfomationViewController.h"

#import "EdgeLoginViewConViewController.h"

@interface EdgeRootTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation EdgeRootTabBarViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //  设置最上面一层navigationbar隐藏
    
    [self.navigationItem setHidesBackButton:YES];
    
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   // NSLog(@"%@",self);
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//    NSLog(@"--------%@",path);
    
    self.delegate = self;
    
    [self addChildController];
    
    
    //  设置tabbBar属性
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSDictionary *dict = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:12.0],
                           NSForegroundColorAttributeName:[UIColor grayColor]
                           };
    NSDictionary *selectDict = @{
                                 NSForegroundColorAttributeName:[UIColor darkGrayColor]
                                 };
    
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDict forState:UIControlStateHighlighted];

}

-(void)addChildController{
    //  消息
    [self setChildController:[[EdgeInfomationViewController alloc]init] title:@"消息" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    //  联系人
    [self setChildController:[[EdgeContactViewController alloc]init] title:@"联系人" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    //动态
    [self setChildController:[[EdgeDynamicViewController alloc]init] title:@"动态" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
}

-(void)setChildController:(UIViewController *)ViewController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage{
//    self.view.backgroundColor = [UIColor
//                                                                 colorWithRed:((float)arc4random_uniform(256)/255.0)
//                                                                 green:((float)arc4random_uniform(256)/255.0)
//                                                                 blue:((float)arc4random_uniform(256)/255.0) alpha:1.0];
//
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:ViewController];
 //   [nav.navigationBar setBackgroundColor:[UIColor redColor]];
    ViewController.title = title;
    ViewController.tabBarItem.title = title;
    ViewController.tabBarItem.image = [UIImage imageNamed:image];
    ViewController.tabBarItem.selectedImage = [UIImage imageOriginalImaged:selectImage];
    
    [self addChildViewController:nav];
    
}
#pragma mark - UITabBarController protocol methods
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    if ([viewController isKindOfClass:[UINavigationController class]]) {
//        
//        UINavigationController *navigationController = (UINavigationController *)viewController;
//        UIViewController *_viewController = navigationController.viewControllers.firstObject;
//        NSLog(@"%@",_viewController);
//        // 如果选中消息页，响应拖拽手势，可以显示侧边栏
//        // 否则取消手势响应，不能显示侧边栏
//        if ([_viewController isKindOfClass:[EdgeInfomationViewController class]]) {
//            
//            [[EdgeLeftSlideManager instance] beginGragRespanse];
//        } else {
//            [[EdgeLeftSlideManager instance] cancelDrawReponse];
//        }
//    }
//}


@end
