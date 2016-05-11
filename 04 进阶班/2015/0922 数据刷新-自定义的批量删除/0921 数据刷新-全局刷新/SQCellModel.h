//
//  SQCellModel.h
//  0921 数据刷新-全局刷新
//
//  Created by 张思琦 on 15/9/21.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQCellModel : NSObject
@property (nonatomic, strong) NSString *winePicture;
@property (nonatomic, strong) NSString *winePrice;
@property (nonatomic, strong) NSString *wineName;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

@end
