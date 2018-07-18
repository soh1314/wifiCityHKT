//
//  EaseNavBar.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/18.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EaseNavBar.h"

@implementation EaseNavBar

- (id)initWithFrame:(CGRect)frame {
    if (self  = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addScrollviewKVO];
    
}

- (void)addScrollviewKVO {
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
   
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGPoint point = self.scrollView.contentOffset;
    float y = point.y;
    if (y < 45) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}



@end
