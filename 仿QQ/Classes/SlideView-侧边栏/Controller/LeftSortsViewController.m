//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"

#import "EdgemoreViewController.h"
@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation LeftSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];

    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   // tableview.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:tableview];
    
    [self addheadView];
}



-(void)addheadView{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefault objectForKey:@"userName"];
    
    UIView *vc = [[UIView alloc]init];
   // vc.backgroundColor = [UIColor redColor];
    
    [self.tableview addSubview:vc];
    
     [vc mas_makeConstraints:^(MASConstraintMaker *make) {
     
     make.top.equalTo(self.tableview).offset(75);
     make.left.equalTo(self.tableview).offset(20);
     make.height.equalTo(@100);
     make.width.equalTo(@200);
     
     }];
     //  切圆角
//     button.layer.masksToBounds = YES;
//     button.layer.cornerRadius = 10;
//     

    UIImageView *image = [[UIImageView alloc]init];
    
     if (userName == nil) {
    
    image.image = [UIImage imageNamed:@"defaultUserIcon"];
     }else{
      image.image = [UIImage imageNamed:@"logol.jpg"];
     }
    [vc addSubview:image];
    image.layer.masksToBounds = YES;
    image.layer.cornerRadius = 40;
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(vc);
        make.left.equalTo(vc);
        make.height.equalTo(@80);
        make.width.equalTo(@80);
        
    }];
    
    UILabel *label = [[UILabel alloc]init];
    if (userName == nil) {

   // label.backgroundColor = [UIColor yellowColor];
    label.text = @"昵称：";
    }else{
    label.text = @"昵称：隔壁小僧";
    }
    label.font = [UIFont systemFontOfSize:17.0];
    label.textColor = [UIColor whiteColor];
    [vc addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(image.centerY);
       // make.top.equalTo(vc);
        make.left.equalTo(image.mas_right).offset(10);
        make.height.equalTo(@35);
        make.width.equalTo(@150);
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"0";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"1";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"2";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"3";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"4";
    }else if (indexPath.row == 5) {
        cell.textLabel.text = @"退出";}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"%ld",(long)indexPath.row);
   
    if (indexPath.row==5) {
        
        EdgemoreViewController *moreAction = [[EdgemoreViewController alloc]init];
       
      
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
     
        [tempAppDelegate.mainNavigationController pushViewController:moreAction animated:NO];
 
    }
    
 //   [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
      
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end
