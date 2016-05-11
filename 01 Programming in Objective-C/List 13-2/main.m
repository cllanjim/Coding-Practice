//
//  main.m
//  List 13-2
//
//  Created by 张思琦 on 15/6/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        char word[6] = {'H', 'e', 'l', 'l' , 'o', '!'};
        int i;
        for (i = 0; i < 6; ++i) {
            NSLog(@"%c",word[i]);
        }
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
