//
//  BindPhoneInputPwdView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/26.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BindPhoneModel.h"

typedef void(^CheckProtocolBlock)(void);
typedef void(^CloseViewBlock)(void);
typedef void(^RequestVerifyCodeBlock)(void);

@interface BindPhoneInputPwdView : UIView

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (nonatomic,strong)BindPhoneModel *bindphoneModel;
@property (nonatomic,copy)CloseViewBlock closeBlock;
@property (nonatomic,copy)RequestVerifyCodeBlock refreshVerifyCodeBlock;

- (IBAction)checkProtocol:(id)sender;
- (IBAction)sendVerifyCode:(id)sender;
- (IBAction)close:(id)sender;



@end
