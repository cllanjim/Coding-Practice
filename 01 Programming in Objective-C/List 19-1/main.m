//
//  main.m
//  List 19-1
//
//  Created by 张思琦 on 15/7/3.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary *glossary = @{
        @"abstract calss": @"A class defined so ohter classes can inherit from it.",
        @"adopt": @"To implement all the methods defined in a protocol",
        @"achiving": @"Storing an object for later use",
        };
        
        if ([glossary writeToFile:@"glossary" atomically:YES] == NO ) {
            NSLog(@"Save to file failed");
        }
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
