//
//  UIBarButtonItem+SQBarButtonItemExtension.h
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SQBarButtonItemExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
