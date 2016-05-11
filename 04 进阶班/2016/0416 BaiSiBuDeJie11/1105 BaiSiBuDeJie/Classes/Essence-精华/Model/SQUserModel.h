//
//  SQUserModel.h
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/25.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQUserModel : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 m(male) f(female) */
@property (nonatomic, copy) NSString *sex;

@end
