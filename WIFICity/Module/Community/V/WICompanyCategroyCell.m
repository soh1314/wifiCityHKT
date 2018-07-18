//
//  WICompanyCategroyCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/9.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WICompanyCategroyCell.h"

@implementation WICompanyCategroyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    self.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    self.companyNameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
}

- (void)setCategory:(WICompanyCategory *)category {
    _category = category;

}

@end
