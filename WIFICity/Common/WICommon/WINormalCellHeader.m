//
//  WINormalCellHeader.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/24.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WINormalCellHeader.h"

@implementation WINormalCellHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WINormalCellHeader" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    self.backgroundColor = [UIColor whiteColor];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
}

@end
