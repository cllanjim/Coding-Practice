//
//  ViewController.m
//  0412 PhotoKit拓展练习
//
//  Created by 张思琦 on 16/4/12.
//  Copyright © 2016年 SketchK. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}


#pragma mark - 获取目标相簿
- (void)getAllImageFromTargetAssetCollection{
    
    //获取自定义相簿
    PHFetchResult <PHAssetCollection *> *assetCollectionDIY = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    //遍历相簿
    for (PHAssetCollection *assetCollection in assetCollectionDIY) {
        [self enumerateAssetsInAssetCollection:assetCollection original:YES];
    };
    
    //获取Camera Roll相簿
    PHFetchResult <PHAssetCollection *> *assetCollectionCameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    //便利相簿
    for (PHAssetCollection *assetCollection in assetCollectionCameraRoll) {
         [self enumerateAssetsInAssetCollection:assetCollection original:YES];
    };
    
}

#pragma mark - 遍历相簿中的图片
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original{

    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.synchronous = YES;

    //获取assetCollection相簿中的所有asset对象
    PHFetchResult <PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        //是否获取原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        //从asset中获取图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
          
            //result对象为目标image
            //此处可以将图片展示到collectionView中对应的位置,供用户选择
            
        }];
    }
}



#pragma mark - 获取Camera Roll中的所有图片
- (void)getAllCameraRollImageWithPhotoKit{
    //获取图片资源集合
    PHFetchResult <PHAsset *> *result = [PHAsset fetchAssetsWithOptions:nil];

    for (PHAsset *asset in result) {
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            //result对象为目标image
            //此处可以将图片展示到collectionView中对应的位置,供用户选择
        }];
    };
}

#pragma mark - 使用ImagePickController获取图片
- (void)getImageWithImagePickController{
    //如果UIImagePickerController不能打开指定类型的资源,就直接跳出
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return ;
    };
    
    //创建pickController
    UIImagePickerController *pickController = [[UIImagePickerController alloc] init];
    pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickController.delegate = self;
    
    [self presentViewController:pickController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    //通过键值获取image对象
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
}



@end
