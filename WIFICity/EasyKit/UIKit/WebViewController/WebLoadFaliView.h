//
//  WebLoadFaliView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/9/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WebLoadFailReloadBlock)(void);
@interface WebLoadFaliView : UIView

@property (weak, nonatomic) IBOutlet UIButton *reTryBtn;
@property (nonatomic,copy)WebLoadFailReloadBlock reloadBlock;
- (IBAction)retryLoadData:(id)sender;


@end
