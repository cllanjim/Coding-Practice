//
//  NSObject+performSelector.h
//  1224 NSInvocation
//
//  Created by 张思琦 on 15/12/25.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (performSelector)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;


@end
