//
//  NewsSearchNoneCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/8/8.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsSearchNoneCell : UITableViewCell

@property (nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)NSInteger count;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
