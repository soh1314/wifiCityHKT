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
    newsCtrl.bgImage = [WifiPanelTopView shotWithView:ctrl.view];
    [ctrl.navigationController presentViewController:newsCtrl animated:YES completion:nil];
    
}

+ (UIImage *)shotWithView:(UIView *)view{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size, NO, [UIScreen mainScreen].scale);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}


@end


