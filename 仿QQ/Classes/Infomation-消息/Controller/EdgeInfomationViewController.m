//
//  EdgeInfomationViewController.m
//  仿QQ
//
//  Created by Edge on 2017/5/17.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeInfomationViewController.h"
#import "EdgeChatViewController.h"
#import "EdgeContacts.h"
#import "EdgeLeftSlideView.h"
#import "UIView+EdgeExpention.h"
#import "EdgeLeftSlideManager.h"

#import "EdgeLoginViewConViewController.h"

@interface EdgeInfomationViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@property(weak,nonatomic)UITableView *tableView;
@property(weak,nonatomic)UITableView *listView;//  点击下拉列表
@property(nonatomic,assign)NSInteger btnClickedCount;// 统计点击次数，区分奇偶
@property(nonatomic,strong)NSMutableArray *listViewName;//  下拉列表string

@property (nonatomic, strong) NSMutableArray *contactsTextNameArr;//  cell的labelText
@property (nonatomic, strong) NSMutableArray *contactsDetailNameArr;//  cell的DeatillabelText
@property (nonatomic, strong) NSMutableArray *contactsIcon;//  cell的头像

@property(nonatomic,strong)NSMutableArray *searchResultArr;// 查询结果

@property(nonatomic,strong)UISearchController *searchController;//  search
@end

@implementation EdgeInfomationViewController
-(NSMutableArray *)listViewName{
    if (!_listViewName) {
        _listViewName = [[NSMutableArray alloc]initWithObjects:@"创建新群",@"加好友/群",@"扫一扫",@"面对面快传",@"付款",@"拍摄",@"面对面红包", nil];
    }
    return _listViewName;
}
-(NSMutableArray *)contactsTextNameArr{
    if (!_contactsTextNameArr) {
        _contactsTextNameArr = [[NSMutableArray alloc]initWithObjects:@"张三",@"李四",@"王五",@"小明",@"张小龙",@"乔布斯", @"张三",@"李四",@"王五",@"小明",@"张小龙",@"乔布斯",@"张三",@"李四",@"王五",@"小明",@"张小龙",@"乔布斯",nil];
    }
    return _contactsTextNameArr;
}
-(NSMutableArray *)contactsDetailNameArr{
    if (!_contactsDetailNameArr) {
        _contactsDetailNameArr = [[NSMutableArray alloc]initWithObjects:@"[WIFI在线]欢迎给我留言",@"[手机在线]更新了日志",@"[4G在线]更新了说说",@"[电脑在线]欢好好学习,天天向上",@"[离线请留言]哥是最牛逼的产品经理",@"[离线]把产品做到极致", @"[WIFI在线]欢迎给我留言",@"[手机在线]更新了日志",@"[4G在线]更新了说说",@"[电脑在线]欢好好学习,天天向上",@"[离线请留言]哥是最牛逼的产品经理",@"[离线]把产品做到极致",@"[WIFI在线]欢迎给我留言",@"[手机在线]更新了日志",@"[4G在线]更新了说说",@"[电脑在线]欢好好学习,天天向上",@"[离线请留言]哥是最牛逼的产品经理",@"[离线]把产品做到极致",nil];
    }
    return _contactsDetailNameArr;
}
-(NSMutableArray *)contactsIcon{
    if (!_contactsIcon) {
        
        _contactsIcon = [[NSMutableArray alloc]initWithObjects:@"default.JPG",@"icon2.jpg",@"icon3.jpg",@"icon4.jpg",@"icon5.jpg",@"icon6.jpg",@"icon7.jpg",@"icon8.jpg",@"icon9.jpg",@"icon1.jpg",@"default.JPG",@"icon2.jpg",@"icon3.jpg",@"icon4.jpg",@"icon5.jpg",@"icon6.jpg",@"icon7.jpg",@"icon8.jpg",@"icon9.jpg", nil];
    }
    return _contactsIcon;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *iteam = [UIBarButtonItem iteamWithImageNamed:@"nav_coin_icon" hightLightImageName:@"nav_coin_icon_click" target:self action:@selector(infomationListView)];
    self.navigationItem.rightBarButtonItem = iteam;
    
    UIBarButtonItem *iteamleft = [UIBarButtonItem iteamWithImageNamed:@"defaulticon.JPG" hightLightImageName:@"defaulticon.JPG" target:self action:@selector(leftSlideView)];
    
    self.navigationItem.leftBarButtonItem = iteamleft;
  
    //  添加tableView
    [self addTableView];
    
    [self addlistView];

    [self addSearchBar];
    
    
    
   }


-(void)addSearchBar{
    //  创建searchController
    
       _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
 
    _searchController.searchBar.placeholder = @"搜索";
    
     // 设置代理协议
    _searchController.searchResultsUpdater = self;
    _searchController.delegate = self;

    //搜索时，背景变暗色
    _searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
    _searchController.obscuresBackgroundDuringPresentation = YES;
    //隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = YES;
    
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
        [_searchController.searchBar sizeToFit];
      self.definesPresentationContext = YES;
    // 添加 searchbar 到 headerview
    self.tableView.tableHeaderView = _searchController.searchBar;
    
  
}

-(void)addTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.tag=1;
    tableView.frame = [UIScreen mainScreen].bounds;
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = EdgeGloupColor;
    [self.view addSubview:tableView];
}

-(void)infomationListView{
 
    
    NSInteger flag =  self.btnClickedCount++;
   
    if (flag%2==0) {
        
        self.listView.hidden =NO;
        
    }else{
        
        self.listView.hidden = YES;
    }
}
//  点击显示侧边栏
-(void)leftSlideView{
    NSLog(@"%s",__func__);
    
//    EdgeLeftSlideView *leftView = [[EdgeLeftSlideView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH * (1 - leftWidthScale), 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//     //  NSLog(@" LeftView *leftView = %@",leftView);
//    [self.view addSubview:leftView];
//    /**
//     *  frame = (-93.75 0; 375 667); layer = <CALayer: 0x7f97f9740230>>
//
//     */
//    [[EdgeLeftSlideManager instance]installMainViewController:self leftView:leftView];

}
-(void)addlistView{
    //  添加背景View
    
    UITableView *listView = [[UITableView alloc]init];
    listView.tag=2;
    listView.frame = CGRectMake(self.view.wdith/2, 70, self.view.wdith/2-5, 245);
   
    self.listView = listView;
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.hidden=YES;
    listView.layer.masksToBounds = YES;
    listView.layer.cornerRadius =8;
    
    [self.view addSubview:listView];
}
#pragma mark UITableViewdelegate UITableViewDatadous
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (self.searchController.active) {
     
        return [self.searchResultArr count];
   
    }else{
        
        if (tableView.tag==1) {
            
            return self.contactsTextNameArr.count;
            
        }
        else{
            return self.listViewName.count;
        }
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:ID];
    }
    
  
    if (self.searchController.active) {
        [cell.textLabel setText:self.searchResultArr[indexPath.row]];
    }
    else{
        if (tableView.tag==1) {
     //       cell.textLabel.text = @"14";
            cell.imageView.layer.masksToBounds = YES;
            cell.imageView.layer.cornerRadius =20;
            
            cell.textLabel.text = self.contactsTextNameArr[indexPath.row];
            cell.imageView.image = [UIImage imageNamed:self.contactsIcon[indexPath.row]];
            cell.detailTextLabel.text =self.contactsDetailNameArr[indexPath.row];
            cell.backgroundColor = EdgecellHeaderColor;
        }else{
            
            cell.textLabel.text = self.listViewName[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //跳转隐藏tabbar
    self.hidesBottomBarWhenPushed = YES;
    EdgeChatViewController *chatVC = [[EdgeChatViewController alloc]init];
    
    chatVC.chatName = _contactsTextNameArr[indexPath.row];
    
    [self.navigationController pushViewController:chatVC animated:YES];
 
    self.hidesBottomBarWhenPushed=NO;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
        return 55;
    }else{
        return 35;
    }
}

#pragma  mark 编辑状态
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
#pragma mark 设置编辑的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
#pragma mark 在滑动手势删除某一行的时候，显示出更多的按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
      //  NSLog(@"点击了删除");
        
        //移除要删除的数据
        [self.contactsTextNameArr removeObjectAtIndex:indexPath.row];
        //更新UITableView
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    // 添加一个置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
      //  NSLog(@"点击了置顶");
        //交换数据
        [self.contactsTextNameArr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        //更新UITableView
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
    }];
    topRowAction.backgroundColor = [UIColor blueColor];
    
    // 添加一个更多按钮
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
      //  NSLog(@"点击了更多");
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    }];
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction, topRowAction, moreRowAction];
    
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
//  cell将显示时候调用
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
   
    //转动特效
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
    }];
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma  mark UISearchdelegate UITableViewDatasources

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
  //  NSLog(@"updateSearchResultsForSearchController");
        NSString *searchString = [self.searchController.searchBar text];
    //  查找集合中包含搜素字符串的数据
        NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
        if (self.searchResultArr!= nil) {
            [self.searchResultArr removeAllObjects];
        }
        //过滤数据
        self.searchResultArr= [NSMutableArray arrayWithArray:[self.contactsDetailNameArr filteredArrayUsingPredicate:preicate]];
    
    [self.tableView reloadData];
    
}
- (void)willPresentSearchController:(UISearchController *)searchController
{
    //  NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    //NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    //NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    // NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    //  NSLog(@"presentSearchController");
}

@end
