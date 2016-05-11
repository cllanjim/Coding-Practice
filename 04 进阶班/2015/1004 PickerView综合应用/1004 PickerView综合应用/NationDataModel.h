//
//  NationDataModel.h
//  1004 PickerView综合应用
//
//  Created by 张思琦 on 15/10/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NationDataModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *icon;

- (instancetype)initNationDataModelWithDict:(NSDictionary *)dict;
+ (instancetype)nationDataModelWithDict:(NSDictionary *)dict;

@end
