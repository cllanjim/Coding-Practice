//
//  GroupView.h
//  九宫格
//
//  Created by 张思琦 on 15/7/18.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

//必须写在interface之前?
@class GroupViewInfo;

@interface GroupView : UIView

//@property (nonatomic, strong)GroupViewInfo *groupViewInfo;

+ (instancetype)groupView;
+ (instancetype)groupViewWithGroupViewInfo:(GroupViewInfo *)groupViewInfo;


@end
