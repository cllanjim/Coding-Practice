//
//  UIBarButtonItem+SQBarButtonItemExtension.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "UIBarButtonItem+SQBarButtonItemExtension.h"

@implementation UIBarButtonItem (SQBarButtonItemExtension)

+ (instancetype)sq_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //进过@selector()返回的参数类型为SEL
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    return [[self alloc] initWithCustomView:button];;
}

@end
