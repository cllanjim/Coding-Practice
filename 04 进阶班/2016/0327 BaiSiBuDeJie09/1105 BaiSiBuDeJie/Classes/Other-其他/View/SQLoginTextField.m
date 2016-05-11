//
//  SQLoginTextField.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/24.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQLoginTextField.h"
//导入运行时文件
#import "UITextField+SQTextFieldExtension.h"

static NSString * const SQPlaceholderColorKey = @"placeholderLabel.textColor";

@interface SQLoginTextField () <UITextFieldDelegate>

@property (nonatomic, strong) NSObject *observer0;
@property (nonatomic, strong) NSObject *observer1;


@end

@implementation SQLoginTextField
//awakeFromNib在控件被加载的时候调用一次,用于设置初始化属性
- (void)awakeFromNib{
    //设置光标颜色为白色
    self.tintColor = [UIColor whiteColor];
   
    //设置默认颜色为灰色
    [self setValue:[UIColor grayColor] forKeyPath:SQPlaceholderColorKey];
    
}


#pragma mark - UITextField的代理方法
- (BOOL)becomeFirstResponder{
    self.sq_placeholderColor = [UIColor whiteColor];
    
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    self.sq_placeholderColor = [UIColor grayColor];
    return [super resignFirstResponder];;
}


@end
