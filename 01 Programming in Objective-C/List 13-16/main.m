//
//  main.m
//  List 13-16
//
//  Created by 张思琦 on 15/6/16.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

void copyString(char *to, char *from)
{
    for (; * from != '\0'; ++from, ++to) {
        * to = * from;
    }
    * to = '\0';
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        void copyString (char *to, char *from);
        
        char string[]= "A string to be copied";
        char string2[50];
        
        copyString(string2, string);
        NSLog(@"%s", string2);
        
        copyString(string2, "So is this");
        NSLog(@"%s", string2);
        
        //char a[30];
        //a = "This is a good day";
        
        //char a[30] = "This is a good day.";
        
        //char *a;
        //a = "This is a good day";
        
        //      char *a = "This is a good day";
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
