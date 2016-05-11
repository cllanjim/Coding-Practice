//
//  Complex.h
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#ifndef Programming_in_Objective_C_Complex_h
#define Programming_in_Objective_C_Complex_h
#import <Foundation/Foundation.h>

@interface Complex : NSObject

@property double real, imaginary;

- (void) print;
- (void) setReal:(double)a andImainary:(double)b;
- (Complex *)add:(Complex *)f;

@end

#endif
