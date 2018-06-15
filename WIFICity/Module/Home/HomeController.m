//
//  HomeController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeController.h"

#define SaveUserFlowAPI @"/ws/third/saveFlow.do"
#define FindUserFLowAPI @"/ws/third/findBandByUserId.do"

#define LbtInfoAPI  @"/ws/wifi/findLbtByOrgId.do?orgId=8a8ab0b246dc81120146dc8180ba0017"
#define HomeNewsApi @" /ws/wifi/findDeliveryByOrgId.do?orgId=8a8ab0b246dc81120146dc8180ba0017"
#define HomeThirdAPI @"/ws/third/findAllThirdIcon.do?&number=1"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[AccountManager shared]handleWhenAppStart];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setWhiteTrasluntNavBar];
    // 定时器
    [self saveUserFlow];
    [self findUserFLow];
    
    [self requestLbtData];
    [self requestHomeNews];
    [self requestServiceData];
   
}

- (void)requestLbtData {
    NSDictionary *para = @{@"orgId":@"0"};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, LbtInfoAPI) params:para successBlock:^(NSDictionary *returnData) {
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)requestHomeNews {
    NSDictionary *para = @{@"orgId":@"0"};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, HomeNewsApi) params:para successBlock:^(NSDictionary *returnData) {
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)requestServiceData {
    NSDictionary *para = @{@"number":@"1"};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, HomeThirdAPI) params:para successBlock:^(NSDictionary *returnData) {
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)findUserFLow {
    NSDictionary *para = [NSDictionary dictionary];
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, HomeNewsApi) params:para successBlock:^(NSDictionary *returnData) {
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)saveUserFlow {
    
    NSDictionary *para = @{@"flowNumber":@"0"};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, HomeThirdAPI) params:para successBlock:^(NSDictionary *returnData) {
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
