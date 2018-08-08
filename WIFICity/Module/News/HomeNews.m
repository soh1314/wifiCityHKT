//
//  HomeNews.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeNews.h"

@implementation HomeNews

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"ID"}];
}

- (NSArray *)home_image_array {
    if (self.src_list && self.src_list.length > 0) {
        NSArray *imageArray = [self.src_list componentsSeparatedByString:@","];
        return [imageArray copy];
    } else {
        return nil;
    }

}

@end
