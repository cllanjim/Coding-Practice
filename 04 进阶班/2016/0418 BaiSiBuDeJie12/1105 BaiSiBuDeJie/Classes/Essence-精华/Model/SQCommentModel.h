//
//  SQCommentModel.h
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/25.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQUserModel.h"


@interface SQCommentModel : NSObject

@property (nonatomic, strong) SQUserModel *user;


/** id */
@property (nonatomic, copy) NSString *ID;
/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 内容 */
@property (nonatomic, strong) NSString *content;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;


@end
