//
//  main.m
//  List 6-8
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>


//----@interface类
@interface Calculate : NSObject

//----累加方法
-(void) setAccumulate: (double) value;
-(void) clear;
-(double) accumulate;

//----算术方法
-(void) add: (double) value;
-(void) subtract: (double) value;
-(void) multiply: (double) value;
-(void) divide: (double) value;

@end


//----@implementation

@implementation Calculate
{
    double accumulate;
}


//----累加方法
-(void) setAccumulate: (double) value
{
    accumulate = value;
}

-(void) clear
{
    accumulate = 0;
}
-(double) accumulate;
{
    return accumulate;
}

//----算术方法
-(void) add: (double) value
{
    accumulate += value;
}

-(void) subtract: (double) value
{
    accumulate -= value;
}

-(void) multiply: (double) value
{
    accumulate *= value;
}

-(void) divide: (double) value
{
    if (0 != value) {
        accumulate /= value;
    } else {
        NSLog(@"Division is zero.");
        accumulate = NAN;
    }
}
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        double      value1, value2;
        char        operator;
        Calculate *deskCal =[[Calculate alloc] init];
        
        NSLog(@"Type in your expression.");
        scanf("%lf %c %lf", &value1, &operator, &value2);
        
        [deskCal setAccumulate:value1];
        if ( '+' == operator) {
            [deskCal add:value2];
        }else if( '-' == operator){
            [deskCal subtract:value2];
        }else if ('*' == operator){
            [deskCal multiply:value2];
        }else if ('/' == operator){
//            if (0 == value2) {
//                NSLog(@"Division by zero.");
//            } else {
                [deskCal divide:value2];
//            }
        }else{
            NSLog(@"Unknown operator.");
        }
        
        NSLog(@"%.2f",[deskCal accumulate]);
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
