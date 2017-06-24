//
//  EdgeLeftSlideView.m
//  侧边栏
//
//  Created by Edge on 2017/5/30.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeLeftSlideView.h"
#import "UIView+EdgeExpention.h"
#import "EdgeLeftSlideManager.h"
#define kBackgroundColor [UIColor colorWithRed:13.f / 255.f green:184.f / 255.f blue:246.f / 255.f alpha:1]

@interface EdgeLeftSlideView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;//  数据
@property (nonatomic, strong) UIImageView *imageView;//  头像

@end

@implementation EdgeLeftSlideView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kBackgroundColor;
        
        self.dataArray = @[
                           @{@"icon":@"sidebar_business",@"name":@"我的商城"},
                           @{@"icon":@"sidebar_purse",@"name":@"QQ钱包"},
                           @{@"icon":@"sidebar_decoration",@"name":@"个性装扮"},
                           @{@"icon":@"sidebar_favorit",@"name":@"我的收藏"},
                           @{@"icon":@"sidebar_album",@"name":@"我的相册"},
                           @{@"icon":@"sidebar_file",@"name":@"我的文件"},
                           ];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.wdith, self.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        
        _tableView.tableHeaderView = self.imageView;
        _tableView.tableFooterView = [[UIView alloc] init];

    }
    return self;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.wdith, 44)];
        selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
        cell.selectedBackgroundView = selectedBackgroundView;
    }
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:dic[@"icon"]];
    cell.textLabel.text = dic[@"name"];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",(long)indexPath.row);
    // 显示中间控制器
    [[EdgeLeftSlideManager instance] resetShowType:EdgeManagerShowCenter];
}

#pragma mark - headerView
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.wdith, 280)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.image = [UIImage imageNamed:@"sidebar_bg"];
        _imageView.clipsToBounds = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default.jpg"]];
        imageView.size = CGSizeMake(60, 60);
        imageView.left = 25;
        imageView.top = 64;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = imageView.wdith / 2;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 2.f;
        [_imageView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 30, imageView.top + 10, 100, 20)];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.text = @"UEdge";
        [_imageView addSubview:label];
    }
    return _imageView;
}

@end
