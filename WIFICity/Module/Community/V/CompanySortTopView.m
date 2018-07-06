//
//  CompanySortTopView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanySortTopView.h"
#import "EasyAnimation.h"
#define kCompanySortEdgeColor  [UIColor colorWithHexString:@"#F1F1F1"]
#define kCompanySortEdgeHeight 14


@implementation CompanySortTopView

+ (instancetype)topViewWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray frame:(CGRect)frame {
    CompanySortTopView *sortView = [[CompanySortTopView alloc]initWithFrame:frame];
    sortView.titleArray = [titleArray copy];
    sortView.imageArray = [imageArray copy];
    [sortView initUI];
    return sortView;
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)initUI {
    NSMutableArray *viewArray = [NSMutableArray array];
    CGFloat itemWidth = KSCREENW / self.titleArray.count;
    for (int i = 0; i < self.titleArray.count; i++) {
        CompanySortItemView *item = [[CompanySortItemView alloc]initWithFrame:CGRectZero];
        item.titleLabel.text = self.titleArray[i];
        item.icon.image = [UIImage qsImageNamed:self.imageArray[i]];
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(itemWidth);
            make.left.mas_equalTo(self).mas_offset(i*itemWidth);
        }];
        if (i!= 0) {
            UIView *edgeView = [UIView new];
            [self addSubview:edgeView];
            [edgeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(1);
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(kCompanySortEdgeHeight);
                make.left.mas_equalTo(self).mas_offset(i*itemWidth);
            }];
            edgeView.backgroundColor = kCompanySortEdgeColor;
        }
        [viewArray addObject:item];
        item.index = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [item addGestureRecognizer:tap];
    }
    self.itemArray =  [viewArray copy];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    CompanySortItemView *view = (CompanySortItemView *)tap.view;
    NSLog(@"点击了%ld",view.index);
    if (view.secondClick) {
        [view iconRotateDown];
    } else {
        [view iconRotateUp];
    }
    view.secondClick = view.secondClick ? NO : YES;

    if (self.tapBlock) {
        self.tapBlock(view.index,view);
    }
    
}

@end
