//
//  EnterpriseSquareHomeHeader.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EnterpriseSquareHomeHeader.h"

@implementation EnterpriseSquareHomeHeader

- (id)initWithFrame:(CGRect)frame {
    if ( self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIImageView *bgIcon = [[UIImageView alloc]initWithFrame:self.bounds];
    bgIcon.image = [UIImage qsImageNamed:@"square_lg"];
    bgIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    bgIcon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgIcon];
    
    self.searchBar = [[CompanyHomeSearchBar alloc]initWithFrame:CGRectZero];
    [self addSubview:self.searchBar];
    self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin   ;
    self.searchBar.hidden = YES;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.searchBar.frame = CGRectMake(16, self.bounds.size.height-64, KSCREENW-32, 44);
}

@end
