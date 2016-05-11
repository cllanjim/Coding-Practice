//
//  main.m
//  LIst 13-6
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        void (^print_Message)(void) =
        ^(void){
            NSLog(@"Programing is fun");
        };
        
        
        print_Message();
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
