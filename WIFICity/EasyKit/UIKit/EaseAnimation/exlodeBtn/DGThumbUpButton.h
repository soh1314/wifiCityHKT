//
//  DGThumbUpButton.h
//  DGThumbUpButton
//
//  Created by Desgard_Duan on 16/6/9.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DGThumbUpBtnTapActionBlock)(BOOL selected);
typedef NS_ENUM(NSUInteger, DGThumbUpButtonType) {
    DGThumbUpExplosionType = 0
};

@interface DGThumbUpButton : UIButton

- (instancetype) initWithFrame: (CGRect)frame isPress: (BOOL)press;
- (void) clickButtonPress;

@property (nonatomic,copy)DGThumbUpBtnTapActionBlock tapActionBlock;
@property (nonatomic,copy)NSString *pressImageName;
@property (nonatomic,copy)NSString *unPressImageName;
@property (nonatomic,assign)BOOL forbidden;

@end
