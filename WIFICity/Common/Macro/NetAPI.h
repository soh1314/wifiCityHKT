//
//  NetAPI.h
//  TRGFShop
//  Created by 刘仰清 on 2017/9/4.
//  Copyright © 2017年 trgf. All rights reserved.

#ifndef NetAPI_h
#define NetAPI_h
#if NEIWANG
#define	kUrlHost @"http://192.168.1.103:9090/wifi-city-api" //测试服务器
#else
#define kUrlHost  @"http://192.168.1.103:9090/wifi-city-api"  //阿里云服务器 @"http://wifi.hktfi.com"  http://192.168.1.103:8080/wificity http://192.168.1.103:8080/wificity
#endif
#define minetype @"application/json"

static NSString *const WIFIHomeNewsAPI = @"/v1/news/homepage/list.do";
static NSString *const WIFIHomeNewsDetailAPI = @"/hktInformationDeliveryController.do?findById&id=";

static NSString *const GetMacOrgId = @"/ws/wifi/getOrgId.do";
static NSString *const SaveUserFlowAPI = @"/ws/third/saveFlow.do";
static NSString *const FindUserFLowAPI = @"/ws/third/findBandByUserId.do";
static NSString *const BindUserAPI = @"/ws/user/bingUser.do";
static NSString *const BindUserVerifyCodeAPI = @"/ws/user/bingPhone.do";
static NSString *const FindOTByOrgId = @"/ws/wifi/findOrgById.do";

#define kNetError @"网络正忙请检查手机网络"
#define kNetErrorCode 404
#define kNetAllSuc 0

#endif /* NetAPI_h */
