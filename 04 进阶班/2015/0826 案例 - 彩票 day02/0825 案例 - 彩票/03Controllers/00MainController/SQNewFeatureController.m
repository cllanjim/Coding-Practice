//
//  SQNewFeatureController.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQNewFeatureController.h"
#import "SQNewFeatureCell.h"

@interface SQNewFeatureController ()

@end

@implementation SQNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{

    //布局参数的生成
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    SQNewFeatureController *collectionVC = [[SQNewFeatureController alloc] initWithCollectionViewLayout:flowLayout];
    
    
    //设置collectionVC的界面大小
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    //设置collection的滚动方向为左右
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //minimumLineSpacing 根据滚动方向决定, 滚动方向的间距
    flowLayout.minimumLineSpacing = 1;
    //minimumInteritemSpacing根据滚动方向确定 , 是非滚动方向的间距
    flowLayout.minimumInteritemSpacing = 0;
    
    return collectionVC;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置界面的背景颜色
    //self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //设置界面的分页效果
    self.collectionView.pagingEnabled = YES;
    //设置页面的弹性效果
    self.collectionView.bounces = NO;
    //设置页面的滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    // 注册collectionView中的Cell
    [self.collectionView registerClass:[SQNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>
// 确定有多少section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


// 确定每个section中的cell数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

// 确定cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SQNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    NSString *imageName = [NSString stringWithFormat:@"guide%liBackground", indexPath.item + 1];
    NSLog(@"%@", imageName);

    cell.image = [UIImage imageNamed:imageName];
    
    NSLog(@"%@", cell.image);
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
