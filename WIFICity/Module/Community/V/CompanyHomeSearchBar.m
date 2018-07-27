//
//  CompanyHomeSearchBar.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/7.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyHomeSearchBar.h"

@implementation CompanyHomeSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CompanyHomeSearchBar" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.panoramaBtn.status = MLAlignmentStatusTop;
    self.panoramaBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.panoramaBtn.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
    }];
    [self.panoramaBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    self.panoramaBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.searchBgView.clipsToBounds = YES;
    self.searchBgView.layer.cornerRadius = 5;
    self.searchBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.searchBgView addGestureRecognizer:tap];
}

- (void)tap:(UIGestureRecognizer *)tap {
    if (self.tapBlock) {
        self.tapBlock();
    }
}



- (IBAction)seePanorama:(id)sender {
    if (self.seePanoramaBlock) {
        self.seePanoramaBlock();
    }
}
@end
