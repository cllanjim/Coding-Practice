//
//  GroupViewInfo.m
//  九宫格
//
//  Created by 张思琦 on 15/7/16.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "GroupViewInfo.h"

@implementation GroupViewInfo



- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
//        self.name = dict[@"name"];
//        self.icon = dict[@"icon"];
        [self setValuesForKeysWithDictionary:dict];
    }
    
    //        GroupViewInfo *groupViewInfo = [[GroupViewInfo alloc] init];
    //        groupViewInfo.name = dict[@"name"];
    //        groupViewInfo.icon = dict[@"icon"];
    return self;
}


+ (instancetype)groupViewInfo:(NSDictionary *)dict
{
   return  [[self alloc] initWithDict:dict];
}

//重写iconImage的getter方法
- (UIImage *)iconImage
{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil];
//    UIImage *iconimgae = [[UIImage alloc] initWithContentsOfFile:path];
    if (_iconImage == nil) {
        _iconImage = [UIImage imageNamed:self.icon];
    }
    
    
    return _iconImage ;
}

+ (NSArray *)classOfGroupViewInfo
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil];
    NSArray *classOfPlist = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *classOfModel  = [NSMutableArray array];
    
    for (NSDictionary *instanceOfPlist in classOfPlist) {
        GroupViewInfo *instanceOfModel = [GroupViewInfo groupViewInfo:instanceOfPlist];
        
        [classOfModel addObject:instanceOfModel];
    }
    return classOfModel;
}

@end
