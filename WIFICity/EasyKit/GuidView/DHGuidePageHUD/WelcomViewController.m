//
//  WelcomViewController.m
//  TRGFShop
//
//  Created by admin on 2017/12/7.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "WelcomViewController.h"
#import "DHGuidePageHUD.h"
#import "WIStartAdsView.h"
#import "WIFIValidator.h"
#import "AppDelegate.h"
@interface WelcomViewController ()

@end

@implementation WelcomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([NavManager firstEnterApp]) {
        [self disPlayStaticGuidePage];
    } else {
        [self disPlayAdvertismentPage];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
}
- (void)disPlayStaticGuidePage {
    NSArray *imageNameArray = @[@"LOne",@"LTwo",@"LThree"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:[imageNameArray copy] buttonIsHidden:NO];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];
}

- (void)disPlayAdvertismentPage {
    WIStartAdsView *adsView = [[WIStartAdsView alloc]initWithFrame:self.view.frame];
    weakself;
    [adsView.skipBtn startWithDuration:4 block:^(CGFloat time) {
        
    } completion:^(BOOL finished) {
        [wself showTabController];
    }];
    adsView.skipBlock = ^{
        [wself showTabController];
    };
    [self.navigationController.view addSubview:adsView];
}

- (void)showTabController {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate showTabController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
