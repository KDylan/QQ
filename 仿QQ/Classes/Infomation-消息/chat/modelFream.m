//
//  modelFream.m
//  自动回复
//
//  Created by Edge on 2017/5/28.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import "modelFream.h"
#import "dataModel.h"

#define timeFont [UIFont systemFontOfSize:11.0] //时间的字体大小
#define contentFont [UIFont systemFontOfSize:13.0]//聊天消息字体的大小
#define ScreenW [UIScreen mainScreen].bounds.size.width;//获取屏幕的宽度
#define distance 8 //边距
#define imageH 46 //头像的宽高

@implementation modelFream

-(instancetype)initWithFreamModel:(dataModel *)modelData timeIsEqual:(BOOL)timeBool{
    if (self = [super init]) {
        
        self.dataModel = modelData;
        
        CGFloat iphoneW = ScreenW;// 获取屏幕宽度
        // 通过时间内容计算NSString宽度
        CGSize timeSize = [modelData.time sizeWithAttributes:@{NSFontAttributeName:timeFont}];
        
        /**
         *判断两条信息前后时间是否相等
         */
        if (!timeBool) {
            //  不相等显示fream
            self.timeFrame = CGRectMake(0, 0, iphoneW, timeSize.height);
        }else{
            self.timeFrame=CGRectMake(0, 0, iphoneW, 0);
        }
        //  计算发送内容
        CGRect btnRect = [modelData.desc boundingRectWithSize:CGSizeMake(iphoneW*0.6,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:contentFont} context:nil];

        /**
         *   判断谁发的话；男的发的在右边否则在左边
         */
        if (modelData.person) {
            //  计算头像fream
            self.headImageFrame = CGRectMake(iphoneW-distance-imageH, CGRectGetMaxY(self.timeFrame)+distance, imageH, imageH);
            //按钮内容的Frame(因为在CustomTableViewCell 里面设置了btnFrame里面文字的titleEdgeInsets边距都为20,所以,宽和高都要+20*2,X-20*2)
             self.btnFrame=CGRectMake(iphoneW-distance-imageH-distance-btnRect.size.width-20*2, CGRectGetMaxY(self.timeFrame)+distance, btnRect.size.width+20*2, btnRect.size.height+20*2);
        } else{
            
            self.headImageFrame=CGRectMake(distance, CGRectGetMaxY(self.timeFrame)+distance,imageH, imageH);
            self.btnFrame=CGRectMake(distance+imageH+distance, CGRectGetMaxY(self.timeFrame)+distance, btnRect.size.width+20*2, btnRect.size.height+20*2);
        }
        /**
         *  判断是否是自己发的
         */
        self.myself = modelData.person;
        
        CGFloat  cellH=MAX(CGRectGetMaxY(self.btnFrame), CGRectGetMaxY(self.headImageFrame));//比较输入的内容和头像的Y值哪个大
        self.cellHeight=cellH+distance;//返回Cell的高度
    }
    
    return self;
}

+(instancetype)modelFrame:(dataModel *)modelData timeIsEqual:(BOOL)timeBool{

    return [[self alloc]initWithFreamModel:modelData timeIsEqual:timeBool];
}

@end
