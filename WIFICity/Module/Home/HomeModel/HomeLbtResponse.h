//
//  HomeLbtResponse.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

//"imgUrl": "http://wifi.hktfi.com/upload/plug-in/accordion/images/分布式2.jpg",
//"px": "1",
//"pathUrl": null,
//"id": "8a2bf9ef5fb91eee015fd8762eba01dd",
//"mark": "admin"
@interface HomeLbtResponse : WIModel

@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,copy)NSString *px;
@property (nonatomic,copy)NSString *pathUrl;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *mark;
@property (nonatomic,copy)NSString *newsImgUrl;

@end
