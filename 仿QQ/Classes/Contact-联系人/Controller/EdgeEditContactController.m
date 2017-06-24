//
//  EdgeEditContactController.m
//  仿QQ
//
//  Created by Edge on 17/5/21.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeEditContactController.h"
#import "EdgeGroup.h"
@interface EdgeEditContactController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSIndexPath *_indexPath; // 保存当前选中的单元格
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *addHeadView;


@end

@implementation EdgeEditContactController

-(NSMutableArray *)groupModelArr{
    if (!_groupModelArr) {
        
        _groupModelArr = [NSMutableArray array];
    }
    return _groupModelArr;
}

-(NSMutableArray *)contactModelArr{
    if (!_contactModelArr) {
        
        _contactModelArr = [NSMutableArray array];
    }
    return _contactModelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //  添加右上方完成按钮
    self.view.backgroundColor = EdgeGloupColor;
    UIBarButtonItem *iteam = [UIBarButtonItem iteamWithTitle:@"完成" target:self action:@selector(clickRightButton:)];
    self.navigationItem.rightBarButtonItem = iteam;

    //  添加UITableView
    [self addUITableView];
    //  添加TbleHeaderView
    [self addHeadViewToTableView];
}

#pragma mark diyAction

-(void)addUITableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.editing = YES;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableView];
}

-(void)addHeadViewToTableView{
 //   NSLog(@"addHearView");
    _addHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    _addHeadView.backgroundColor = EdgecellHeaderColor;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 14, 32, 32)];
    imageView.image = [UIImage imageNamed:@"add.png"];
    [_addHeadView addSubview:imageView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(52, 0, 100, 60)];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = @"添加分组";
    [_addHeadView addSubview:label];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 60 - 0.5, SCREEN_WIDTH, 0.5)];
    view1.backgroundColor = RGB_HEX(0xC8C7CC);
    [_addHeadView addSubview:view1];
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    [addBtn addTarget:self action:@selector(addGroupAlert) forControlEvents:UIControlEventTouchUpInside];
    [_addHeadView addSubview:addBtn];
    
    self.tableView.tableHeaderView = _addHeadView;
    
}
/** 弹出框 */
- (void)addGroupAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加分组" message:@"请输入新的分组名称" preferredStyle:UIAlertControllerStyleAlert];
    //添加有文本输入框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入分组名";
        //设置文本清空按钮
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 读取文本框的值显示出来
        UITextField *addGroupTF = alert.textFields.firstObject;
      //  NSLog(@"新添加的分组名：%@", addGroupTF.text);
        
        _returnText(addGroupTF.text);

    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)clickRightButton:(UIBarButtonItem *)sender {
    NSLog(@"点击了编辑按钮");
  
     [self dismissViewControllerAnimated:YES completion:nil];
    
};

#pragma mark UITableViewdelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // NSLog(@"%lu", (unsigned long)_groupModelArr.count);
    return self.groupModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor =EdgecellHeaderColor;
    if (indexPath.row != 0) {//  为分组不传过来
        cell.textLabel.textColor = RGB_HEX(0x363636);
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        EdgeGroup *model = _groupModelArr[indexPath.row];
        cell.textLabel.text = model.group_name;
    }
    
    //  最后一行cell
     if (indexPath.row==_groupModelArr.count-1) {
    
    //  插入分组
    __weak typeof(self) weakSelf = self;
    __strong typeof(weakSelf) strongSelf = weakSelf;
    
    strongSelf.returnText = ^(NSString *returenTextBlock){
        
        NSArray *insertPath = [NSArray arrayWithObjects:indexPath, nil];
        //
        [_groupModelArr insertObject:returenTextBlock atIndex:indexPath.row];
        //
        [_tableView insertRowsAtIndexPaths:insertPath withRowAnimation:UITableViewRowAnimationRight];
        
        [_tableView reloadData];
    };
        
}
       return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 0;
    } else {
        return 50 / 375.0 * SCREEN_WIDTH;
    }
}
#pragma  mark -- 删除cell
/** 指定哪些行的 cell 可以进行编辑 (UITableViewDataSource 协议方法) */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return NO; // 第一行不能编辑
    } else {
        return YES;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        EdgeGroup *groupModel = self.groupModelArr[indexPath.row];
        
        // 删除数组中的元素
        [self.groupModelArr removeObjectAtIndex:indexPath.row];
     
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationRight)];

        [tableView reloadData];
        
        if (groupModel.member_num == 0) {
            //删除分组
               NSLog(@"删除分组！");
   
        }else {
            //  有好友删除后放到未分组
             NSLog(@"组内有成员，不能删除！");
            //  插入未分组
            }
    }
}

//点击左边删除按钮时,显示的右边删除button的title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    return @"删除分组";
    
}
#pragma mark  --  移动cell
/** 1.指定tableView那些行(cell)可以移动 */
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return NO; //cell不能移动
    } else {
        return YES; //cell可以移动
    }
}
//这个方法就是执行移动操作的
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)
sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

    //1. 存储将要被移动的位置的对象
    NSString *Groupstr = [_groupModelArr objectAtIndex:sourceIndexPath.row];
    NSString *ConStr = [_contactModelArr objectAtIndex:sourceIndexPath.row];
    
    //2. 将对象从原位置移除
    [self.groupModelArr removeObjectAtIndex:sourceIndexPath.row];
    [self.contactModelArr removeObjectAtIndex:sourceIndexPath.row];
    //3. 将对象插入到新位置
    [self.groupModelArr insertObject:Groupstr atIndex:destinationIndexPath.row];
    [self.contactModelArr insertObject:ConStr atIndex:destinationIndexPath.row];
    //刷新表格
    [self.tableView reloadData];
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

@end
