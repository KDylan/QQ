//
//  EdgeInfoOptions.m
//  仿QQ
//
//  Created by comit on 2017/7/31.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeInfoOptions.h"
#import "SBJson.h"
#import "dataModel.h"
#import "modelFream.h"
@implementation EdgeInfoOptions{
    
    BaseFMDBOption *mFMDBOption;
    EdgeInfoOptions *infoOptions;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        mFMDBOption = [[BaseFMDBOption alloc]init];
        
        [mFMDBOption initFMDB:@"chatData"];
    }
    return self;
}

/**
 删除所有的表
 */
-(BOOL)deleteAllTable{
    if (!infoOptions) {
        infoOptions = [[EdgeInfoOptions alloc]init];
    }
    NSString* sql = @"delete from chatData";
    return [mFMDBOption do_sql:sql isSuccess:YES];
}
/**
 删除表
 */
-(BOOL)deleteTable:(NSString *)tableName{
    if (!infoOptions) {
        infoOptions = [[EdgeInfoOptions alloc]init];
    }
    NSString *sql = [NSString stringWithFormat:@"drop table %@",tableName];
    
    return [mFMDBOption do_delete_sql:sql];
}

/**
 判断表是否存在
 
 @param tableName 表名称
 @return bool
 */
-(BOOL) selectTableIsExist:(NSString*)tableName{
    return [mFMDBOption selectTableIsExit:tableName];
}
/**
 创建表
 */
-(BOOL)createDataTable{
    
    if (![self selectTableIsExist:@"chatData"]) {//  判断表是否存在
        
    NSString *sql = @"CREATE TABLE chatData(id Integer primary key autoincrement,imageName text,desc text,time text,person Booean)";
        // 判断是否执行成功
        return [mFMDBOption do_sql:sql isSuccess:YES];
    }else{
        
        return NO;
    }
}
/**
 数据插入
 */
-(BOOL)saveDataForImage:(NSString *)imageName desc:(NSString *)desc time:(NSString *)time person:(BOOL)Person{

      NSString *sql=[NSString stringWithFormat:@"insert into chatData(imageName,desc,time,person) values('%@','%@','%@',%i)",imageName,desc,time,Person];
      BOOL isExit=[mFMDBOption do_sql:sql isSuccess:YES];
        return isExit;
}

/**
 查询所有数据

 @return NSMUArr
 */
-(NSMutableArray *)selectDataFormDataBase{
    
    NSString *sql;
    sql=[NSString stringWithFormat:@"select * from chatData"];
    
    FMResultSet *resultSet = [mFMDBOption do_sql_2:sql isSuccess:YES];
    
    if(!resultSet){
        return nil;
    }
    
    NSMutableArray* UN_InfoArray=[[NSMutableArray alloc]init];
    self.UN_InfoArray = UN_InfoArray;
    
    dataModel * data_Model = [[dataModel alloc]init];
    
    while ([resultSet next]) {
        
        data_Model.imageName = [resultSet stringForColumn:@"imageName"];//  0行开始查找(第一行)
        data_Model.desc = [resultSet stringForColumn:@"desc"];
        data_Model.time = [resultSet stringForColumn:@"time"];
        data_Model.person = [resultSet boolForColumn:@"person"];
        
        BOOL timeIsEqual;
        //  判断上一个模型时间是否和现在的相等
        timeIsEqual = [self timeIsEqual:data_Model.time];
        
        modelFream *freamModel = [[modelFream alloc]initWithFreamModel:data_Model timeIsEqual:timeIsEqual];//将模型里面的数据转为Frame,并且判断时间是否相等
       
        [UN_InfoArray addObject:freamModel];
     
        
        //  获取存放路径-> 存档到temp文件下
        NSString *path = NSTemporaryDirectory();
        //  拼接文件
        NSString *fileName =[path stringByAppendingPathComponent:@"archive.plist"];
        //  进行归档
        [NSKeyedArchiver archiveRootObject:data_Model toFile:fileName];
        
        //  解档
        data_Model = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
       // NSLog(@"解档-----%@-%@-%@-%i",data_Model.imageName,data_Model.desc,data_Model.time,data_Model.person);
    }
    
    [resultSet close];
    
    return UN_InfoArray;

}

-(BOOL)timeIsEqual:(NSString *)comStrTime{
    
    modelFream *frame=[self.UN_InfoArray lastObject];
    
    NSString *strTime=frame.dataModel.time; //frame模型里面的NSString时间
    
    if ([strTime isEqualToString:comStrTime]) { //比较2个时间是否相等
        return YES;
    }
    return NO;
}

@end
