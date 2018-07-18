//
//  CompanySortItemView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EaseSortItemView : UIView

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)BOOL forward;

- (void)iconRotateDown;
- (void)iconRotateUp;

@end
