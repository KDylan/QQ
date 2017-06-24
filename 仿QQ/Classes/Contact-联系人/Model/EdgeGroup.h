//
//  EdgeGroup.h
//  tableViewcell
//
//  Created by Edge on 2017/5/20.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EdgeContacts;
@interface EdgeGroup : NSObject
/** 分组ID */
@property (nonatomic, copy) NSString *group_id;
/** 分组名称 */
@property (nonatomic, copy) NSString *group_name;
/** 分组类型(1表示未分组, 2表示自定义分组) */
@property (nonatomic, assign) NSInteger group_type;
/** 成员个数(患者个数) */
@property (nonatomic, assign) NSInteger member_num;

@property(nonatomic,strong)EdgeContacts *contacts;

+(instancetype)groupWithDiction:(NSDictionary *)groupDict;

@end
