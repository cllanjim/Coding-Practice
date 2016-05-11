//
//  main.m
//  List 9-3
//
//  Created by 张思琦 on 15/6/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Square.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Square *mySquare = [[Square alloc] init];
        
        //isMemberOf
        
        if ([mySquare isMemberOfClass:[Square class]] == YES) {
            NSLog(@"mySquare is a member of Suqre Class");
        }
        
        if ([mySquare isMemberOfClass:[Rectangle class]] == YES) {
            NSLog(@"mySquare is a member of Rectangle Class");
        }
        
        if ([mySquare isMemberOfClass:[NSObject class]]  == YES) {
            NSLog(@"mySquare is a member of NSObject Class");
        }
        
        //isKindOf
        if ([mySquare isKindOfClass:[Square class]] == YES) {
            NSLog(@"mySquare is a kind of Suqre Class");
        }
        
        if ([mySquare isKindOfClass:[Rectangle class]] == YES) {
            NSLog(@"mySquare is a kind of Rectangle Class");
        }
        
        if ([mySquare isKindOfClass:[NSObject class]]  == YES) {
            NSLog(@"mySquare is a kind of NSObject Class");
        }
        
        
        //respondsTo
        if ([mySquare respondsToSelector: @selector (setSide:)] == YES) {
            NSLog(@"mySquare responds to setSide:method");
        }
        
        if ([mySquare respondsToSelector: @selector (setWidth:andHeight:)] == YES) {
            NSLog(@"mySquare responds to setWidth:andHeight: method");
        }
        
        if ([mySquare respondsToSelector: @selector (alloc)] == YES) {
            NSLog(@"mySquare responds to alloc method");
        }
        
        //instancesRespondTo
        
        if ([Rectangle instancesRespondToSelector:@selector (setSide:)] == YES) {
            NSLog(@"Instance of Rectangle respond to setSide:method");
        }
        
        if ([Square instancesRespondToSelector:@selector (setSide:)] == YES) {
            NSLog(@"Instance of Square respond to setSide:method");
        }
        
        if ([Square isSubclassOfClass:[Rectangle class]] == YES) {
            NSLog(@"Square is a subclass of a rectangle");
        }
        
//        Square *sqe1 = [Square class];
//        [sqe1 class];
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
