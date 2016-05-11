//
//  NSDate+SQDateExtension.h
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/25.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SQDateExtension)
/**
 *  是否为今年
 */
- (BOOL)sq_isThisYear;

/**
 *  是否为今天
 */
- (BOOL)sq_isToday;

/**
 *  是否为昨天
 */
- (BOOL)sq_isYesterday;

/**
 *  是否为明天
 */
- (BOOL)sq_isTomorrow;


@end
