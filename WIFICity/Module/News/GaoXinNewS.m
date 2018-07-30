//
//  GaoXinNewS.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/27.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "GaoXinNewS.h"

@implementation GaoXinNewS

- (BOOL)danTu {
    if ([self.gxq_img_type isEqualToString:@"0"] || [self.gxq_img_type isEqualToString:@"1"] ) {
        return YES;
    } else {
        return NO;
    }
}

- (NSArray *)gxq_image_array {
    if (!_gxq_image_array) {
        _gxq_image_array = [NSArray array];
        if (![self danTu]) {
            NSMutableArray *m_array = [NSMutableArray array];
            NSString *string1 =  [self.gxq_img_src stringByReplacingOccurrencesOfString:@"[" withString:@""];
            NSString * string2 = [string1 stringByReplacingOccurrencesOfString:@"]" withString:@""];
            NSArray *imageArray =  [[string2 copy] componentsSeparatedByString:@","];
            for (int i = 0; i < imageArray.count; i++) {
                NSString *string = imageArray[i];
                [m_array addObject:string];
            }
            _gxq_image_array = [m_array copy];
        }
    }
    return _gxq_image_array;
}

+ (NSArray *)gaoxinNewsTitleArray {
    return @[@"通知公告",@"部门动态",@"民政事务",@"党风廉政",
             @"法规公文",@"国家政策",@"省市政策",@"政府采购",
             @"采购目录",@"采购公告",@"中标公告",@"废标公告",
             @"工程招标",@"招标公告",@"中标公示",@"征地拆迁",
             @"征地公告",@"拆迁补偿公示",@"麓谷新闻",@"媒体聚焦"];
}

@end
