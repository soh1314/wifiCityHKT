//
//  StaticGuideViewController.m
//  TRGFShop
//
//  Created by admin on 2017/12/7.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "StaticGuideViewController.h"
#import "DHGuidePageHUD.h"
@interface StaticGuideViewController ()

@end

@implementation StaticGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setStaticGuidePage];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
}
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"启动页1.jpg",@"启动页2.jpg",@"启动页3.jpg"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:[imageNameArray copy] buttonIsHidden:YES];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];
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
