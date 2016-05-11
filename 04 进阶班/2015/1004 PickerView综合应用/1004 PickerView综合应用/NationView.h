//
//  NationView.h
//  1004 PickerView综合应用
//
//  Created by 张思琦 on 15/10/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NationDataModel;

@interface NationView : UIView

@property (nonatomic, strong) NationDataModel *dataModel;

+ (instancetype)nationView;
@end
