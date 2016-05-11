//
//  main.m
//  List 16-9
//
//  Created by 张思琦 on 15/6/28.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>



int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSURL *myURL = [NSURL URLWithString:@"http:classroomM.com"];
        
        NSString *myHomePage = [NSString stringWithContentsOfURL:myURL encoding:NSASCIIStringEncoding error:NULL];
        
        NSLog(@"%@", myHomePage);
        
        
        //insert code here...
        NSLog(@"Hello, World!");

               
        
        
    }
    return 0;
}
