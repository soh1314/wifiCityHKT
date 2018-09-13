//
//  HomeBannerCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeBannerCell.h"
#import "NSString+Additions.h"

@implementation HomeBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    // Initialization code
}

- (void)initUI {
    _coursal = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    [self.contentView addSubview:self.coursal];
    [self.coursal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    _coursal.backgroundColor = [UIColor whiteColor];
    _coursal.pageDotColor = [UIColor clearColor];
    _coursal.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _coursal.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _coursal.autoresizesSubviews = YES;
    _coursal.autoScrollTimeInterval = 5.0;
    _coursal.autoScroll = YES;
}

- (void)setCoursalImageDataArray:(NSArray *)dataArray {
    NSMutableArray *temArray = [NSMutableArray array];
    for (int i = 0 ; i < dataArray.count; i++) {
        HomeLbtResponse *lbtresponse = dataArray[i];
        NSString *encodeUrl = [lbtresponse.imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSString *urlEncode = [NSString stringWithFormat:@"%@/%@",kUrlHost,encodeUrl];
        [temArray addObject:encodeUrl];
    }
    self.coursal.imageURLStringsGroup = [temArray copy];
    self.coursal.autoScroll = YES;
    
}

#pragma mark - cycleScroll delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.pick) {
        self.pick(index);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
