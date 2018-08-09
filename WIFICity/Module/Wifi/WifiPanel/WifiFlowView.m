//
//  WifiFlowView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiFlowView.h"

@implementation WifiFlowView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WifiFlowView" owner:self options:nil] lastObject];
        [self initUI];
        
    }
    return self;
}

- (void)initUI {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 80;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithHexString:@"#0078FF"].CGColor;
    
    
    self.loadingView = [[ALLoadingView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    self.loadingView.center = self.center;

    [self addSubview:self.loadingView];
//    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self);
//
//    }];
    self.loadingView.radius = 80;
    [self bringSubviewToFront:self.loadingView];
    self.loadingView.loadingColor = [UIColor themeColor];
    self.loadingView.hidden = YES;
}

- (void)setWifiInfo:(WIFIInfo *)wifiInfo {
    _wifiInfo = wifiInfo;
    if ([self.wifiInfo isKindOfClass:[WIFICloudInfo class]]) {
        WIFICloudInfo *info = (WIFICloudInfo *)self.wifiInfo;
        if (info.flowNumber >= 1024) {
            self.totalFlowLabel.text = [NSString stringWithFormat:@"%.2f GB",info.flowNumber/1024.0f];
        } else {
           self.totalFlowLabel.text = [NSString stringWithFormat:@"%.f MB",info.flowNumber];
        }        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.totalFlowLabel.text];
        [AttributedStr addAttribute:NSFontAttributeName
         
                              value:[UIFont systemFontOfSize:12.0]
         
                              range:NSMakeRange(self.totalFlowLabel.text.length-2, 2)];
        
        self.totalFlowLabel.attributedText = AttributedStr;
    }
}


@end
