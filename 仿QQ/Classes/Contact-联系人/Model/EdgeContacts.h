//
//  EdgeContacts.h
//  tableViewcell
//
//  Created by Edge on 2017/5/20.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EdgeContacts : NSObject
/** 用户ID */
@property (nonatomic, copy) NSString *id;
/** 头像 */
@property (nonatomic, copy) NSString *head_img;
/** 姓名 */
@property (nonatomic, copy) NSString *name;
/** 描述 */
@property (nonatomic, copy) NSString *describe;
/** 活动时间(表示与该联系人的最后交流时间) */
@property (nonatomic, copy) NSString *active_time;

+(instancetype)contactWithDict:(NSDictionary *)contactDict;
@end
