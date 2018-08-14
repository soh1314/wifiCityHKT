//
//  WIUtil.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/7.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIUtil.h"
#import "WebViewController.h"
@implementation WIUtil

+ (void)callPhone:(NSString *)phoneNumber {
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@",phoneNumber];
    CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
    if (version >= 10.0) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
    
}

+ (void)openThirdMap:(NSString *)locationName viewcontroller:(UIViewController *)contex {
    NSString *urlString = [NSString stringWithFormat:@"https://api.map.baidu.com/geocoder?address=%@&output=html&src=yourCompanyName|yourAppName",locationName];
    if (contex) {
        WebViewController *ctrl = [WebViewController new];
        ctrl.URLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [contex.navigationController pushViewController:ctrl animated:YES];
    }
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]){
//        
//        NSString *urlString = [NSString stringWithFormat:@"https://api.map.baidu.com/geocoder?address=%@&output=html&src=yourCompanyName|yourAppName",locationName];
//        if (contex) {
//            WebViewController *ctrl = [WebViewController new];
//            ctrl.URLString = urlString;
//            [contex.navigationController pushViewController:ctrl animated:YES];
//        }
////        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//    }

}

+ (NSString *)appVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
     NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"V%@",app_Version];
}

@end
