//
//  GaoXinNewS.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/27.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeNews.h"
typedef NS_ENUM(NSInteger,GapXinNewsType) {
    GaoXinNewsTongzhi = 1,
    GGaoXinNewsBumengDontai = 2,
    GGaoXinNewsMingzhen = 3,
    GGaoXinNewsDangfeng = 4,
    GGaoXinNewsFagui = 5,
    GGaoXinNewsGuoJiaZhengche = 6,
    GGaoXinNewsShengshiZzhengche = 7,
    GGaoXinNewsZhengfuCaigou =8,
    GGaoXinNewsCaiGouGouMulu = 9,
    GGaoXinNewsCaiGouGonGao = 10,
    GGaoXinNewsZhongbiaoGonggao = 11,
    GGaoXinNewsFeibiaoGonggao = 12,
    GGaoXinNewsGongChengZhaoBiao  = 13,
    GGaoXinNewsZhaobiaoGonggao = 14,
    GGaoXinNewsZhongbiaoGonggi = 15,
    GGaoXinNewsZhengDiChaiqian = 16,
    GGaoXinNewsZhengiGonggao = 17,
    GGaoXinNewsChaiqianBuchang = 18,
    GGaoXinNewsLuguXinwen = 19,
    GGaoXinNewsMeitiJujiao = 20
 
};
@interface GaoXinNewS : HomeNews

@property (nonatomic,copy)NSString *gxq_agency;
@property (nonatomic,copy)NSString *gxq_article_number;
@property (nonatomic,copy)NSString *gxq_create_date;
@property (nonatomic,copy)NSString *gxq_details;
@property (nonatomic,copy)NSString *gxq_genre_type;
@property (nonatomic,copy)NSString *gxq_img_src;
@property (nonatomic,copy)NSString *gxq_img_type;
@property (nonatomic,copy)NSString *gxq_quotation;
@property (nonatomic,copy)NSString *gxq_theme_type;
@property (nonatomic,copy)NSString *gxq_title;
@property (nonatomic,copy)NSString *gxq_type;
@property (nonatomic,copy)NSString *gxq_news_type;

@property (nonatomic,copy)NSArray *gxq_image_array;

//"gxq_agency" : "长沙高新区",
//"gxq_article_number" : "其他",
//"gxq_create_date" : "2018-07-24",
//"gxq_details"
//"gxq_genre_type" : "其他",
//"gxq_img_src" : null,
//"gxq_img_type" : "0",
//"gxq_news_type" : "2",
//"gxq_quotation" : "00612781-1/2018-01349",
//"gxq_theme_type" : "",
//"gxq_title" : "关于转发市经信委《关于组织开展2018年湖南省移动互联网重点企业认定工作的通知》的通知",
//"gxq_type" : "1",
//"id" : "4028813c64d953c00164d95536b50079"

- (BOOL)danTu;

@end
