//
//  main.m
//  List 15-10
//
//  Created by 张思琦 on 15/6/22.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressCard.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
    
        NSString *aName = @"Julia Kochan";
        NSString *aEmail = @"jewls337@axlc.com";
        AddressCard *card1 = [[AddressCard alloc] init];
        [card1 setName:aName];
        [card1 setEmail:aEmail];
        [card1 print];
    // insert code here...
    NSLog(@"Hello, World!");
    }
    return 0;
}
