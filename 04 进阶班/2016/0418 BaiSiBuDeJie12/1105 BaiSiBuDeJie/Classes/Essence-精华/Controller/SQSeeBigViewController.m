//
//  SQSeeBigViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/29.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQSeeBigViewController.h"
#import <UIImageView+WebCache.h>
#import "SVProgressHUD.h"
#import <Photos/Photos.h>


@interface SQSeeBigViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation SQSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //创建ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;

    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    //创建imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    
    //[imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.large_image]];
    
    //保存按钮应当在图片下载完毕后才能被点击
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //如果图片为空,就弹出提示框
        if (image == nil) {
            [SVProgressHUD showErrorWithStatus:@"图片下载失败"];
            //弹出提示框后跳出该block,不执行block后面的代码
            return;
        }
        //如果图片不为空,就让保存按钮enable
        self.saveButton.enabled = YES;
    }];
    
    [scrollView addSubview:imageView];
    
    //计算imageView的尺寸
    imageView.sq_width = scrollView.sq_width;
    imageView.sq_height = self.topicModel.height * imageView.sq_width / self.topicModel.width;
    imageView.sq_x = 0;
    
    //根据imageView的height决定其Y值
    if(imageView.sq_height > scrollView.sq_height){
        //如果图片超出屏幕,就从头显示
        imageView.sq_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.sq_height);
    }else{
        //如果图片没有超出屏幕,就居中显示
        imageView.sq_y = (scrollView.sq_height - imageView.sq_height) * 0.5;
    }

    //计算缩放比例
    CGFloat scale = self.topicModel.width / scrollView.sq_width;
    
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
    
}

#pragma mark - button功能键
- (IBAction)clickBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)clickSaveButton:(id)sender {
    //使用UIImageWriteToSavedPhotosAlbum保存图片
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    SQLOG(@"保存功能马上就有了");
    //PhotoKit框架下的保存功能
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    //对不同的授权状态设定相应的操作
    if (status == PHAuthorizationStatusNotDetermined) {//用户没有确定授权状态
      //弹出授权的请求框
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            //判断用于进行的操作
            if (status == PHAuthorizationStatusAuthorized) {
                //保存图片的操作
                [self saveImage];
            }else{
                [SVProgressHUD showErrorWithStatus:@"您已经拒绝百思不得姐访问照片应用中的数据.\n如想重新开启访问权限.\n请进入[设置-隐私-照片-xxx]打开访问开关."];
            }
        }];
        
    }else if (status == PHAuthorizationStatusRestricted ){//用户没有权限获取数据
        [SVProgressHUD showInfoWithStatus:@"由于相关权限的设定,您无法获取照片应用中的数据"];
    }else if (status == PHAuthorizationStatusDenied ){//用户拒绝获取数据
        [SVProgressHUD showErrorWithStatus:@"您已经拒绝百思不得姐访问照片应用中的数据.\n如想重新开启访问权限.\n请进入[设置-隐私-照片-xxx]打开访问开关."];
    }else if (status == PHAuthorizationStatusAuthorized ){//用户授权获取数据
            //保存图片
        [self saveImage];
    }
    
    
}

#pragma mark - 保存图片的方法

static NSString *SQAssetCollectionTitle = @"SQ的相册";

- (void)saveImage{
    //图片的标识符
    __block NSString *assetLocalIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //1.保存图片到CameraRoll中
        PHAssetCreationRequest *assetCreationRequest = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image];
        //获取asset的标识符
        assetLocalIdentifier = assetCreationRequest.placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"创建图片至Camera Roll相簿中失败"];
            return ;
        }
        
        //2.创建自定义相簿
        __block PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        //createdAssetCollection方法只负责创建PHAssetCollection对象
        //该方法不负责提示功能,这样功能更清晰
        
        //如果创建的PHAssetCollection对象为空
        if (createdAssetCollection == nil) {
            //如果返回值为空,就说明相簿创建失败
            [self showError:@"创建自定义相簿失败"];
            return;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //获取图片
            PHFetchResult *assetArray = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil];
            PHAsset *asset = assetArray.lastObject;
            
            //创建修改自定义相簿的请求
            PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            
            //像请求中添加图片
            //addAssets中的元素要遵循NSFastEnumeration协议
            [assetCollectionChangeRequest addAssets:@[asset]];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [self showError:@"添加图片到自定义相簿失败"];
                return;
            }else{
                [self showSuccess:@"添加图片到自定义相簿成功"];
            }
        }];
    }];
}

- (void)saveImageOriginal{
    //相簿的标识符
    __block NSString *assetCollectionLocalIdentifier = nil;
    
    __block NSString *assetLocalIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //1.保存图片到CameraRoll中
        PHAssetCreationRequest *assetCreationRequest = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image];
        //获取asset的标识符
        assetLocalIdentifier = assetCreationRequest.placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"创建图片至Camera Roll相簿中失败"];
            return ;
        }
        
        //由于performChanges方法是异步执行,
        //所以要执行下一步操作前,必须保证上一步操作执行完毕
        //因此要在completionHandler这个block中执行相关操作
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //2.创建自定义相簿
            PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:SQAssetCollectionTitle];
            //获取assetCollection的标识符
            assetCollectionLocalIdentifier = assetCollectionChangeRequest.placeholderForCreatedAssetCollection.localIdentifier;
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [SVProgressHUD showErrorWithStatus:@"创建自定义相簿失败"];
                return;
            }
            
            //同理要在这个block中执行最后的代码
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                
                //3.添加图片到自定义相簿中
                //获取自定义相簿
                PHFetchResult *assetCollectionArray= [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil];
                PHAssetCollection *assetCollection = assetCollectionArray.lastObject;
                //获取图片
                PHFetchResult *assetArray = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil];
                PHAsset *asset = assetArray.lastObject;
                
                //创建修改自定义相簿的请求
                PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
                
                //像请求中添加图片
                //addAssets中的元素要遵循NSFastEnumeration协议
                [assetCollectionChangeRequest addAssets:@[asset]];
                
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                //判断图片保存的最终状态
                if (success == NO) {
                    [self showError:@"添加图片到自定义相簿失败"];
                    return;
                }else{
                    [self showSuccess:@"添加图片到自定义相簿失败"];
                }
            
            }];
        }];
    }];
    

}


- (PHAssetCollection *)createdAssetCollection{
    //获取手机中的相簿集合
    PHFetchResult <PHAssetCollection *> *assetCollections = [PHAssetCollection  fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //如果有同名的相簿就返回同名的相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:SQAssetCollectionTitle]) {
            //通过判断已有相簿的标题名与当前相簿的标题名是否相同来获取目标相簿
            return assetCollection;
        }
    }
    
    //如果没有同名的相簿就创建自定义相簿
    
    //用于保存创建相簿后的错误信息
    NSError *error = nil;
    //用于保存自定义相簿的标识符
    __block NSString *assetCollectionLocalIdentifier = nil;
   
    //使用同步的方式获取创建的PHAssetCollection对象
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        //发送创建自定义相簿的请求
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:SQAssetCollectionTitle];
        //获取该自定义相簿的标识符
        assetCollectionLocalIdentifier = request.placeholderForCreatedAssetCollection.localIdentifier;

    } error:&error];
    
    //如果创建失败就直接返回
    if(error) return nil;
    
    //获取对应的相簿
    PHAssetCollection *assetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
    
    return assetCollection;
}

#pragma mark - 包装SVProgressHUD的方法到主线程中执行
- (void)showSuccess:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (void)showError:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}

#pragma mark - 保存图片的监听方法
///*
// *  @param image       保存到CameraRoll中的图片
// *  @param error       保存出现错误的信息
// *  @param contextInfo 保存图片时附加的信息
// */
//- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
//    if (error) {//保存图片失败后弹出提示框
//        [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
//    }else{//成功保存图片后弹出提示框
//        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
//    }
//}


#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}


@end
