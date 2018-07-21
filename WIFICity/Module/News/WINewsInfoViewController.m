//
//  WINewsInfoViewController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/19.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WINewsInfoViewController.h"
#import "WIFISevice.h"
#import "HomeNews.h"
#import "HomeNewsOneCell.h"
#import "HomeNewsTwoCell.h"

@interface WINewsInfoViewController ()<UITableViewDataSource,UITableViewDataSource>

@end

@implementation WINewsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsTwoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeNewsTwoCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeNewsOneCellID"];
    
    // Do any additional setup after loading the view.
}

- (void)loadData:(NSInteger)index refresh:(BOOL)refresh{
    NSDictionary *para = @{@"orgId":[WIFISevice shared].wifiInfo.orgId};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, WIFIHomeNewsAPI) params:para successBlock:^(NSDictionary *returnData) {
        if (refresh) {
            [self.dataArray removeAllObjects];
        }
        Class modelCls = NSClassFromString(self.pageModel.modelName);
        NSArray *newsArray = [modelCls arrayOfModelsFromDictionaries:[returnData objectForKey:@"obj"] error:nil];
        [self.dataArray addObjectsFromArray:newsArray];
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - delegate and datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeNews *news = self.dataArray[indexPath.row];
    if (news.is_hot) {
        HomeNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsOneCellID" forIndexPath:indexPath];
        cell.news = news;
        return cell;
    } else {
        HomeNewsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsTwoCellID" forIndexPath:indexPath];
        cell.news = news;
        cell.imageGroupArray = @[@"http://wifi.hktfi.com/thirdImg/information/2/images/index_1530150498708.jpg",@"http://wifi.hktfi.com/thirdImg/information/2/images/index_1530150498708.jpg",@"http://wifi.hktfi.com/thirdImg/information/2/images/index_1530150498708.jpg"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
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
