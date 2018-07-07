//
//  EaseSearchBar.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapSearchBarAction)(void);
@interface EaseSearchBar : UIView

@property (nonatomic,strong)UITextField *searchTtf;
@property (nonatomic,strong)UIImageView *searchIcon;
@property (nonatomic,copy)NSString *textfieldPlaceHolderName;
@property (nonatomic,copy)TapSearchBarAction actionblock;

- (void)invokeSearch;

- (void)cancleSearch;

@end
