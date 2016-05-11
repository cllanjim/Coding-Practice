//
//  SQSectionModel.h
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/30.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQSectionModel : NSObject

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) NSArray *groupOfRowModel;

+ (instancetype)sectionModelWithHeaderTitle:(NSString *)header FooterTitle:(NSString *)footer;

@end
