//
//  EnterpriseSquareNetAPI.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/7.
//  Copyright © 2018年 HKT. All rights reserved.
//

#ifndef EnterpriseSquareNetAPI_h
#define EnterpriseSquareNetAPI_h


static NSString *const CompanyIndustryAPI = @"/ws/company/getIndustryList.do";

static NSString *const CompanyCategoryAPI = @"/ws/company/getEntList.do";

static NSString *const CompanyCategoryListAPI = @"/ws/company/getCompanyList.do";

static NSString *const CompanyCategoryBriefListAPI = @"/ws/company/getBriefCompanyList.do";

static NSString *const CompanySearchAPI = @"/ws/company/getCompanyList.do";

static NSString *const CompanyCommentListAPI = @"/ws/company/findDiscussByDisId.do";

static NSString *const CompanyCommentSaveAPI = @"/ws/company/saveDiscuss.do";

static NSString *const CompanyDetailAPI = @"/ws/company/findCompanyById.do";

static NSString *const CompanyLikeAPI = @"/ws/company/saveLikes.do";

static NSString *const CompanyCollectAPI = @"/ws/company/saveMake.do";

static NSString *const CompanyUnCollectAPI = @"/ws/company/cancelMake.do";


#endif /* EnterpriseSquareNetAPI_h */
