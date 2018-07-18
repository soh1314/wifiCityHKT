//
//  CompanySortTopView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EaseDropMenu.h"
#import "EasyAnimation.h"

#define kCompanySortEdgeColor  [UIColor colorWithHexString:@"#F1F1F1"]
#define kCompanySortEdgeHeight 14

@interface EaseDropMenu()

@property (nonatomic,strong)UIView *dropContainerView;
@property (nonatomic,strong)UIView *dropContentView;
@property (nonatomic,strong)UIView *backGroundView;
@property (nonatomic,strong)UIImageView *currentIndicator;
@property (nonatomic,assign)CGFloat dropDownViewWidth;
@property (nonatomic,assign)CGFloat menuBarHeight;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,assign)NSInteger tapIndex;
@property (nonatomic,assign)BOOL popContentView;
@property (nonatomic,assign)NSInteger menuCount;


@end

@implementation EaseDropMenu

+ (instancetype)topViewWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray frame:(CGRect)frame {
    EaseDropMenu *sortView = [[EaseDropMenu alloc]initWithFrame:frame];
    sortView.titleArray = [titleArray copy];
    sortView.imageArray = [imageArray copy];
    [sortView initUI];
    return sortView;
}

- (void)setHideArrow:(BOOL)hideArrow {
    _hideArrow = hideArrow;
    for (int i = 0; i < self.titleArray.count; i++) {
        EaseSortItemView *item = self.itemArray[i];
        item.icon.hidden = hideArrow;
    }
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (void)initUI {
    _dropDownViewWidth = [UIScreen mainScreen].bounds.size.width;
    _menuBarHeight = 44;
    _contentViewHeight = EaseDropItemContentViewHeight;
    _selectIndex = 0;
    _menuCount = self.titleArray.count;
    CGSize dropDownViewSize = CGSizeMake(_dropDownViewWidth, [UIScreen mainScreen].bounds.size.height);
    
    NSMutableArray *viewArray = [NSMutableArray array];
    CGFloat itemWidth = KSCREENW / self.titleArray.count;
    for (int i = 0; i < self.titleArray.count; i++) {
        EaseSortItemView *item = [[EaseSortItemView alloc]initWithFrame:CGRectZero];
        if (self.hideArrow) {
            item.icon.hidden = YES;
        }
        item.titleLabel.text = self.titleArray[i];
        item.icon.image = [UIImage qsImageNamed:self.imageArray[i]];
        item.icon.tag = i;
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
    
    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.menuBarHeight, dropDownViewSize.width, dropDownViewSize.height)];
    _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    _backGroundView.opaque = NO;
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
    [_backGroundView addGestureRecognizer:gesture];
    
    self.dropContainerView = [UIView new];
    self.dropContainerView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    self.dropContainerView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.menuBarHeight, dropDownViewSize.width, CGFLOAT_MIN);
    
    weakself;
    self.selectItemBlock = ^(NSInteger index,NSString *title) {
        EaseSortItemView *itemView = wself.itemArray[wself.selectIndex];
        itemView.titleLabel.text = [title copy];
    };
}

#pragma mark - showhide contentView

- (void)animateBgView:(BOOL)show complete:(void(^)(void))complete {
    if (show) {
        if (!self.backGroundView.superview) {
            [self.superview addSubview:self.backGroundView];
        }
//        [view.superview addSubview:self];
        [UIView animateWithDuration:0.2 animations:^{
            self.backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [self.backGroundView removeFromSuperview];
        }];
    }
    complete();
}

- (void)animateDropContentView:(BOOL)show complete:(void(^)(void))complete {
    if (show) {
        if (!self.dropContainerView.superview) {
            [self.superview addSubview:self.dropContainerView];
        }
        if (self.dropContentView.superview) {
            self.dropContentView.hidden = YES;
            [self.dropContentView removeFromSuperview];
        }
        if (self.delegate) {
            self.dropContentView = [self.delegate dropContentViewForItem:self.tapIndex];
        }
        [self.dropContainerView addSubview:self.dropContentView];
        self.dropContentView.frame = CGRectMake(0, 0, KSCREENW, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.dropContainerView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.dropDownViewWidth, self.contentViewHeight);
            self.dropContentView.frame = self.dropContainerView.bounds;
            if (self.delegate) {
                [self.delegate reloadContentView:self.tapIndex];
            }
 
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.dropContainerView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.dropDownViewWidth, 0);
       
        } completion:^(BOOL finished) {
            [self.dropContainerView removeFromSuperview];
        }];
    }
    complete();
}

- (void)animateIndicator:(id)indicator Forward:(BOOL)forward complete:(void(^)(void))complete {

    [self animateIndicatorImageView:(UIImageView *)indicator Forward:forward complete:complete];
}

- (void)animateIndicatorImageView:(UIImageView *)indicator Forward:(BOOL)forward complete:(void(^)(void))complete {
    NSInteger index = indicator.tag;
    EaseSortItemView *itemview= self.itemArray[index];
    if (itemview.forward != forward) {
        if (forward) {
            itemview.forward = !itemview.forward;
            indicator.transform =  CGAffineTransformMakeRotation(M_PI);
        } else {
            itemview.forward = !itemview.forward;
            indicator.transform = CGAffineTransformIdentity;
        }
    }
    complete();
}

- (void)hideDropView {
    [self backgroundTapped:nil];
}

- (void)backgroundTapped:(UITapGestureRecognizer *)tap {
    EaseSortItemView *iteview = self.itemArray[self.selectIndex];
    iteview.backgroundColor = [UIColor whiteColor];
    if (self.popContentView) {
        [self animateIdicator:self.currentIndicator background:self.backGroundView popView:self.dropContainerView forward:NO complete:^{
            self.popContentView = NO;
        }];
    }
}



- (void)animateIdicator:(id)indicator background:(UIView *)background popView:(UIView *)poview forward:(BOOL)forward complete:(void(^)(void))complete{
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateBgView:forward complete:^{
            [self animateDropContentView:forward complete:^{
                
            }];
        }];

    }];
    complete();
}

- (void)tap:(UITapGestureRecognizer *)tap {
    EaseSortItemView *view = (EaseSortItemView *)tap.view;
    view.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    self.currentIndicator = view.icon;
    NSInteger tapIndex = view.index;
    self.tapIndex = tapIndex;
    NSLog(@"点击了%ld",view.index);
    
    if (self.selectIndex != tapIndex) {
        EaseSortItemView *itemView = self.itemArray[self.selectIndex];
        itemView.backgroundColor = [UIColor whiteColor];
        if (itemView.forward) {
            [self animateIndicator:itemView.icon Forward:NO complete:^{
                itemView.forward = NO;
            }];
        }
        // 隐藏之前显示的内容
        
    }

    if (tapIndex == self.selectIndex && self.popContentView) {
        view.backgroundColor = [UIColor whiteColor];
        [self animateIdicator:view.icon background:self.backGroundView popView:self.dropContainerView forward:NO complete:^{
            self.popContentView = NO;
        }];
    } else {
        view.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        [self animateIdicator:view.icon background:self.backGroundView popView:self.dropContainerView forward:YES complete:^{
            self.popContentView = YES;
        }];
       
    }
     self.selectIndex = tapIndex;
    if (self.tapBlock) {
        self.tapBlock(view.index,view);
    }
    
}

@end
