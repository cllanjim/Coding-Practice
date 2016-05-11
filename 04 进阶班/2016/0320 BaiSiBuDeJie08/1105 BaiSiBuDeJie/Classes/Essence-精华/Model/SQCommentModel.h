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
@property (nonatomic, strong) NSString *content;


@end
