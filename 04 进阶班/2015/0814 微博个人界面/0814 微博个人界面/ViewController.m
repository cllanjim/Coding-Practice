//
//  ViewController.m
//  0814 微博个人界面
//
//  Created by 张思琦 on 15/8/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

//头像栏当前高度
#define kHeadViewH 200
//头像栏最小高度
#define kHeadViewMinH 64
//标题栏的高度
#define kTabBarViewH 44

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfPhoto;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBetwennPhotoAndView;

@property (nonatomic, assign) CGFloat OriginY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/*********************************                        ******************************/
/*********************************    设置NavigationBar    ******************************/
/*********************************                        ******************************/
    // 在iOS7之后,默认会给导航控制器里所有UIScrollView顶部都会添加额外的滚动区域
    // 即从NavigationBar区域的下部才是UIScrollView的滚动区域,高度大致为64
    // 可以设置不需要添加额外滚动区域,让UIScrollView从屏幕顶部开始滚动
     self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置NavigationBar的导航条背景色为透明
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    // 设置NavigationBar的阴影背景为透明
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
/*********************************                      ******************************/
/*********************************    调整UITableView    ******************************/
/*********************************                      ******************************/

    self.OriginY = -(kHeadViewH +kTabBarViewH);
    
    //给tableView(即ScrollView)的contentSize增加边框,让tableView能够正好显示在标题栏下面
    self.tableView.contentInset = UIEdgeInsetsMake(kHeadViewH + kTabBarViewH, 0, 0, 0);
    
    
/*********************************                        ******************************/
/*********************************    设置NavigationBar    ******************************/
/*********************************                        ******************************/
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*********************************                         ******************************/
/*********************************    tableView的监听方法   ******************************/
/*********************************    压缩图片的方法         ******************************/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获得滚动时,当前view的Y坐标值
    //offset是scrollView的坐标原点减去contentView的坐标
    CGFloat currentY = scrollView.contentOffset.y;
    
    //计算出view滚动的距离
    CGFloat delta = currentY - self.OriginY;

    //计算图片应当压缩多少高度
    //头像栏当前高度   kHeadViewH = 200
    //头像栏最小高度   kHeadViewMinH = 64
    //标题栏的高度     kTabBarViewH = 44

    CGFloat headH = kHeadViewH - delta;
    //如果压缩后的高度小于了最小值要求(因为要显示NavigationBar),就要强制要求高度为64
    if (headH < kHeadViewMinH) {
        headH = kHeadViewMinH;
    }
    self.heightOfPhoto.constant = headH;
    
    //如果想让图片有速度差形式的消失
    //1 填充模式设为Aspect Fill
    //2 勾选Clip Subviews属性
    
}

/*********************************                         ******************************/
/*********************************    tableView的监听方法   ******************************/
/*********************************    移动的方法         ******************************/
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    //获得滚动时,当前view的Y坐标值
//    //offset是scrollView的坐标原点减去contentView的坐标
//    CGFloat currentY = scrollView.contentOffset.y;
//    
//    //计算出view滚动的距离
//    CGFloat delta = currentY - self.OriginY;
//
//    self.heightBetwennPhotoAndView.constant = 0 - delta;
//    
//    //计算图片应当压缩多少高度
//    //头像栏当前高度   kHeadViewH = (200
//    //头像栏最小高度   kHeadViewMinH = 64
//    //标题栏的高度     kTabBarViewH = 44
//    if (delta >= (kHeadViewH - kHeadViewMinH)) {
//        self.heightBetwennPhotoAndView.constant = - kHeadViewH + kHeadViewMinH;
//    }
//
//    
//}




/*********************************                    ******************************/
/*********************************    数据源代理方法    ******************************/
/*********************************                    ******************************/
#pragma mark - UITableViewDataSource
//多少段
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

//多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

//每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"SQ";
    //传统方法
    //1 从缓存池中取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //2 判断cell是否为空
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //3 给cell赋值
    cell.imageView.image = [UIImage imageNamed:@"icon_02"];
    cell.textLabel.text = [NSString stringWithFormat:@"Person%02zd", indexPath.row];
    cell.detailTextLabel.text = @"Hello";
    
    return cell;
}
/*********************************           ******************************/
/*********************************    end    ******************************/
/*********************************           ******************************/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
