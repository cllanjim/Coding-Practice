//
//  main.m
//  List 5-6
//
//  Created by 张思琦 on 15/6/10.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int count = 1;
        
        while ( count <= 5 ) {
            NSLog(@"%i",count);
            ++count;
       }
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
