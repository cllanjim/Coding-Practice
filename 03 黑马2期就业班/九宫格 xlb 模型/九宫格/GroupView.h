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


//@property (nonatomic, weak)IBOutlet UIButton *iconButton;

@property (nonatomic, strong)GroupViewInfo *groupViewInfo;

//exampleOfGroupView.iconImageView.image = groupViewInfo.iconImage;
//让iconImageView中的image自动读取到GroupViewInfo中的信息


//exampleOfGroupView.iconLabel.text = groupViewInfo.name;
//让iconLabel中的text自动读取到GroupViewInfo中的信息
 

@end
