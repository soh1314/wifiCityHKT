//
//  TableViewCellHeader.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "TableViewCellHeader.h"

@implementation TableViewCellHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCellHeader" owner:self options:nil] lastObject];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#999999"];
}

@end
