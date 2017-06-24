//
//  EdgeContactViewController.m
//  仿QQ
//
//  Created by Edge on 2017/5/17.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeContactViewController.h"
#import "EdgeContacts.h"
#import "EdgeGroup.h"
#import "BRContactsCell.h"
#import "EdgeEditContactController.h"
#import "EdgeChatViewController.h"
@interface EdgeContactViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>
{
    NSIndexPath *_indexPath; // 保存当前选中的单元格
    NSMutableArray *switchArr; // 保存旋转状态(展开/折叠)
}
@property(weak,nonatomic)UITableView *tableView;
/** 保存分组数据模型 */
@property (nonatomic, strong) NSMutableArray *groupModelArr;
/** 保存联系人数据模型 (是一个二维数组, 便于遍历分区和行信息) */
@property (nonatomic, strong) NSMutableArray *contactsModelArr;

@property(nonatomic,strong)NSMutableArray *searchResultArr;// 查询结果

@property(nonatomic,strong)UISearchController *searchController;//  search

// 搜索储存名字
@property(nonatomic,strong)NSMutableArray *searchNameArr;

@end

@implementation EdgeContactViewController
#pragma mark lazy
- (NSMutableArray *)groupModelArr {
    if (!_groupModelArr) {
        _groupModelArr = [[NSMutableArray alloc] init];
    }
    return _groupModelArr;
}

- (NSMutableArray *)contactsModelArr {
    if (!_contactsModelArr) {
        _contactsModelArr = [[NSMutableArray alloc]init];
    }
    return _contactsModelArr;
}

-(NSMutableArray *)searchNameArr{
    if (!_searchNameArr) {
        _searchNameArr = [[NSMutableArray alloc]init];
    }
   return  _searchNameArr;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 刷新界面
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIBarButtonItem *iteam = [UIBarButtonItem iteamWithTitle:@"添加" target:self action:@selector(addFriendsAction)];
    
    self.navigationItem.rightBarButtonItem = iteam;
    
    
    [self addTableView];
    
    [self addSearchBar];
    //  加载数据
    [self loadData];
    
    
   // [self performSelector:@selector(wangmumu:) withObject:@"100" afterDelay:1];
}


//- (void) wangmumu:(NSString *)han{
//    static dispatch_once_t disOnce;
//    //只执行一次
//    dispatch_once(&disOnce, ^{
//        NSLog(@"12345678910");
//    });
//}


-(void)addTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    tableView.backgroundColor = EdgeGloupColor;
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:tableView];
}

-(void)addFriendsAction{
    NSLog(@"%s",__func__);
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


#pragma mark 自定义函数
-(void)loadData{

    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"json" ofType:@"plist"];
    
    NSMutableDictionary *dictdata = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    /**
     *  获取group
     */
    //获取第二层的数据，数据类型为字典
    NSArray *groupArr = dictdata[@"body"][@"groups"];
    
    for (NSDictionary *groupDic in groupArr) {
        
        EdgeGroup *groupModel = [EdgeGroup groupWithDiction:groupDic];
        
        [self.groupModelArr addObject:groupModel];
        
        /**
         *  获取contact
         */
        
        NSMutableArray *contactMUArray = [NSMutableArray array];
        
        NSArray *contactsArr = groupDic[@"contacts"];
        
        for (NSDictionary *dict in contactsArr) {
            
            EdgeContacts *contacts = [EdgeContacts contactWithDict:dict];
            
            [contactMUArray addObject:contacts];
        }
        [self.contactsModelArr addObject:contactMUArray];
        
        
        // 保存点击状态（初始化NO）
        if (switchArr == nil) {
            switchArr = [[NSMutableArray alloc]init];
        }
        [switchArr addObject:@NO];
        // 回到主线程更新界面
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
    
}
#pragma mark UITableViewdelegate UITableViewDatadous

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.searchController.active) {
        // NSLog(@"[self.searchResultArr count]= %lu",(unsigned long)[self.searchResultArr count]);
        return self.searchResultArr.count;
        
    }else{
        return self.contactsModelArr.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (self.searchController.active) {
       // NSLog(@"[self.searchResultArr count]= %lu",(unsigned long)[self.searchResultArr count]);
        return [self.searchResultArr count];
        
    }else{
        
    if ([switchArr[section] boolValue] == YES) {
      
        return [_contactsModelArr[section] count];
        
    } else {
        return 0;
    }
}
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    static NSString *ID = @"cell";
    BRContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BRContactsCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    if (self.searchController.active) {
        
       [cell.detailTextLabel setText:self.searchResultArr[indexPath.row]];
        
    }else{
        
    cell.model = self.contactsModelArr[indexPath.section][indexPath.row];
   
    
        //  储存要搜索的数据
    [self.searchNameArr addObject:cell.model.describe];
//        NSLog(@"%@",cell.model.describe);
//        NSLog(@"%@",self.searchNameArr);

}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中后的高亮状态(默认是：选中单元格后一直处于高亮状态，直到下次重新选择)
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _indexPath = indexPath;
    
        //跳转隐藏tabbar
        self.hidesBottomBarWhenPushed = YES;
        EdgeChatViewController *chatVC = [[EdgeChatViewController alloc]init];
        
        chatVC.chatName = @"Romantic";
        
        [self.navigationController pushViewController:chatVC animated:YES];
        
        self.hidesBottomBarWhenPushed=NO;
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60 / 375.0 * self.view.frame.size.width;
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50 / 375.0 * self.view.frame.size.width;
}

//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *view = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320 / 375.0 * SCREEN_WIDTH, 50 / 375.0 * SCREEN_WIDTH)];
    [view setBackgroundColor:[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0]];
   // view.backgroundColor = [UIColor whiteColor];
    
    // 边界线
    UIView *borderView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 / 375.0 * SCREEN_WIDTH, SCREEN_WIDTH, 0.5)];
    borderView.backgroundColor = RGB_HEX(0xC8C7CC);
    [view addSubview:borderView];
    // 展开箭头
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15 / 375.0 * SCREEN_WIDTH, 19 / 375.0 * SCREEN_WIDTH, 14 / 375.0 * SCREEN_WIDTH, 12 / 375.0 * SCREEN_WIDTH)];
    imageView.image = [UIImage imageNamed:@"pulldownList.png"];
    [view addSubview:imageView];
    // 分组名Label
    UILabel *groupLable = [[UILabel alloc]initWithFrame:CGRectMake(45 / 375.0 * SCREEN_WIDTH, 0, SCREEN_WIDTH, 50 / 375.0 * SCREEN_WIDTH)];
 

    EdgeGroup *model = _groupModelArr[section];
    
 //   NSLog(@"%ld",(long)section);
    
    groupLable.text = [NSString stringWithFormat:@"%@ [ %ld ]", model.group_name, (long)model.member_num];
  
    groupLable.textColor = [UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1.0];
    groupLable.font = [UIFont systemFontOfSize:16];
    
    [view addSubview:groupLable];
    //  给button添加点击事件
    
    [view addTarget:self action:@selector(clickOpenSection:) forControlEvents:(UIControlEventTouchUpInside)];
    
    view.tag = 1000 + section;
    
    
    view.userInteractionEnabled = YES;
    // 初始化一个手势
    UILongPressGestureRecognizer *myTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    // 给view添加手势
    [view addGestureRecognizer:myTap];
    
    
    CGFloat rota;
    if ([switchArr[section] boolValue] == NO) {
        rota = 0;
    } else {
        rota = M_PI_2; //π/2
    }
    imageView.transform = CGAffineTransformMakeRotation(rota);//箭头偏移π/2
    return view;
}
//  点击显示下拉分页
-(void)clickOpenSection:(UIButton *)sender{
  
    NSInteger section = sender.tag - 1000;
    if ([switchArr[section] boolValue] == NO) {
        [switchArr replaceObjectAtIndex:section withObject:@YES];
    } else {
        [switchArr replaceObjectAtIndex:section withObject:@NO];
    }
    //  刷新section
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

//  长按手势
- (void)longPressAction:(UILongPressGestureRecognizer *)gesture {
   
    if(gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gesture locationInView:self.tableView];
        _indexPath = [self.tableView indexPathForRowAtPoint:point];
        // 弹出框
        [self gestureAlert];
        if(_indexPath == nil) return ;
    }

}
/** 弹出框方法 */
- (void)gestureAlert {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击了删除");
//    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"分组管理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //    NSLog(@"点击了移至分组");
     
        EdgeEditContactController *editControllr = [[EdgeEditContactController alloc]init];
        editControllr.groupModelArr = self.groupModelArr; //传值
        editControllr.contactModelArr = self.contactsModelArr;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:editControllr];
                [self presentViewController:nav animated:YES completion:nil];
   
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 15.0f;
    } else {
        return 1.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *clearView = [[UIView alloc]init];
    clearView.backgroundColor = [UIColor clearColor];
    return clearView;
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
    self.searchResultArr= [NSMutableArray arrayWithArray:[self.searchNameArr filteredArrayUsingPredicate:preicate]];
    
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
