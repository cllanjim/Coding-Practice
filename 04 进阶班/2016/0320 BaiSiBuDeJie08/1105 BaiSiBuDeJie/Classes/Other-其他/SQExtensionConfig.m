//
//  SQExtensionConfig.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/26.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQExtensionConfig.h"

#import <MJExtension.h>
#import "SQTopicModel.h"
#import "SQCommentModel.h"


@implementation SQExtensionConfig

+ (void)load{
    
    //保证SQTopicModel中,top_cmt属性保存的是SQCommentModel类对象
//    [SQTopicModel mj_setupObjectClassInArray:^NSDictionary *{
//        return @{@"top_cmt" : [SQCommentModel class]};
//
//    }];
    
    //在服务器返回的数据中,top_cmt原本是一个数组且只有一个元素,
    //可以取出top_cmt数组中的元素,使其与topicModel中的top_cmt属性对应
    [SQTopicModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]"};
    }];
    
    
}


@end
