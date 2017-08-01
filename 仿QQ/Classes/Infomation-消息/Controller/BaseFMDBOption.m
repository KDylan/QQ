//
//  BaseFMDBOption.m
//  fmdb测试
//
//  Created by comit on 2017/7/13.
//  Copyright © 2017年 comit. All rights reserved.
//

#import "BaseFMDBOption.h"

@implementation BaseFMDBOption{
    
    FMDatabaseQueue *fmdb_queue;
}
//  初始化数据库并且拿到表名称
-(void)initFMDB:(NSString *)dbName{
    
    NSString *DocumentDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    //  stringByAppendingPathComponent在后面加上/使之成为完整路径
    NSString *path = [DocumentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",dbName]];
    fmdb_queue = [FMDatabaseQueue databaseQueueWithPath:path];
}
//  删除数据表（传入删除sql语句）
-(BOOL)do_delete_sql:(NSString *)sql{
    
    __block BOOL isSuccess = NO;
    //  首先进行数据库判断
    FMDBQuickCheck(fmdb_queue);
    {
        [fmdb_queue inDatabase:^(FMDatabase *db) {
           isSuccess= [db executeUpdate:sql];
        }];
    
    }
    return isSuccess;
    
}
//  判断语句是否执行成功
-(BOOL)do_sql:(NSString *)sql isSuccess:(BOOL)isSuc{
    __block BOOL isSuccess = NO;
    
    FMDBQuickCheck(fmdb_queue);{
        
        [fmdb_queue inDatabase:^(FMDatabase *db) {
            if (isSuc) {
               isSuccess= [db executeUpdate:sql];
            }
        }];
    }
    return isSuccess;
}
//  判断查询结果是否成功（FMResultSet 查询合集）
-(FMResultSet *)do_sql_2:(NSString *)sql isSuccess:(BOOL)isSuc{
    
   __block FMResultSet *resultSet;
    
    FMDBQuickCheck(fmdb_queue);{
        
        [fmdb_queue inDatabase:^(FMDatabase *db) {
            if (isSuc) {
               resultSet= [db executeQuery:sql];
            }else{
            
            }
          //  [resultSet close];
        }];
    }
    return resultSet;
}


//  判断是否成功（占位符操作）
-(BOOL)do_sql_3:(NSString *)sql WithArgumentsInArray:(NSArray *)arguments{
    
/*
 @try
 {
 // 业务逻辑
 }
 @catch (异常类型名1 ex)
 {
 //异常处理代码
 }
 @catch (异常类型名2 ex)
 {
 //异常处理代码
 }
 // 可以捕捉 N 个 异常 ...
 @finally
 {
 //回收资源
 }
 */
     __block BOOL isSuccess = NO;
    @try {
        FMDBQuickCheck(fmdb_queue)
        [fmdb_queue inDatabase:^(FMDatabase *db) {
            isSuccess = [db executeUpdate:sql withArgumentsInArray:arguments];
        }];
    } @catch (NSException *exception) {
         NSLog(@"Exception:%@\r\n",[exception description]);
    } @finally {
        //
    }
    return isSuccess;
}

-(FMResultSet *)do_sql_4:(NSString *)sql withArgumentInarray:(NSArray *)arguments{
  
    __block FMResultSet *resultSet;
      FMDBQuickCheck(fmdb_queue);
    [fmdb_queue inDatabase:^(FMDatabase *db) {
        resultSet = [db executeQuery:sql withArgumentsInArray:arguments];
    }];
    return resultSet;
}

-(BOOL)do_sql5:(NSString *)sql withArgumentsInArray:(NSArray *)arguments db:(FMDatabase *)db{
   return [db executeUpdate:sql withArgumentsInArray:arguments];
}

-(FMResultSet *)do_sql_6:(NSString *)sql isSelect:(BOOL)isSel db:(FMDatabase *)db{
    
  __block  FMResultSet *resultSet;
    
    FMDBQuickCheck(fmdb_queue)
    
    if (isSel) {
        [fmdb_queue inDatabase:^(FMDatabase *db) {
           resultSet =  [db executeQuery:sql];
        }];
    }
    return resultSet;
}

//  判断某张表是否存在
-(BOOL)selectTableIsExit:(NSString *)tableName{
    __block BOOL isExit = NO;
    FMDBQuickCheck(fmdb_queue);{
        
        [fmdb_queue inDatabase:^(FMDatabase *db) {
            FMResultSet *res = [db executeQuery:[NSString stringWithFormat:@"select count(*) as c from sqlite_master where type ='table' and name ='%@'",tableName]];
            int count=0;
            while ([res next]) {
                count = [res intForColumnIndex:0];//  0开始查询
            }
            [res close];
            
            if (count>0) {
                isExit = YES;
            }
        }];
    }
    
    return isExit;
}

-(void) close{
    [fmdb_queue close];
    fmdb_queue=nil;
}

-(FMDatabaseQueue*) getQueue{
    return fmdb_queue;
}















@end
