//
//  BindPhoneInputPhoneView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/26.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BindPhoneModel.h"

typedef void(^CloseViewBlock)(void);
typedef void(^NextActionBlock)(void);
@interface BindPhoneInputPhoneView : UIView<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTtf;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (nonatomic,strong)BindPhoneModel *bindphoneModel;
@property (nonatomic,copy)NextActionBlock nextAction;
@property (nonatomic,copy)CloseViewBlock closeBlock;

- (IBAction)next:(id)sender;
- (IBAction)close:(id)sender;
- (void)resignTtfResponder;
@end
