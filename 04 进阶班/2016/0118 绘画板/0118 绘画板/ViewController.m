//
//  ViewController.m
//  0118 绘画板
//
//  Created by 张思琦 on 16/1/18.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "HandleView.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 控制器上部按钮的功能
- (IBAction)clearButton:(UIBarButtonItem *)sender {
    [self.drawView clear];
}

- (IBAction)undoButton:(UIBarButtonItem *)sender {
    [self.drawView undo];
}

- (IBAction)eraseButton:(UIBarButtonItem *)sender {
    //橡皮擦功能可以理解为用白色线条绘制路径
    self.drawView.lineColor = [UIColor whiteColor];
    
}


#pragma mark - 实现从PhotoAlbum中选取图片的功能
- (IBAction)photoButton:(UIBarButtonItem *)sender {
    
    //创建系统相册的控制器
    UIImagePickerController *imagePickVC = [[UIImagePickerController alloc] init];
    //设置imagePickController的数据源
    //sourceType有三个枚举值类型
    //UIImagePickerControllerSourceTypePhotoLibrary,
    //UIImagePickerControllerSourceTypeCamera,
    //UIImagePickerControllerSourceTypeSavedPhotosAlbum
    imagePickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //设置代理
    imagePickVC.delegate = self;
    
    //modal出imagePickVC控制器
    [self presentViewController:imagePickVC animated:YES completion:nil];
    
    
}

#pragma mark - UIImagePickerControllerDelegate的代理方法
//当用户在imagePickController中选取完照片后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取用户选取的照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    /*
     info中的关键字
    UIImagePickerControllerMediaType        // an NSString (UTI, i.e. kUTTypeImage)
    UIImagePickerControllerOriginalImage    // a UIImage
    UIImagePickerControllerEditedImage      // a UIImage
    UIImagePickerControllerCropRect         // an NSValue (CGRect)
    UIImagePickerControllerMediaURL         // an NSURL
    UIImagePickerControllerReferenceURL     // an NSURL that references an asset in the AssetsLibrary framework
    UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
    UIImagePickerControllerLivePhoto        // a PHLivePhoto
    */
    //dismiss当前的pickViewVC
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //此处的逻辑是在选取图片后,在drawView上添加一个名为handleView图层,可以进行移动,旋转,缩放等操作
    
    HandleView *handleView = [[HandleView alloc] initWithFrame:self.drawView.frame];
    [self.view addSubview:handleView];
    
    
    //为handView的image赋值
    handleView.image = image;

}


#pragma mark - SaveButton的功能实现
- (IBAction)saveButton:(UIBarButtonItem *)sender {
    //开启imageContext
    UIGraphicsBeginImageContextWithOptions(self.drawView.frame.size, NO, 0.0);
    //获取当前imageContext
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
    //获取DrawView的layer对象
    CALayer *layer = self.drawView.layer;
    //渲染图像到imageContext中
    [layer renderInContext:imageContext];
    //从imageContext中获取image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    /*******将image对象保存到系统相册中*******/
    /**
     *  UIImageWriteToSavedPhotosAlbum方法用于保存指定的image对象到系统相册中
     *
     *  @param image               需要保存的image对象
     *  @param completionTarget    保存完成事件的监听者
     *  @param completionSelector  保存完成后调用的方法
     *  @param contextInfo         可选参数，便于使用者完善保存完毕后调用的方法
     *
     *  @return 返回值为空
     */
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark - UIImageWriteToSavedPhotosAlbum指定方法的实现
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(error == nil){
        //error为nil时代表保存成功
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //设置文本内容
        hud.labelText = @"保存成功";
        //设置模式
        hud.mode = MBProgressHUDModeCustomView;
        //隐藏时候从父控件移除
        hud.removeFromSuperViewOnHide = YES;
        //1秒后自动移除
        [hud hide:YES afterDelay:1.0];
        NSLog(@"保存成功");
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //设置文本内容
        hud.labelText = @"保存失败";
        //设置模式
        hud.mode = MBProgressHUDModeCustomView;
        //隐藏时候从父控件移除
        hud.removeFromSuperViewOnHide = YES;
        //1秒后自动移除
        [hud hide:YES afterDelay:1.0];
        NSLog(@"保存失败");
    };
}

#pragma mark - 控制器下部按钮的功能
/**
 *  通过点击按钮切换DrawView的lineColor属性
 *
 *  @param sender sender 触发该方法的button
 */
- (IBAction)pickerColor:(UIButton *)sender {
    self.drawView.lineColor = sender.backgroundColor;
}


/**
 *  通过移动按钮改变DrawView的lineWidth属性
 *
 *  @param sender sender 触发该方法的slider
 */
- (IBAction)pickerWidth:(UISlider *)sender {
    self.drawView.lineWidth = sender.value;
    
}


@end
