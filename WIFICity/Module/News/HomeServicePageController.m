//
//  HomeServicePageController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/21.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeServicePageController.h"
#import "WINewsInfoViewController.h"

@interface HomeServicePageController ()

@end

@implementation HomeServicePageController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIViewController *)easePageController:(EasePageController *)viewController AtIndex:(NSInteger)index {
    WINewsInfoViewController *sub = [[WINewsInfoViewController alloc]init];
    EasePageModel *model = [EasePageModel new];
    model.index = index;
    model.title = [NSString stringWithFormat:@"标题%ld",index];
    model.modelName = @"HomeNews";
    model.cellClass = @"HomeNewsOneCell";
    sub.pageModel = model;
    return sub;
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
