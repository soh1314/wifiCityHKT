//
//  EaseNavBar.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/18.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EaseNavBar.h"
#import "UIViewController+EasyUtil.h"
#import "CompanyHomeSearchBar.h"
#import "UIImage+ImageEffects.h"

@implementation EaseNavBar

- (id)initWithFrame:(CGRect)frame {
    if (self  = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.bgImageView = [[UIImageView alloc]init];
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-22);
        make.width.mas_equalTo(KSCREENW);
        make.height.mas_equalTo(40);
    }];

}

- (void)setScrollView:(UIScrollView *)scrollView {
    if (_scrollView != scrollView) {
        _scrollView = scrollView;
         [self addScrollviewKVO];
    }
}

- (void)addScrollviewKVO {
//    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
   
}

- (void)dealloc {
//    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGPoint point = self.scrollView.contentOffset;
    
    float y = point.y;
    if (self.fazhi == y) {
        return;
    }
    
    if (y >= 36) {
        self.bgImageView.image = [UIImage qsImageNamed:@"square_lg.png"] ;
        
    } else {
        self.bgImageView.image = [UIImage qsImageNamed:@""];
    }
    
    if (y >= 0 && y <= 40) {
        if (self.contentView) {
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-22 + y/40.0f*18);
            }];
            CGRect frame = self.frame;
            frame.size.height = 100 - y;
            self.frame = frame;
        }
    } else if ( y > 40) {
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-4);
        }];
        CGRect frame = self.frame;
        frame.size.height = 64;
        self.frame = frame;
        
    } else {
        CGRect frame = self.frame;
        frame.size.height = 100 ;
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-22);
        }];
        self.frame = frame;
    }
    self.fazhi = y;
    if (y > 20) {
        float fazhi = (y-20)/20 > 1.0 ? 1.0 : (y-20)/20;
   
        self.layer.opacity = 1;
//        self.alpha = 1;
        if (self.context) {
            if (fazhi > 0.5) {
                self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
            } else {
//                self.backgroundColor = [UIColor clearColor];
                self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:fazhi/3.0f];
            }
            

        }
    } else {
        self.backgroundColor = [UIColor clearColor];
        if (self.context) {
        }
    
    }
    
}



@end
