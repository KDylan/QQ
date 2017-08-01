//
//  EdgeInfoOptions.h
//  仿QQ
//
//  Created by comit on 2017/7/31.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseFMDBOption.h"
#import "dataModel.h"
@interface EdgeInfoOptions : NSObject
@property(nonatomic,strong)NSMutableArray *UN_InfoArray;
/**
 删除所有的表
 */
-(BOOL)deleteAllTable;

/**
 删除表

 @param table 表名
 */
-(BOOL)deleteTable:(NSString *)tableName;
/**
 创建表
 */
-(BOOL)createDataTable;
/**
 判断表是否存在
 
 @param tableName 表名称
 @return bool
 */
-(BOOL) selectTableIsExist:(NSString*)tableName;
/**
 数据插入和更新
 */
-(BOOL)saveDataForImage:(NSString *)imageName desc:(NSString *)desc time:(NSString *)time person:(BOOL)Person;

/**
 查询所有数据

 @return NSMUArr
 */
-(NSMutableArray*)selectDataFormDataBase;
@end
