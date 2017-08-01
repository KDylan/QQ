//
//  dataModel.m
//  自动回复
//
//  Created by Edge on 2017/5/28.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "dataModel.h"
#import "MJExtension.h"
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

//-(NSDictionary*) transDictionary{
//    //使用MJExtension封装好的转换方法，将模型本身转换成字典对象
//    NSDictionary* dic = self.mj_keyValues;
//    
//    return dic;
//}
/**
 将数据归档
 
 @param aCoder 属性
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
     [aCoder encodeObject:self.time forKey:@"time"];
     [aCoder encodeInteger:self.person forKey:@"person"];
}
/**
 将数据解档案
 
 @param aDecoder 属性
 @return self
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
          self.time = [aDecoder decodeObjectForKey:@"time"];
          self.person = [aDecoder decodeIntegerForKey:@"person"];
    }
    return self;
}

@end
