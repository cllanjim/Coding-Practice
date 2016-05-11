//
//  Fraction.h
//  Fraction_Calculator
//
//  Created by 张思琦 on 15/7/5.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Fraction : NSObject

@property int numerator, denominator;

- (void)print;
- (void)setTo:(int)n over:(int)d;
- (Fraction *)add:(Fraction *)f;
- (Fraction *)subtract:(Fraction *)f;
- (Fraction *)multiply:(Fraction *)f;
- (Fraction *)divide:(Fraction *)f;
- (void)reduce;
- (double)convertToNum;
- (NSString *)convertToString;


@end
