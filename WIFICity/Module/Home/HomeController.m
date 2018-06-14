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

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[AccountManager shared]handleWhenAppStart];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setWhiteTrasluntNavBar];
    
    [self saveUserFlow];
    [self findUserFLow];
   
}

- (void)findUserFLow {
    NSDictionary *para = [NSDictionary dictionary];
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, FindUserFLowAPI) params:para successBlock:^(NSDictionary *returnData) {
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)saveUserFlow {
    
    NSDictionary *para = @{@"flowNumber":@"0"};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, SaveUserFlowAPI) params:para successBlock:^(NSDictionary *returnData) {
        
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
