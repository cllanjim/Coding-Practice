//
//  StatusModel.h
//  0203 自动生成属性代码
//
//  Created by 张思琦 on 16/2/3.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusModel : NSObject

@property (nonatomic, strong) NSString *source;
@property (nonatomic, assign) int reposts_count;
@property (nonatomic, strong) NSArray *pic_urls;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, assign) int attitudes_count;
@property (nonatomic, strong) NSString *idstr;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) int comments_count;
@property (nonatomic, strong) NSDictionary *user;

@property (nonatomic, assign) NSInteger ID;


#pragma mark - 类工厂方法

- (__kindof StatusModel *)initStatusModelWithDict:(NSDictionary *)dict;
+ (__kindof StatusModel *)statusModelWithDict:(NSDictionary *)dict;



@end
