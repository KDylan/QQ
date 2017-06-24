//
//  EdgeCustomTableViewCell.h
//  自动回复
//
//  Created by Edge on 2017/5/29.
//  Copyright © 2017年 Edge. All rights reserved.
//

#import <UIKit/UIKit.h>
@class modelFream;
@interface EdgeCustomTableViewCell : UITableViewCell
/**
 *  模型数据
 */
@property (nonatomic,strong)modelFream *frameModel;
/**
 *  创建Cell
 *
 *  @param tableView 表对象
 *
 *  @return Cell
 */
+(instancetype)customCreateCell:(UITableView *)tableView;


@end
