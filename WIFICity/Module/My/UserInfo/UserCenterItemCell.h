//
//  UserCenterItemCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemIcon;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

- (void)setUIStyle:(NSString *)className;

@end
