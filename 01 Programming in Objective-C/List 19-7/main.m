//
//  main.m
//  List 19-7
//
//  Created by 张思琦 on 15/7/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressBook.h"

int main(int argc, const char * argv[]) {
    AddressBook *mybook;
    @autoreleasepool {
        
        mybook = [NSKeyedUnarchiver unarchiveObjectWithFile:@"addrbook.arch"];
        [mybook list];
        
        // insert code here...
        NSLog(@"Hello, World!");
    
    return 0;
    }
}
