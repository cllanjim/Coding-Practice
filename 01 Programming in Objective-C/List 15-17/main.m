//
//  main.m
//  List 15-17
//
//  Created by 张思琦 on 15/6/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableDictionary *glossary = [NSMutableDictionary dictionary];
        
        glossary[@"abstract class"] = @"A class defined so other classes can inherit from it";
        glossary[@"adopt"] = @"To implement all the methods defined in a protocol";
        glossary[@"archiving"] = @"Storing an object for later ues";
        
    
        NSLog(@"abstract class : %@",glossary[@"abstract class"]);
        NSLog(@"adopt : %@", glossary[@"adopt"]);
        NSLog(@"archiving : %@", glossary[@"archiving"]);
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
