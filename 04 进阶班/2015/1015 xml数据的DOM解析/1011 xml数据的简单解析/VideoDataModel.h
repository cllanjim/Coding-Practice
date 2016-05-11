//
//  VideoDataModel.h
//  1011 xml数据的简单解析
//
//  Created by 张思琦 on 15/10/14.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDataModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *url;

@end
