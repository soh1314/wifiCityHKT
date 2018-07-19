//
//  EasePageSubViewController.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/19.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasePageModel.h"
#import "HomeNews.h"
#import "HomeNewsOneCell.h"

@interface EasePageSubViewController : UIViewController


@property (nonatomic,strong)EasePageModel *pageModel;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)EaseTableView *tableView;

- (void)loadData:(NSInteger)index refresh:(BOOL)refresh;

@end
