//
//  EnterPriseSquareAreaCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/18.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EnterPriseSquareAreaCell.h"
#import "WICousalItemView.h"
#import "UIView+SDExtension.h"

@implementation EnterPriseSquareAreaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.carousel];
    [self.carousel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    [self.carousel reloadData];
}

- (iCarousel *)carousel {
    if (!_carousel) {
        _carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        _carousel.delegate = self;
        _carousel.dataSource = self;
        _carousel.type = iCarouselTypeCustom;
        _carousel.pagingEnabled = YES;
    }
    return _carousel;
}

#pragma mark - carousel datasource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 4;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    if (view == nil) {
        view = [[WICousalItemView alloc]initWithFrame:CGRectMake(0, 10, 180, 90)];
        view.center = self.carousel.center;
        WICousalItemView *itemView = (WICousalItemView *)view;
        itemView.iconView.image = [UIImage qsImageNamed:@"new_material"];
    }

    return view;
}

#pragma mark - item 宽度
- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 155;
}

-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.85f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    return CATransform3DTranslate(transform, offset * self.carousel.itemWidth * 1.4, 0.0, 0.0);
}

#pragma mark - 可以设置可滑动显示的内容可以循环显示，还可以设置每个元素的高度，每次显示多少个元素
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    
    switch (option) {
        case iCarouselOptionWrap:
            return YES;
            break;
        case iCarouselOptionSpacing:
            return value * 1.f;
            break;
        default:
            return value * 0.8;
            break;
    }
    
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
