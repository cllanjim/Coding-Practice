//
//  Fraction.h
//  Programming in Objective-C
//
//  Created by 张思琦 on 15/6/11.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#ifndef Programming_in_Objective_C_Fraction_h
#define Programming_in_Objective_C_Fraction_h

#import <Foundation/Foundation.h>

//Fraction类
@interface Fraction : NSObject;

-(void) print;
-(void) setNumerator: (int) n;
-(void) setDenominator: (int) b;
-(int) numerator;
-(int) denominator;
-(double) convertToNum;

@end
#endif
