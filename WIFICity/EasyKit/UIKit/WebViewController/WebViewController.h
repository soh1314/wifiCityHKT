//
//  WebViewController.h
//  XHLaunchAdExample
//
//  Created by zhuxiaohui on 16/9/8.
//  Copyright © 2016年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLaunchAd
//  广告详情页

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface WebViewController : BaseViewController
@property(nonatomic,copy)NSString *URLString;
@property(nonatomic,copy)NSString *htmlWord;
@property(nonatomic,copy)NSString *newsTitle;

@end
