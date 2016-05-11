//
//  SQClearCacheCell.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/2/24.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQClearCacheCell.h"
#import <SDWebImage/SDImageCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface SQClearCacheCell ()

@property (nonatomic, strong) NSString *customCacheFilePath;

@end

@implementation SQClearCacheCell

- (NSString *)customCacheFilePath{

    if (_customCacheFilePath == nil) {
        //获取default文件路径
        NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
        _customCacheFilePath = [cachesPath stringByAppendingPathComponent:@"default"];
    }
    return _customCacheFilePath;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        //设置cell的内容为正在计算缓存的状态
        //设置文本
        self.textLabel.text = @"清除缓存(正在计算缓存大小)";
        //设置右边的view
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        //关闭cell的交互功能
        self.userInteractionEnabled = NO;

        
        //获取self的一个弱引用指针
        __weak typeof(self) weakSelf = self;
        
        //设置cell的内容为计算完毕后的状态
        //在子线程中进行缓存大小的计算
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            //用于延缓线程的代码(可消除)
            [NSThread sleepForTimeInterval:5.0];

            
            //获取SDImageCache的缓存大小
            unsigned long long size = [self.customCacheFilePath fileSiez01];
            size += [[SDImageCache sharedImageCache] getSize];
            
            //如果cell被销毁就应当停止下面的计算
            if (weakSelf == nil) {
                return;
            }
            
            
            
            //判断文件大小决定生成的文本
            NSString *text;
            if (size >= pow(10, 9)) { //size > 1GB
                text = [NSString stringWithFormat:@"清除缓存(%.2f GB)",size / pow(10, 9)];
            } else if(size >= pow(10, 6)){ //size > 1MB
                text = [NSString stringWithFormat:@"清除缓存(%.2f MB)",size / pow(10, 6)];
            }else if(size >= pow(10, 3)){ //size > 1KB
                text = [NSString stringWithFormat:@"清除缓存(%.2f KB)",size / pow(10, 3)];
            }else {
                text = [NSString stringWithFormat:@"清除缓存(%.2llu B)",size];
            }
            
            //返回到主线程修改cell的UI界面
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新文本
                weakSelf.textLabel.text = text;
                //清空右边的指示器
                weakSelf.accessoryView = nil;
                //显示右边的箭头
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
                //添加tap手势
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearCache)];
                [weakSelf addGestureRecognizer:tap];
                
                //重新开启cell的交互功能
                weakSelf.userInteractionEnabled = YES;
            });
        });

    }
    return self;
}

- (void)clearCache{
    SQLOGFUNC;
    
    //弹出指示器
    [SVProgressHUD showWithStatus:@"正在清除缓存" maskType:SVProgressHUDMaskTypeBlack];
    
    
    //清除缓存
    //要获得正确的删除的顺序,才能保证HUD消失的同时,缓存删除干净
    //主要思路
    //1先删除SDImageCache中的缓存,
    //2删除自定义文件中的缓存
    //3取消HUD弹框,刷新cell文字内容
    
    //1 删除SDImageCache中的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
        //2 删除自定义文件中的缓存,耗时操作放在子线程中执行
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //删除文件
            NSFileManager *manager = [NSFileManager defaultManager];
            [manager removeItemAtPath:self.customCacheFilePath error:nil];
            [manager createDirectoryAtPath:self.customCacheFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            
            //回到主线程消除HUD弹框
            dispatch_async(dispatch_get_main_queue(), ^{
                //停止2秒
                [NSThread sleepForTimeInterval:2.0];
                
                //隐藏HUD
                [SVProgressHUD dismiss];

                //刷新cell的文本内容
                self.textLabel.text = @"清除缓存(0 B)";
            });
        });
    }];
    
}

- (void)dealloc{
    SQLOGFUNC;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)self.accessoryView;
    [indicatorView startAnimating];
    
}

@end
