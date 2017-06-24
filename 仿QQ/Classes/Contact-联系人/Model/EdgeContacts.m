//
//  EdgeContacts.m
//  tableViewcell
//
//  Created by Edge on 2017/5/20.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeContacts.h"

@implementation EdgeContacts
+(instancetype)contactWithDict:(NSDictionary *)contactDict{
  
    EdgeContacts *contact = [[EdgeContacts alloc]init];
    
    [contact setValuesForKeysWithDictionary:contactDict];
    return contact;
}
@end
