//
//  SQTopicCell.h
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/19.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SQTopicModel;

@interface SQTopicCell : UITableViewCell

/** 帖子模型数据 */
@property (nonatomic, strong) SQTopicModel *topicModel;

@end
