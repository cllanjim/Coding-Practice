//
//  main.m
//  List 15-16
//
//  Created by 张思琦 on 15/6/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableDictionary *glossary = [NSMutableDictionary dictionary];
        
        //存储3个条目在类别中
        [glossary setObject:@"A class defined so other classses can inherit formit"
                     forKey:@"abstract class"];
        
        [glossary setObject:@"To implement all the methods defined in a protocol"
                     forKey:@"adopt"];
        
        [glossary setObject:@"To implement all the methods defined in a protocol"
                     forKey:@"adopt"];
        
        [glossary setObject:@"Storing an object for later use"
                     forKey:@"archiving"];
        
        //检索并显示它们
        NSLog(@"abstract class: %@", [glossary objectForKey:@"abstract class"]);
        NSLog(@"adopt : %@", [glossary objectForKey:@"adopt"]);
        NSLog(@"archiving : %@", [glossary objectForKey:@"archiving"]);
        
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
