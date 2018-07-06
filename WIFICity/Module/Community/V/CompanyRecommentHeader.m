//
//  CompanyRecommentHeader.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyRecommentHeader.h"

@implementation CompanyRecommentHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CompanyRecommentHeader" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.moreBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.edgeView.backgroundColor = [UIColor colorWithHexString:@"#E3E3E3"];
}

- (IBAction)seeMore:(id)sender {
    if (self.moreBlock) {
        self.moreBlock();
    }
    
}
@end
