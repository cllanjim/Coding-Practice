//
//  ViewController.h
//  Fraction_Calculator
//
//  Created by 张思琦 on 15/7/5.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic)IBOutlet UILabel *display;

- (void)processDigit:(int)digit;
- (void)processOp:(char)theOp;
- (void)storeFracPart;


//数字键
- (IBAction)clickDigit:(UIButton *)sender;

//算术操作符
- (IBAction)clickPlus;
- (IBAction)clickMinus;
- (IBAction)clickMultiply;
- (IBAction)clickDivide;

//Misc键
- (IBAction)clickOver;
- (IBAction)clickEquals;
- (IBAction)clickClear;

@end

