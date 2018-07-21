//
//  FsTableView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/21.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "FsTableView.h"

@implementation FsTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor themeTableEdgeColor];
        self.tableFooterView = [[UIView alloc]init];
        self.estimatedRowHeight = 200;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


@end
