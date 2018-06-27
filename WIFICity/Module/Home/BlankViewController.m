//
//  BlankViewController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/27.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BlankViewController.h"

@interface BlankViewController ()
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation BlankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlackNavBar];
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage qsImageNamed:@"expected_page"];
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

@end
