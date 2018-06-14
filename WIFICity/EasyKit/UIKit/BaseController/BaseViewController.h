//
//  BaseViewController.h
//  TRGFShop
//
//  Created by 刘仰清 on 2017/9/5.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseNoDataModel.h"
#import "UIViewController+EasyUtil.h"

@interface BaseViewController : UIViewController

@property (nonatomic,strong)EaseNoDataModel *nodataModel;
@property (nonatomic,strong)UIScrollView *noDataSuperView;
@property (nonatomic,assign)BOOL noNet;

- (void)reloadDataWhenNetRecover;

- (void)setNoDataViewWithBaseView:(UIView *)view; // 目前支持scrollview 和 tableview

@end
