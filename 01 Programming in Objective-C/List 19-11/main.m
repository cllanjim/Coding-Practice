//
//  main.m
//  List 19-11
//
//  Created by 张思琦 on 15/7/5.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSData *data;
        NSMutableArray *dataArray = [NSMutableArray arrayWithObjects:
            [NSMutableString stringWithString:@"one"],
            [NSMutableString stringWithString:@"two"],
            [NSMutableString stringWithString:@"three"],
            nil
            ];
        
        NSMutableArray *dataArray2;
        NSMutableString *mStr;
        
        //使用归档器进行深层复制
        //data = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
        //dataArray2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        dataArray2 = [NSKeyedUnarchiver unarchiveObjectWithData:
                      [NSKeyedArchiver archivedDataWithRootObject:dataArray]];
        
        
        mStr = dataArray2[0];
        [mStr appendString:@"ONE"];
        
        NSLog(@"\ndataArray:");
        for (NSString *elem in dataArray) {
            NSLog(@"%@", elem);
        }
        
        NSLog(@"\ndataArray2:");
        for (NSString *elem in dataArray2) {
            NSLog(@"%@", elem);
        }
        
        
        
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
