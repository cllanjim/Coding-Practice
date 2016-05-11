//
//  ViewController.m
//  Fraction_Calculator
//
//  Created by 张思琦 on 15/7/5.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"


@interface ViewController ()

@end

@implementation ViewController
{
    char                op;
    int                 currentNumber;
    BOOL                firstOperand, isNumerator;
    Calculator          *myCalculator;
    NSMutableString     *displayString;
    
}

//display是Label的内容对象
@synthesize display;


///////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    //覆盖应用程序载入的自定义方法
    firstOperand = YES;
    isNumerator = YES;
    displayString = [NSMutableString stringWithCapacity:40];
    myCalculator = [[Calculator alloc] init];
}
///////////////////////////////////////////////////////////////////////
//点击屏幕上的按钮并响应该按钮
- (IBAction)clickDigit:(UIButton *)sender
{
    int digit = (int) sender.tag;
    
    [self processDigit:digit];
}



//根据传递进来的参数在Label上更新并重新计算currentNumber
- (void)processDigit:(int)digit
{
    currentNumber = currentNumber * 10 + digit;
    
    [displayString appendString:
                   [NSString stringWithFormat:@"%i",digit]];
    display.text = displayString;
}


//用于区分分数的分子和分母
- (IBAction)clickOver
{
    [self storeFracPart];
    isNumerator = NO;   //不是分子
    [displayString appendString:@"/"];
    display.text = displayString;
}


//用来给操作数赋值
- (void)storeFracPart
{
    if(firstOperand){
        if (isNumerator){
            myCalculator.operand1.numerator = currentNumber;
            myCalculator.operand1.denominator = 1;
        }
        else
            myCalculator.operand1.denominator = currentNumber;
    }
    else if(isNumerator){
        myCalculator.operand2.numerator = currentNumber;
        myCalculator.operand2.denominator = 1;
    }
    else{
        myCalculator.operand2.denominator = currentNumber;
        firstOperand = YES;
    }
    
    currentNumber = 0;//当操作符为'+'时,到这一步该如何理解?
}

///////////////////////////////////////////////////////////////////////

//算术操作符

- (IBAction)clickPlus
{
    [self processOp:'+'];
}

- (IBAction)clickMinus
{
    [self processOp:'-'];
}

- (IBAction)clickMultiply
{
    [self processOp:'*'];
}

- (IBAction)clickDivide
{
    [self processOp:'/'];
}

//传递的参数为运算符
- (void)processOp:(char)theOp
{
    NSString *opStr;
    
    op = theOp;
    
    switch (theOp) {
        case '+':
            opStr = @"+";
            break;
        case '-':
            opStr = @"-";
            break;
        case '*':
            opStr = @"*";
            break;
        case '/':
            opStr = @"/";
            break;
    }
    
    //在计算符号出现前,没有办法将currentNumber归零,通过该方法归零
    [self storeFracPart];//存在疑惑?
    
    firstOperand = NO;
    isNumerator = YES;  //是分子
    
    [displayString appendString:opStr];
    display.text = displayString;
    
}


//////////////////////////////////////////////////////////////////////

//Misc键

- (IBAction)clickEquals
{
    if (firstOperand == NO) {
        //why??????
        [self storeFracPart];
        
        [myCalculator performOperation:op];
        
        [displayString appendString:@"="];
        [displayString appendString:
                        [myCalculator.accumulator convertToString]];
        display.text = displayString;
        
        
        currentNumber = 0;
        isNumerator = YES;
        firstOperand = YES;
        [displayString setString:@""];
    }
}


- (IBAction)clickClear
{
    isNumerator = YES;
    firstOperand = YES;
    currentNumber = 0;
    [myCalculator clear];
    
    [displayString setString:@""];
    display.text = displayString;
}

@end
