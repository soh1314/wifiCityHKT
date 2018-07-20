//
//  CompanyHomeSearchBar.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/7.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapActionBlock)(void);
typedef void(^SeePanoramaActionBlock)(void);
@interface CompanyHomeSearchBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIView *searchBgView;
@property (weak, nonatomic) IBOutlet UIButton *panoramaBtn;
@property (nonatomic,copy)TapActionBlock tapBlock;
@property (nonatomic,copy)SeePanoramaActionBlock seePanoramaBlock;
- (IBAction)seePanorama:(id)sender;



@end
