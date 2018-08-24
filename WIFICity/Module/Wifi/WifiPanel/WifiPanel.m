//
//  WifiPanel.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiPanel.h"
#import "NavManager.h"
#import "UIViewController+EasyUtil.h"
#import "WIFIValidator.h"
@interface WifiPanel()

@property (nonatomic,assign)WINetStatus status;

@end

@implementation WifiPanel


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WifiPanel" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor colorWithHexString:@"#1E52BF"];
    self.connectWifiBtn.clipsToBounds = YES;
    self.connectWifiBtn.layer.cornerRadius = 12;
    self.connectWifiBtn.backgroundColor = [UIColor colorWithHexString:@"#0078FF"];
    [self.connectWifiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.wifiNameLabel.textColor = [UIColor colorWithHexString:@"#FFFCA4"];
    
    self.flowView = [[WifiFlowView alloc]initWithFrame:CGRectZero];
    [self.flowBgView addSubview:self.flowView];
    [self.flowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.flowBgView);
    }];
    
    self.bottomView = [[WifiPanelBottomView alloc]initWithFrame:CGRectZero];
    [self.bottomBgView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bottomBgView);
    }];
    
    self.topView = [[WifiPanelTopView alloc]initWithFrame:CGRectZero];
    [self.topBgView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.topBgView);
    }];
    [self setNetStatus:[WIFISevice netStatus]];
}

- (void)setNetStatus:(WINetStatus)status {
    _status = status;
    if (status == WINetFail || status == WINet4G ) {
        [self.connectWifiBtn setTitle:@"无线连接" forState:UIControlStateNormal];
        self.wifiNameLabel.text = @"";
    } else {
        if (([WIFISevice shared].wifiInfo &&[WIFISevice shared].wifiInfo.validated) || ![WIFISevice isHKTWifi]) {
            [self.connectWifiBtn setTitle:@"已连接" forState:UIControlStateNormal];
            NSString *wifiName = [WifiUtil getWifiName];
            if (wifiName) {
                self.wifiNameLabel.text = [NSString stringWithFormat:@"WIFI: %@",wifiName];
            }
        } else {
            [self.connectWifiBtn setTitle:@"认证" forState:UIControlStateNormal];
            NSString *wifiName = [WifiUtil getWifiName];
            if (wifiName) {
                self.wifiNameLabel.text = [NSString stringWithFormat:@"WIFI: %@",wifiName];
            }
        }

    }
    if (![WIFISevice isHKTWifi]) {
        self.bottomView.bandWidthLabel.text = @"10MB";
        self.flowView.totalFlowLabel.text = @"";
    }
    
}

- (void)setLocation:(WILocation *)location {
    _location = location;
    if (!location.city || [location.city isEqualToString:@""]) {
        self.topView.locationLabel.text = @"定位失败";
    }
    self.topView.locationLabel.text = [NSString stringWithFormat:@"%@%@",location.city,location.area];
    if (location.city) {
        [WIWeatherService getWeatherInfoWithLocation:location.city complete:^(WIWeatherInfo *weatherInfo) {
            if (weatherInfo) {
                [self setWeatherInfo:weatherInfo];
            }
        }];
    }
}

- (void)setWeatherInfo:(WIWeatherInfo *)info {
    self.topView.PMLabel.text = [NSString stringWithFormat:@"PM: %@",[info.PM copy]] ;
    self.topView.weatherLabel.text = [info.temperature copy];
    [self.topView.weatherImageView sd_setImageWithURL:[NSURL URLWithString:info.dayPictureUrl]];
    self.topView.pmImageView.hidden = NO;
}


- (void)setWifiInfo:(WIFIInfo *)wifiInfo {
    _wifiInfo = wifiInfo;
    [self.bottomView setWifiInfo:self.wifiInfo];
    [self.flowView setWifiInfo:self.wifiInfo];
    
}

- (void)refreshUI:(WIFIInfo *)info {
    [self setWifiInfo:info];
}

- (void)netChange:(WINetStatus)status wifiInfo:(WIFIInfo *)info {
    [self setNetStatus:status];
}

- (IBAction)connectWifi:(id)sender {
    if (self.status == WINetFail || self.status == WINet4G ) {
        if ([self.connectWifiBtn.titleLabel.text isEqualToString:@"认证"]) {
            [WIFIValidator shared].reconnect = YES;
            [[WIFIValidator shared]validator];
        } else {
            [NavManager showWifiGuideController:[UIViewController getCurrentVCWithCurrentView:self] ];

        }
    } else {
        [Dialog simpleToast:WIFIConnectToastWord];
    }
}
@end
