//
//  EnterpriseSquareNetAPI.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/7.
//  Copyright © 2018年 HKT. All rights reserved.
//

#ifndef EnterpriseSquareNetAPI_h
#define EnterpriseSquareNetAPI_h


static NSString *const CompanyIndustryAPI = @"/v1/corporate/industry/list.do";

static NSString *const CompanyCategoryAPI = @"/v1/corporate/tech/list.do";

static NSString *const CompanyCategoryListAPI = @"/v1/corporate/query.do";

static NSString *const CompanyCategoryBriefListAPI = @"/v1/corporate/query.do";

static NSString *const CompanySearchAPI = @"/v1/corporate/query.do";

static NSString *const CompanyCommentListAPI = @"/ws/company/findDiscussByDisId.do";

static NSString *const CompanyCommentSaveAPI = @"/v1/corporate/comment/add.do";

static NSString *const CompanyDetailAPI = @"/ws/company/findCompanyById.do";

static NSString *const CompanyLikeAPI = @"/v1/corporate/like/add.do";

static NSString *const CompanyCommentLikeAPI = @"/v1/corporate/comment/like/add.do";

static NSString *const CompanyCollectAPI = @"/ws/company/saveMake.do";

static NSString *const CompanyUnCollectAPI = @"/ws/company/cancelMake.do";


#endif /* EnterpriseSquareNetAPI_h */
