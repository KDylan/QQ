//
//  dataModel.h
//  自动回复
//
//  Created by Edge on 2017/5/28.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataModel : NSObject

@property (nonatomic,copy)NSString *imageName;
@property (nonatomic,copy)NSString *desc;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,assign)BOOL person;

+(instancetype)DictionWithMessInfo:(NSDictionary *)dict;

@end
