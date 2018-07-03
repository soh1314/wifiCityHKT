//
//  WIFIAnnotation.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/3.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIFIAnnotation.h"

@implementation WIFIAnnotation

- (NSString *)title {
    return self.model.mac;
}

- (NSString *)subtitle {
    return self.model.wifiName;
}

@end
