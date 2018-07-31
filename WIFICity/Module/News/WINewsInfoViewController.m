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
#import "EaseRefreshHeader.h"
#import "EaseRefreshFooter.h"
#import "WINewsPageModel.h"
#import "GaoXinNewS.h"
#import "WebViewController.h"
#import "NavManager.h"

static NSString *const WIGaoXinNewsListAPI = @"/ws/wifi/findNewsByTypeId.do";

@interface WINewsInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)NSInteger page;

@end

@implementation WINewsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsTwoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeNewsTwoCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeNewsOneCellID"];
    weakself;
    self.tableView.mj_header = [EaseRefreshHeader headerWithRefreshingBlock:^{
        [wself loadData:YES];
    }];
    self.tableView.mj_footer = [EaseRefreshFooter footerWithRefreshingBlock:^{
        [wself loadData:NO];
    }];
    [self loadData:YES];
    
}

- (void)loadData:(BOOL)refresh{
    if (refresh) {
        self.page = 1;
    } else {
        self.page ++;
    }
    NSString *url = nil;
    NSDictionary *para = nil;
    WINewsPageModel *model = (WINewsPageModel*)self.pageModel;
    if (model.gxqType == 21) {
        url = kAppUrl(kUrlHost, WIFIHomeNewsAPI);
        para = @{@"orgId":[WIFISevice shared].wifiInfo.orgId,@"number":@(self.page)};
    } else {
        url = kAppUrl(@"http://192.168.1.188/wificity", WIGaoXinNewsListAPI);
        para = @{@"number":@(self.page),@"gxqType":@(model.gxqType)};
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [MHNetworkManager getRequstWithURL:url params:para successBlock:^(NSDictionary *returnData) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (refresh) {
            [self.dataArray removeAllObjects];
        }
        Class modelCls = NSClassFromString(self.pageModel.modelName);
        NSArray *newsArray = [modelCls arrayOfModelsFromDictionaries:[returnData objectForKey:@"obj"] error:nil];
        if (newsArray && newsArray.count > 0) {
            [self.dataArray addObjectsFromArray:newsArray];
            [self.tableView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        kHudNetError;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
    WINewsPageModel *model = (WINewsPageModel*)self.pageModel;
    if (model.gxqType == 21) {
        HomeNews *homeNews = self.dataArray[indexPath.row];
        HomeNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsOneCellID" forIndexPath:indexPath];
        cell.news = homeNews;
        return cell;
    } else {
        GaoXinNewS * news = self.dataArray[indexPath.row];
        if ([news.gxq_img_type isEqualToString:@"0"] || [news.gxq_img_type isEqualToString:@"1"] ) {
            HomeNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsOneCellID" forIndexPath:indexPath];
            cell.news = news;
            return cell;
        } else {
            HomeNewsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsTwoCellID" forIndexPath:indexPath];
            cell.news = news;
            if (news.gxq_img_type && news.gxq_image_array) {
                cell.imageGroupArray = [news.gxq_image_array copy];
            }
            return cell;
        }
    }
    


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WINewsPageModel *model = (WINewsPageModel*)self.pageModel;
    if (model.gxqType != 21) {
        GaoXinNewS *news = self.dataArray[indexPath.row];
        weakself;
        [NavManager pushWebViewControllerWithHtmlWord:news.gxq_details title:news.gxq_title controller:wself];
    } else {
        HomeNews *news = self.dataArray[indexPath.row];
        NSString *detailUrl = [NSString stringWithFormat:@"%@%@%@",kUrlHost,WIFIHomeNewsDetailAPI,news.ID];
        [NavManager pushWebViewControllerWithUrlString:detailUrl controller:self];
    }

    

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
