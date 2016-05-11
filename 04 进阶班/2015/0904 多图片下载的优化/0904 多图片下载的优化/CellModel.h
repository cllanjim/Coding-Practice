//
//  CellModel.h
//  0904 多图片下载的优化
//
//  Created by 张思琦 on 15/9/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *download;

- (instancetype)initWihtDict:(NSDictionary *)dict;
+ (instancetype)cellModelWithDict:(NSDictionary *)dict;


@end
