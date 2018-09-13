//
//  WIStartAdsView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/9/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIStartAdsView.h"

@implementation WIStartAdsView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.bgView = [UIImageView new];
    NSString *imageUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"HKT_WelcomeImageUrl_key"];
    if (!imageUrl) {
        imageUrl = @"http://wifi.hktfi.com/upload/plug-in/accordion/hktorgimg/20180810143551LmgccbQK.png";
    }
    [self.bgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    self.bgView.frame = self.bounds;
    [self addSubview:self.bgView];
    
    self.skipBtn = [[ATCountdownButton alloc] initWithFrame:CGRectMake(KSCREENW-60, 30, 40, 40)];
    self.skipBtn.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    [self.skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [self.skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.skipBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [self.skipBtn setProgressTrackColor:[UIColor redColor]];
    [self.skipBtn setProgressColor:[UIColor lightGrayColor]];
    [self.skipBtn addTarget:self action:@selector(skip:) forControlEvents:UIControlEventTouchUpInside];
    self.skipBtn.layer.cornerRadius = 20.0f;
    self.skipBtn.layer.masksToBounds = YES;
    self.skipBtn.progressWidth = 2.0;
    [self addSubview:self.skipBtn];
}

- (void)skip:(id)sender {
    if (self.skipBlock) {
        self.skipBlock();
    }
}

@end
