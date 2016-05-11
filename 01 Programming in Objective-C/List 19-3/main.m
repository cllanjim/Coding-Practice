//
//  main.m
//  List 19-3
//
//  Created by 张思琦 on 15/7/4.
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
        [NSKeyedArchiver archiveRootObject:glossary toFile:@"glossary.archive"];
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
