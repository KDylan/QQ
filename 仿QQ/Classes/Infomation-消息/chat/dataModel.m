//
//  dataModel.m
//  自动回复
//
//  Created by Edge on 2017/5/28.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "dataModel.h"

@implementation dataModel

+(instancetype)DictionWithMessInfo:(NSDictionary *)dict{
 
    dataModel *model = [[dataModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
//    model.imageName=dict[@"imageName"];
//    model.desc=dict[@"desc"];
//    model.time=dict[@"time"];
//    model.person=[dict[@"person"] boolValue]; //转为Bool类型
 //   NSLog(@"%@",model);
    return model;
}

@end
