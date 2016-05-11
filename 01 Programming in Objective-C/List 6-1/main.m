//
//  main.m
//  List 6-1
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int number;
        
        NSLog(@"Type in you number:");
        scanf("%i", &                                                                                                                                                                                                                                                                                                                                                                                                number);
        
        if(number <= 0){
            number = - number;
        }
        
        NSLog(@"The absolute value is %i",number);
        NSLog(@"Hello, World!");
    }
    return 0;
}
