//
//  CompanySortTopView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanySortItemView.h"
typedef void(^TapAction)(NSInteger index,CompanySortItemView *view);

@interface CompanySortTopView : UIView

+ (instancetype)topViewWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray frame:(CGRect)frame;

@property (nonatomic,copy)NSArray *itemArray;
@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *imageArray;
@property (nonatomic,copy)TapAction tapBlock;

@end
