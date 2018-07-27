//
//  HomeServicePageController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/21.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeServicePageController.h"
#import "WINewsInfoViewController.h"
#import "WINewsPageModel.h"


@interface HomeServicePageController ()

@end

@implementation HomeServicePageController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (UIViewController *)easePageController:(EasePageController *)viewController AtIndex:(NSInteger)index {
    WINewsInfoViewController *sub = [[WINewsInfoViewController alloc]init];
    WINewsPageModel *model = [WINewsPageModel new];
    model.index = index;
    model.gxqType = index +1;
    model.title = [NSString stringWithFormat:@"标题%ld",index];
    model.modelName = @"GaoXinNewS";
    model.cellClass = @"HomeNewsOneCell";
    sub.pageModel = model;
    return sub;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
