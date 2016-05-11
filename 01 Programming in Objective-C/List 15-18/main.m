//
//  main.m
//  List 15-18
//
//  Created by 张思琦 on 15/6/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary *glossary =
        [NSDictionary dictionaryWithObjectsAndKeys:
         @"A class defined so other classes can inherit from it",
         @"abstract class",
         @"To implement all the methods defined in a protocol",
         @"adopt",
         @"Storing an object for later ues",
         @"archiving",
         nil
        ];
        
        for (NSString *key in glossary) {
            NSLog(@"%@: %@", key, [glossary objectForKey:key]);
        }
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
