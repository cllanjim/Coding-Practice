//
//  main.m
//  List 10-4
//
//  Created by 张思琦 on 15/6/13.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        unsigned int w1 = 0xa0a0a0a0, w2 = 0xffff0000, w3 = 0x00007777;
        
        NSLog(@"%x %x %x", w1 & w2, w1 | w2, w1 ^ w2);
        NSLog(@"%x %x %x", ~w1, ~w2, ~w3);
        NSLog(@"%x %x %x", w1 ^ w2, w1 ^ ~w2, w1 | w2 | w3);
        NSLog(@"%x %x", w1|w2&w3, w1|w2&-w3);
        NSLog(@"%x %x",~(~w1 & ~w2), ~( ~w1 | ~w2));
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
