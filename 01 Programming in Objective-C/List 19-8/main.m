//
//  main.m
//  List 19-8
//
//  Created by 张思琦 on 15/7/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Foo.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Foo *myFoo1 = [[Foo alloc] init];
        Foo *myFoo2;
        
        myFoo1.strVal = @"This is a string";
        myFoo1.intVal = 12345;
        myFoo1.floatVal = 98.6;
        
        [NSKeyedArchiver archiveRootObject:myFoo1 toFile:@"foo.arch"];
        
        myFoo2 = [NSKeyedUnarchiver unarchiveObjectWithFile:@"foo.arch"];
        NSLog(@"%@\n%i\n%g", myFoo2.strVal, myFoo2.intVal, myFoo2.floatVal);
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
