//
//  CompanySortTopView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseSortItemView.h"
typedef void(^TapAction)(NSInteger index,EaseSortItemView *view);

@protocol EaseDropMenuDelegate <NSObject>

-(UIView *)dropContentViewForItem:(NSInteger)index;

- (void)dropContentTapActionForItem:(NSInteger)index;

- (void)reloadContentView:(NSInteger)index;

@end

@interface EaseDropMenu : UIView

+ (instancetype)topViewWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray frame:(CGRect)frame;

@property (nonatomic,copy)NSArray *itemArray;
@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *imageArray;
@property (nonatomic,copy)TapAction tapBlock;
@property (nonatomic,weak)id <EaseDropMenuDelegate>delegate;

// UI parameter
@property (nonatomic,assign)float contentViewHeight;

- (void)hideDropView;

@end
