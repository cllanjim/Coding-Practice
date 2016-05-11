//
//  SQTopicModel.h
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/18.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "SQUserModel.h"
#import "SQCommentModel.h"

@interface SQTopicModel : NSObject

typedef NS_OPTIONS(NSUInteger, SQTopicType) {
    /** 全部 */
    SQTopicTypeAll = 1,
    /** 图片 */
    SQTopicTypePicture = 10,
    /** 段子 */
    SQTopicTypeWord = 29,
    /** 声音 */
    SQTopicTypeVoice = 31,
    /** 视频 */
    SQTopicTypeVideo = 41
};

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;


/** 图片的真实宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的真实高度 */
@property (nonatomic, assign) CGFloat height;

//最热评论模块
//@property (nonatomic, strong) NSArray *top_cmt;
//最热评论模块
//@property (nonatomic, strong) NSArray <SQCommentModel *> *top_cmt;
@property (nonatomic, strong) SQCommentModel *top_cmt;


/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;



///** 是否为gif动画图片 */
@property (nonatomic, assign) BOOL is_gif;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/***** 额外增加的属性 - 方便开发 *****/

//模型的类型
@property (nonatomic, assign) SQTopicType type;
//cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
//图片是否为大图
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentFrame;



@end
