//
//  BaseFMDBOption.h
//  fmdb测试
//
//  Created by comit on 2017/7/13.
//  Copyright © 2017年 comit. All rights reserved.
//

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface BaseFMDBOption : NSObject

//  初始数据库
-(void)initFMDB:(NSString *)dbName;
//  删除表（传入删除语句）
-(BOOL)do_delete_sql:(NSString *)sql;
//  判断执行是否成功
-(BOOL)do_sql:(NSString *)sql isSuccess:(BOOL)isSuc;
//  判断查询结果是否成功（FMResultSet 查询合集）
-(FMResultSet *)do_sql_2:(NSString *)sql isSuccess:(BOOL)isSuc;
//  判断数据库的插入等操作是否成功
-(BOOL)do_sql_3:(NSString *)sql WithArgumentsInArray:(NSArray *)arguments;
//  判断插入删除等操作
-(FMResultSet *)do_sql_4:(NSString *)sql withArgumentInarray:(NSArray *)arguments;
//  将数据库名称传入进来
-(BOOL) do_sql5:(NSString*)sql withArgumentsInArray:(NSArray*)arguments db:(FMDatabase *)db;
-(FMResultSet*) do_sql_6:(NSString*)sql isSelect:(BOOL) isSel db:(FMDatabase *)db;
//查询某张表是否存在
-(BOOL)selectTableIsExit:(NSString *)tableName;
-(void)close;

-(FMDatabaseQueue *)getQueue;
@end
