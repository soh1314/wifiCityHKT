//
//  WIAdvertisementService.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/9/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIAdvertisementService.h"

@implementation WIAdvertisementService

+ (void)getAdvertiseMentData {
    [MHNetworkManager getRequstWithURL:@"http://wifi.hktfi.com/ws/wifi/findImgByOrgId.do?orgId=8a8ab0b246dc81120146dc8180ba0017" params:nil successBlock:^(NSDictionary *returnData) {
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

@end
