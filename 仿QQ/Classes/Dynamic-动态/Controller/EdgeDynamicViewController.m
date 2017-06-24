//
//  EdgeDynamicViewController.m
//  仿QQ
//
//  Created by Edge on 2017/5/17.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeDynamicViewController.h"
#import "EdgetopView.h"
#import "EdgemoreViewController.h"
@interface EdgeDynamicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *imageIconArr;
@property(nonatomic,strong)NSMutableArray *cellLabelTextArr;
@end

@implementation EdgeDynamicViewController

-(NSMutableArray *)imageIconArr{
    if (!_imageIconArr) {
        _imageIconArr = [[NSMutableArray alloc]initWithObjects:@"news",@"eat",@"shopping",@"music",@"game", nil];
    }
    return _imageIconArr;
    
}
-(NSMutableArray *)cellLabelTextArr{
    
    if (!_cellLabelTextArr) {
        _cellLabelTextArr = [[NSMutableArray alloc]initWithObjects:@"腾讯新闻",@"吃喝玩乐",@"购物",@"音乐",@"游戏", nil];
    }
    return _cellLabelTextArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 刷新界面
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *iteam = [UIBarButtonItem iteamWithTitle:@"更多" target:self action:@selector(moreAction)];
    self.navigationItem.rightBarButtonItem = iteam;
   
    [self addTableView];
    //  加载xib
    [self loadXib];
}


#pragma mark 自定义函数
-(void)addTableView{

  UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds  style: UITableViewStyleGrouped];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   self.tableView.backgroundColor = EdgeGloupColor;

    [self.view addSubview:tableView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.wdith, 100)];
    
    tableView.tableHeaderView = headView;
}

-(void)loadXib{
    
    EdgetopView *topView = [EdgetopView loadTopViewXib];
    
    [self.tableView.tableHeaderView addSubview:topView];
    
    topView.frame = CGRectMake(0, 0, self.view.wdith, 100);
}

#pragma mark 按钮点击事件
/**
 *  点击更多
 */
- (void)moreAction{
    
    NSLog(@"%s",__func__);
    EdgemoreViewController *moreAction = [[EdgemoreViewController alloc]init];
    [self.navigationController pushViewController:moreAction animated:YES];
    
}

#pragma mark UItableViewdelegate

//  分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return 2;
}

//  每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
        
     return self.cellLabelTextArr.count;
    }
}

//  每行
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *ID = @"cell";
    //  根据缓存池循环利用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
   
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor whiteColor];
   
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text = @"运动";
            cell.imageView.image = [UIImage imageNamed:@"sport"];
        }
    }else{
        
      cell.textLabel.text = self.cellLabelTextArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:self.imageIconArr[indexPath.row]];
    }
    cell.imageView.layer.cornerRadius =20;
    cell.imageView.layer.masksToBounds = YES;
    //  显示右边小箭头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
   // cell.backgroundColor = EdgecellHeaderColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
#pragma mark- cell分割线左对齐(两个方法)
- (void)viewDidLayoutSubviews {
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    if (section==0) {
//        
//        return 20;
//        
//    }else{
//        
//     return 0;
//    }
//   
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    
//    return 0;
//}
//

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;//section头部高度
}

//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.wdith, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view ;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.wdith, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


@end
