//
//  NewsSearchNoneCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/8/8.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "NewsSearchNoneCell.h"

@implementation NewsSearchNoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.count = 1;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.5f];
    self.bgView.clipsToBounds = YES;
    self.bgView.layer.cornerRadius = 5;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
