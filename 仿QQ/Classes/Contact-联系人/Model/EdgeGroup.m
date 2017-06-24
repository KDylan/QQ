

//
//  EdgeGroup.m
//  tableViewcell
//
//  Created by Edge on 2017/5/20.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "EdgeGroup.h"

@implementation EdgeGroup

+(instancetype)groupWithDiction:(NSDictionary *)groupDict{
    
    EdgeGroup *group = [[EdgeGroup alloc]init];

    [group setValuesForKeysWithDictionary:groupDict];
    return group;
}
@end
