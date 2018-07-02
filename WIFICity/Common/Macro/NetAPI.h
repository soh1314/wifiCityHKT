//
//  NetAPI.h
//  TRGFShop

//  Created by 刘仰清 on 2017/9/4.
//  Copyright © 2017年 trgf. All rights reserved.


#ifndef NetAPI_h
#define NetAPI_h

#if NEIWANG
#define	kUrlHost @"http://192.168.1.188/wificity" //测试服务器
#else
#define kUrlHost  @"http://wifi.hktfi.com"  //阿里云服务器
#endif
#define minetype @"application/json"

#define SavelikeAPI @"/ws/company/saveLikes.do?"
#define CancellikeAPI @"ws/company/cancelLikes.do?"
#define ComClassAPI @"/ws/company/getEntList.do?"
#define ComListAPI @"/ws/company/getCompanyList.do?"
#define FindUserByKeyAPI @"/ws/user/findUserByKey.do?"
#define GetGPSOrgIdImageAPI @"/ws/wifi/getOrgIdByGps.do?posx="
#define GetCarouseDataAPI @"/ws/wifi/findLbtByOrgId.do?orgId="

static NSString *const GetMacOrgId = @"/ws/wifi/getOrgId.do";
static NSString *const SaveUserFlowAPI = @"/ws/third/saveFlow.do";
static NSString *const FindUserFLowAPI = @"/ws/third/findBandByUserId.do";
static NSString *const BindUserAPI = @"/ws/user/bingUser.do";
static NSString *const BindUserVerifyCodeAPI = @"/ws/user/bingPhone.do";

#define kNetError @"哎呀，网络走丢了 请检查手机网络或稍后重试"
#define kNetErrorCode 404
#define kNetAllSuc 0

#endif /* NetAPI_h */
