//
//  FsTableView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/21.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FsTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy)NSArray *dataArray;
+ (instancetype)initWithFrame:(CGRect)frame;

@end
