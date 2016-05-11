//
//  NSObject+Info.h
//  0203 动态添加属性
//
//  Created by 张思琦 on 16/2/3.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Info)


//此处添加属性只会实现属性的声明,并不会实现属性的具体操作内容
@property (nonatomic, strong) NSString *describe;

@end
