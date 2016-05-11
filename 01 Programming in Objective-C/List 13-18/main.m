//
//  main.m
//  List 13-18
//
//  Created by 张思琦 on 15/6/17.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>



int main(int argc, const char * argv[]) {
    
    
    struct entry
    {
        char *word;
        char *definition;
    };
    
    struct entry dictionary[100] =
    {
        {"aardvark", "a burrowing Ariican manmal"},
        {"abyss","a bottomless pit"},
        {"acumen","mentally sharp;knee"},
        {"addle","to become confused"},
        {"aerie","a high nest"},
        {"affix","to append;attach"},
        {"agar","a jelly made from seaweed"},
        {"ahoy","a nautical call of greeting"},
        {"aigrette","an ornamental cluster of feathers"},
        {"ajar", "partially opened"}
    };

    
        int entries = 10;
        int entryNumber;
        int lookup(struct entry dictionary[], char search[], int entries);
        
        if (argc != 2) {
            NSLog(@"No word typed on the command line");
            return (1);
        }
        
        entryNumber = lookup(dictionary, argv[1], entries);
        
        if (entryNumber != -1)
            NSLog(@"%s",dictionary[entryNumber].definition);
        else
            NSLog(@"Sorry,%s is not in my dictionary",argv[1]);
        

    return 0;
}
