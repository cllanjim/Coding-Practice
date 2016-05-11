//
//  NSString+SQExtension.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/2/23.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "NSString+SQExtension.h"

@implementation NSString (SQExtension)

- (NSUInteger)sq_fileSiez01{

    unsigned long long size = 0;
    
    //创建文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //方法一
    //用于判断是否为文件夹
    BOOL isDirectory = NO;
    
    //用于判断路径是否存在
    //self是文件路径
    //&isDirectory是用于判断路径本身是否为文件夹
    //fileExistsAtPath:isDirectory:方法返回指定文件路径是否为
    BOOL isExists = [fileManager fileExistsAtPath:self isDirectory:&isDirectory];
    
    //假如文件路径不存在就返回
    if (isExists == NO) return size;
    
    if (isDirectory) {
        //此时代表文件路径存在且是一个文件夹
        NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:self];
        //计算文件夹里面每个文件的大小
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            
            size += [fileManager attributesOfItemAtPath:fullPath error:nil].fileSize;
        }
        
    }else {
        //此时代表文件路径存在且是一个文件
        size = [fileManager attributesOfItemAtPath:self error:nil].fileSize;
    }

    return size;
}

- (NSUInteger)sq_fileSiez02{
    unsigned long long size = 0;
    
    //创建文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //方法二
    //获取文件属性
    NSDictionary *attr = [fileManager attributesOfItemAtPath:self error:nil];
    
    //假如文件路径不存在就返回
    if (attr == nil) return size;
 
    
    if ([attr.fileType isEqualToString:NSFileTypeDirectory]) {
        //说明当前路径是一个文件夹路径
        NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:self];
        //计算文件夹里面每个文件的大小
        for (NSString *subPath in enumerator) {
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            size += [fileManager attributesOfItemAtPath:fullPath error:nil].fileSize;
        }
    }else{
        //说明当前路径是一个文件
        size = attr.fileSize;
    }
    
    return size;
}

@end
