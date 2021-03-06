//
//  WifiPanelTopView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiPanelTopView.h"
#import "UIViewController+EasyUtil.h"
#import "NewsSearchController.h"
@implementation WifiPanelTopView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WifiPanelTopView" owner:self options:nil] lastObject];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (IBAction)searchNews:(id)sender {
    UIViewController *ctrl = [UIViewController getCurrentVCWithCurrentView:self];
    NewsSearchController *newsCtrl = [NewsSearchController new];
    UINavigationController *newsNav = [[UINavigationController alloc]initWithRootViewController:newsCtrl];
    newsCtrl.bgImage = [WifiPanelTopView shotWithView:ctrl.view];
    [ctrl.navigationController presentViewController:newsNav animated:YES completion:nil];
    
}

+ (UIImage *)shotWithView:(UIView *)view{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size, NO, [UIScreen mainScreen].scale);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}


- (IBAction)hongbao:(id)sender {
    [Dialog simpleToast:@"当日暂无红包发放"];
}
@end


