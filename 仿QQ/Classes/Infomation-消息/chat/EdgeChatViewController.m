//
//  EdgeChatViewController.m
//  自动回复
//
//  Created by Edge on 2017/5/28.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeChatViewController.h"
#import "dataModel.h"
#import "modelFream.h"
#import "EdgeCustomTableViewCell.h"

#define statusH   (44+20)    // 状态栏的高度+上边距

@interface EdgeChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    CGFloat showTableViewH;
}

/**
 *  模型数据数组(这里可以用泛型,增强可读性)
 */
@property (nonatomic,strong)NSMutableArray *arrTimeData;

//  存储模型数据
@property(strong,nonatomic)NSMutableArray *arrModelData;

@end

@implementation EdgeChatViewController

-(NSMutableArray *)arrTimeData{
    if (_arrTimeData==nil) {
        _arrTimeData=[NSMutableArray array];
    }
    return _arrTimeData;
}

-(NSMutableArray *)arrModelData{
    if (!_arrModelData) {
        
        _arrModelData = [NSMutableArray arrayWithArray:@[
                                                         @"蒸桑拿蒸馒头不争名利，弹吉它弹棉花不谈感情",
                                                         @"女人因为成熟而沧桑，男人因为沧桑而成熟",
                                                         @"男人善于花言巧语，女人喜欢花前月下",
                                                         @"笨男人要结婚，笨女人要减肥",
                                                         @"爱与恨都是寂寞的空气,哭与笑表达同样的意义",
                                                         @"男人的痛苦从结婚开始，女人的痛苦从认识男人开始",
                                                         @"女人喜欢的男人越成熟越好，男人喜欢的女孩越单纯越好。",
                                                         @"做男人无能会使女人寄希望于未来，做女人失败会使男人寄思念于过去",
                                                         @"我很优秀的，一个优秀的男人，不需要华丽的外表，不需要有渊博的知识，不需要有沉重的钱袋",
                                                         @"世间纷繁万般无奈，心头只求片刻安宁"
                                                         ]];
    }
    return _arrModelData;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _chatName;
    
    [self someSet];
    [self messModelArr];
    
    // 监听键盘出现的出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)someSet{
    
    showTableViewH=[UIScreen mainScreen].bounds.size.height-statusH-self.inputViewH.constant;
    //  NSLog(@"%f",self.inputViewH.constant);
    self.customTableView.frame=CGRectMake(0, statusH, [UIScreen mainScreen].bounds.size.width, showTableViewH);
   // NSLog(@" self.customTableView.frame=%@", self.customTableView);
    self.inputMess.delegate=self;//设置UITextField的代理
    self.inputMess.returnKeyType=UIReturnKeySend;//更改返回键的文字 (或者在sroryBoard中的,选中UITextField,对return key更改)
    self.inputMess.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:222.0/255.0f green:222.0/255.0f blue:221.0/255.0f alpha:1.0f]];
    self.customTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [bgView setBackgroundColor:[UIColor colorWithRed:222.0/255.0f green:222.0/255.0f blue:221.0/255.0f alpha:1.0f]];
    [self.customTableView setBackgroundView:bgView];
    [self.customTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.customTableView setShowsVerticalScrollIndicator:NO];
}

#pragma mark 得到Cell上面的Frame的模型
-(void)messModelArr{
    NSString *strPath=[[NSBundle mainBundle]pathForResource:@"dataPlist.plist" ofType:nil];//得到Plist文件里面的数据
    NSArray *arrData=[NSArray arrayWithContentsOfFile:strPath];
    
    for (NSDictionary *dict in arrData) {
        
        dataModel *model = [dataModel DictionWithMessInfo:dict];
        
        BOOL timeIsEqual;
        
        if (self.arrTimeData) {
            //  判断上一个模型时间是否和现在的相等
            timeIsEqual = [self timeIsEqual:model.time];
        }
        modelFream *freamModel = [[modelFream alloc]initWithFreamModel:model timeIsEqual:timeIsEqual];//将模型里面的数据转为Frame,并且判断时间是否相等
        
        [self.arrTimeData addObject:freamModel];//添加Frame的模型到数组里面

    }
}

#pragma mark UITableViewDelegate UITableViewDatasources

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrTimeData.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EdgeCustomTableViewCell *cell = [EdgeCustomTableViewCell customCreateCell:tableView];
    cell.frameModel = self.arrTimeData[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    modelFream *frameModel=self.arrTimeData[indexPath.row];
   
    return frameModel.cellHeight;
}
#pragma mark 键盘将要出现
-(void)keyboardWillShow:(NSNotification *)notifa{
    [self dealKeyboardFrame:notifa];
}
#pragma mark 键盘消失完毕
-(void)keyboardWillHide:(NSNotification *)notifa{
    [self dealKeyboardFrame:notifa];
}
#pragma mark 处理键盘的位置
-(void)dealKeyboardFrame:(NSNotification *)changeMess{
    NSDictionary *dicMess=changeMess.userInfo;//键盘改变的所有信息
    CGFloat changeTime=[dicMess[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];//通过userInfo 这个字典得到对得到相应的信息//0.25秒后消失键盘
    CGFloat keyboardMoveY=[dicMess[UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y-[UIScreen mainScreen].bounds.size.height;//键盘Y值的改变(字典里面的键UIKeyboardFrameEndUserInfoKey对应的值-屏幕自己的高度)
    [UIView animateWithDuration:changeTime animations:^{ //0.25秒之后改变tableView和bgView的Y轴
        self.customTableView.frame=CGRectMake(0, statusH, [UIScreen mainScreen].bounds.size.width, showTableViewH+keyboardMoveY);
        
        self.bgView.transform=CGAffineTransformMakeTranslation(0, keyboardMoveY);
        
    }];
    //  刷新到最下面一条
    NSIndexPath *path=[NSIndexPath indexPathForItem:self.arrTimeData.count-1 inSection:0];
  
    [self.customTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];//将tableView的行滚到最下面的一行
}
#pragma mark 滚动TableView去除键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.inputMess resignFirstResponder];
}

#pragma mark TextField的Delegate send后的操作
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self sendMessInfomation:textField.text];  //发送信息
 
    return YES;
}

-(void)sendMessInfomation:(NSString *)messvalue{

    //添加一个数据模型(并且刷新表)
    //获取当前的时间
    NSDate *nowdate=[NSDate date];
    NSDateFormatter *forMatter=[[NSDateFormatter alloc]init];
    forMatter.dateFormat=@"HH:mm"; //小时和分钟
    NSString *nowTime=[forMatter stringFromDate:nowdate];
    
    NSMutableDictionary *dicValues=[NSMutableDictionary dictionary];
    dicValues[@"imageName"]=@"boy";
    dicValues[@"desc"]=messvalue;
    dicValues[@"time"]=nowTime; //当前的时间
    dicValues[@"person"]=[NSNumber numberWithBool:1]; //转为Bool类型
    
    dataModel *mess = [dataModel DictionWithMessInfo:dicValues];
    
//    NSLog(@"mess = %@",mess);
    
    modelFream *frameModel=[modelFream modelFrame:mess timeIsEqual:[self timeIsEqual:nowTime]]; //判断前后时间是否一致
    
    [self.arrTimeData addObject:frameModel];
  
    [self.customTableView reloadData];
    
    self.inputMess.text=nil;
    
    
    //自动回复就是再次添加一个frame模型
    
    int num=arc4random()%(self.arrModelData.count); //获取数组中的随机数(数组的下标)
    
    NSMutableDictionary *dicAuto=[NSMutableDictionary dictionary];
    dicAuto[@"imageName"]=@"girl";
    dicAuto[@"desc"]=[self.arrModelData objectAtIndex:num];
    dicAuto[@"time"]=nowTime;
    dicAuto[@"person"]=[NSNumber numberWithBool:0]; //转为Bool类型
    
    dataModel *messAuto=[dataModel DictionWithMessInfo:dicAuto];
    
    modelFream *frameModelAuto=[modelFream modelFrame:messAuto timeIsEqual:[self timeIsEqual:nowTime]];//判断前后时候是否一致
  
    [self.arrTimeData addObject:frameModelAuto];
   
    [self.customTableView reloadData];
   
    //  刷新到最下面一条
    NSIndexPath *path=[NSIndexPath indexPathForItem:self.arrTimeData.count-1 inSection:0];
  
    [self.customTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
  
}

#pragma mark 判断前后时间是否一致
-(BOOL)timeIsEqual:(NSString *)comStrTime{
    
    modelFream *frame=[self.arrTimeData lastObject];
    
    NSString *strTime=frame.dataModel.time; //frame模型里面的NSString时间
  
    if ([strTime isEqualToString:comStrTime]) { //比较2个时间是否相等
        return YES;
    }
    return NO;
}

@end
