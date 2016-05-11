//
//  NSObject+GetPropertyList.m
//  0203 自动生成属性代码
//
//  Created by 张思琦 on 16/2/3.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "NSObject+GetPropertyList.h"

@implementation NSObject (GetPropertyList)

+ (void)creatPropertyListWithDict:(NSDictionary *)dict{
    NSLog(@"%@",[NSArray class]);

    //创建用于输出的string对象
    __block NSMutableString *string = [NSMutableString string];
    //遍历字典中的key值进行转换
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //key 字典的key值
        //obj 字典的value
        //[obj class] value所对应的类型
        //@property (nonatomic, strong) type *value;

        NSLog(@"%@",[obj class]);
        
        // 类型经常变，抽出来
        NSString *type;
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            type = @"NSString";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")]){
            type = @"NSArray";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            type = @"int";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            type = @"NSDictionary";
        }
        
        // 属性字符串
        NSString *str;
        if ([type containsString:@"NS"]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;",type,key];
        }else{
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) %@ %@;",type,key];
        }
        
        // 每生成属性字符串，就自动换行。
        [string appendFormat:@"\n%@",str];
    }];

//    NSLog(@"%@", string);
}

@end
