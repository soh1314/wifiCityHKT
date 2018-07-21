//
//  WifiPanelTopView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WifiPanelTopView : UIView

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *PMLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pmImageView;

@end
