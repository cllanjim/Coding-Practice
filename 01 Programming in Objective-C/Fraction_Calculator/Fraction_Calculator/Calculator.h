//
//  Calculator.h
//  Fraction_Calculator
//
//  Created by 张思琦 on 15/7/5.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Fraction.h"

@interface Calculator : NSObject

@property (strong, nonatomic)Fraction *operand1;
@property (strong, nonatomic)Fraction *operand2;
@property (strong, nonatomic)Fraction *accumulator;

- (Fraction *)performOperation:(char)op;
- (void)clear;

@end
