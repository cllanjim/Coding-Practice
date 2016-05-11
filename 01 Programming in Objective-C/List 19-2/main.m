//
//  main.m
//  List 19-2
//
//  Created by 张思琦 on 15/7/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary *glossary;
        
        glossary = [NSDictionary dictionaryWithContentsOfFile:@"glossary"];
        
        for (NSString *key in glossary) {
            NSLog(@"%@ : %@", key,glossary[key]);
        }
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
