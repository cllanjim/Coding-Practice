//
//  main.m
//  List 15-19
//
//  Created by 张思琦 on 15/6/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

//使用Printing类别,将打印方法添加到NSSet

@interface NSSet (Printing)

- (void)print;

@end


@implementation NSSet (Printing)

- (void)print{
    printf("{");
    
    for (NSNumber *element in self)
        printf(" %li ", (long) [element integerValue]);
    
    printf("}\n");
    
    
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableSet *set1 = [NSMutableSet setWithObjects:@1,@3,@5,@10,nil];
        NSSet *set2 = [NSSet setWithObjects: @-5, @100, @3, @5, nil];
        NSSet *set3 = [NSSet setWithObjects:@12, @200, @3, nil];
        
        NSLog(@"set1: ");
        [set1 print];
        NSLog(@"set2: ");
        [set2 print];
        
        //相等性测试
        if ( [set1 isEqualToSet:set2] == YES)
            NSLog(@"set1 equals set2");
        else
            NSLog(@"set1 is not equal to set2");
        
        //成员测试
        if ([set1 containsObject:@10] == YES)
            NSLog(@"set1 contains 10");
        else
            NSLog(@"set1 does not contain 10");
        
        if ([set2 containsObject:@10] == YES)
            NSLog(@"set2 contains 10");
        else
            NSLog(@"set2 does not contain 10");
        
        //在可变集合set1中添加和移除对象
        
        [set1 addObject:@4];
        [set1 removeObject:@10];
        NSLog(@"set1 after adding 4 and removing 10:");
        [set1 print];
        
        //获得两个集合的交集
        [set1 intersectSet:set2];
        NSLog(@"set1 intersect set2:");
        [set1 print];
        
        //两个集合的并集
        [set1 unionSet:set3];
        NSLog(@"set1 union set3:");
        [set1 print];
        
        
        
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
