//
//  SystemMessageCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "SystemMessageCell.h"
#import "NSDate+Extend.h"
@implementation SystemMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    
}

- (void)setNotice:(WISystemNotice *)notice {
    _notice = notice;
    self.titleLabel.text = [notice.title copy];
    self.contentLabel.text = [notice.details copy];
//    self.timeLabel.text = [NSDate timeStringFromTimestamp:notice.dates formatter:@"yyyy-MM-dd HH:mm"];
    self.timeLabel.text = @"2018.6.8";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
