//
//  NetMacro.h
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/28.
//  Copyright © 2017年 trgf. All rights reserved.
//

#ifndef NetMacro_h
#define NetMacro_h

#define kNetError @"哎呀，网络走丢了 请检查手机网络或稍后重试"
#define kNetErrorCode 404
#define kNetAllSuc 0

#define KOrderCreateFailure @"生成订单失败"

//9000    订单支付成功
//8000    正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
//4000    订单支付失败
//6001    用户中途取消
//6002    网络连接出错
//6004    支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
//其它    其它支付错误

#define KAlipaySuccessCode 9000
#define KAlipayWaitingCode 8000
#define KAlipayFailureCode  4000
#define KAlipayCancelCode  6001
#define KAlipayCancelCode  6001
#define KAlipayNetFailureCode  6002
#define KAlipayUnknownCode  6004

#define kAlipaySuccess   @"支付成功"
#define KAlipayWaiting   @"正在处理,支付结果未知,请查询商户订单列表中订单的支付状态"
#define kAlipayfailure   @"支付失败"
#define kAlipayCancle    @"支付取消"
#define kAlipayNetError   @"网络连接出错"
#define kAlipayUnkown   @"支付结果未知"



#define kNetCookieKey kAppUrl(kUrlHost, kLogin2)

#endif /* NetMacro_h */
