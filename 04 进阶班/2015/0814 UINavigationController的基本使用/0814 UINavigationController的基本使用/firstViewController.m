//
//  firstViewController.m
//  
//
//  Created by 张思琦 on 15/8/14.
//
//

#import "firstViewController.h"
#import "secondViewController.h"

@interface firstViewController ()

@property (weak, nonatomic) IBOutlet UIButton *firstToSecond;
@end

@implementation firstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)firstToSecond:(id)sender {
    
    //1.创建第二个ViewController
    secondViewController *secondView = [[secondViewController alloc] initWithNibName:@"secondViewController" bundle:nil];
    
    //2. push到第二个ViewController
    [self.navigationController pushViewController:secondView animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
