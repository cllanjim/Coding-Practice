//
//  SQLoginTextField.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/24.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQLoginTextField.h"
//导入运行时文件
#import <objc/runtime.h>


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
   
    
    [self setValue:[UIColor grayColor] forKeyPath:SQPlaceholderColorKey];

    
    
//    //使用attributedString修改占位符文字属性
//    //1 设置富文本对象的属性
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    //字体颜色 UIKIT_EXTERN NSString * const NSForegroundColorAttributeName NS_AVAILABLE(10_0, 6_0);     // UIColor, default blackColor
//    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    //2 创建富文本对象
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
//    //3 将富文本对象赋值给attributedPlaceholder属性
//    self.attributedPlaceholder= attributedString;
    
 
    
//    //NSMutableAttributedString的简单使用
    
//    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:self.placeholder];
//
//    //attributed中直接添加key值即可
//    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, 1)];
//    
//    NSMutableDictionary *attr1 = [NSMutableDictionary dictionary];
//    attr1[NSBackgroundColorAttributeName] = [UIColor greenColor];
//    
//    //重置多个属性
//    [mutableAttributedString setAttributes:attr1 range:NSMakeRange(0, 1)];
//    //设置多个属性
//    [mutableAttributedString addAttributes:attr1 range:NSMakeRange(1, 1)];
//    
//    self.attributedPlaceholder= mutableAttributedString;
    
    //使用placeholderLabel属性修改占位符的颜色
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"%ld",self.subviews.count);
//        UILabel *label = self.subviews.lastObject;
//        label.textColor = [UIColor redColor];
//        
//    });
    
//    unsigned int count;
//    Ivar *ivarList = class_copyIvarList([UITextField class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = ivarList[i];
//        NSLog(@"%s",ivar_getName(ivar));
//    }
//    
//    free(ivarList);
    
    
    //使用addTarget
//    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
//    
//    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    
    //使用代理的方法来监听
//    self.delegate = self;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingDidBegin) name:UITextFieldTextDidBeginEditingNotification object:self];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingDidEnd) name:UITextFieldTextDidEndEditingNotification object:self];
    
    
    
    self.observer0 = [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidBeginEditingNotification object:self queue:[[NSOperationQueue alloc] init] usingBlock:^(NSNotification * _Nonnull note) {
        [self setValue:[UIColor whiteColor] forKeyPath:SQPlaceholderColorKey];
    }];
    
    self.observer1 = [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidEndEditingNotification object:self queue:[[NSOperationQueue alloc] init] usingBlock:^(NSNotification * _Nonnull note) {
        [self setValue:[UIColor grayColor] forKeyPath:SQPlaceholderColorKey];
    }];
    
//    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidEndEditingNotification object:self queue:[[NSOperationQueue alloc] init] usingBlock:^(NSNotification * _Nonnull note) {
//        [self setValue:[UIColor grayColor] forKeyPath:SQPlaceholderColorKey];
//        //使用完毕后销毁当前的观察者
//        [[NSNotificationCenter defaultCenter] removeObserver:observer];
//    }];
//    
//    
}

#pragma mark - addTarget与notification的配套方法

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer0];
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer1];
}

//- (void)editingDidBegin{
//    SQLOGFUNC;
//    [self setValue:[UIColor whiteColor] forKeyPath:SQPlaceholderColorKey];
//
//}
//
//
//- (void)editingDidEnd{
//    SQLOGFUNC;
//    [self setValue:[UIColor grayColor] forKeyPath:SQPlaceholderColorKey];
//
//}
//
//#pragma mark - delegate方法
////该方法控制textFiled是否能够开始编辑
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    return YES;
//}
////在方法开始编辑时调用
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [self setValue:[UIColor whiteColor] forKeyPath:SQPlaceholderColorKey];
//}
////该方法用于控制textFiled是否结束编辑
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    return YES;
//}
////在方法结束编辑时调用
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    [self setValue:[UIColor grayColor] forKeyPath:SQPlaceholderColorKey];
//}

//- (CGRect)placeholderRectForBounds:(CGRect)bounds{
//
//    NSLog(@"%@",NSStringFromCGRect(bounds));
//    return CGRectMake(0, 0, 10, 10);
//}

//使用drawPlaceHolderInRect绘制占位符文字
//- (void)drawPlaceholderInRect:(CGRect)rect{
//    //设置文字属性
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    attr[NSForegroundColorAttributeName] = [UIColor redColor];
//    
//    //方法一 使用drawRect绘制
//    [self.placeholder drawInRect:CGRectMake(0, (rect.size.height - self.font.lineHeight) * 0.5, rect.size.width, self.font.lineHeight) withAttributes:attr];
//    //方法二 使用drawAtPoint绘制
//    [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height - self.font.lineHeight) * 0.5) withAttributes:attr];
//    
//}




@end
