//
//  WifiCheckController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/17.
//  Copyright © 2018年 HKT. All rights reserved.


#import "CompanyRecommendController.h"
#import "EnterpriseSquareNetAPI.h"
#import "CompanyRecommentCell.h"
#import "CompanyDetailController.h"
#import "EaseRefreshFooter.h"
#import "EaseRefreshHeader.h"

@interface CompanyRecommendController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)EaseTableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,assign)NSInteger page;

@end

@implementation CompanyRecommendController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"企业推荐";
    [self initUI];
    self.dataArray = [NSMutableArray array];
    [self loadData:YES];
}

- (void)initUI {
    [self setBlackNavBar];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyRecommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyRecommentCellID"];
    weakself;
    self.tableView.mj_header = [EaseRefreshHeader headerWithRefreshingBlock:^{
        [wself loadData:YES];
    }];
    self.tableView.mj_footer = [EaseRefreshFooter footerWithRefreshingBlock:^{
        [wself loadData:NO];
    }];
    
}

 - (void)loadData:(BOOL)refresh {
     
     if (refresh) {
         self.page = 1;
     } else {
         self.page ++;
     }
     NSDictionary *para = @{@"useId":[AccountManager shared].user.userId,@"pageNum":@(self.page)};
     [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyCategoryListAPI) params:para successBlock:^(NSDictionary *returnData) {
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
         WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
         if (refresh) {
             [self.dataArray removeAllObjects];
         }
         if (response && response.success) {
             NSArray *dataArray = [WICompanyInfo arrayOfModelsFromDictionaries:(NSArray *)response.obj error:nil];
             if (dataArray && dataArray.count > 0) {
                 [self.dataArray addObjectsFromArray:dataArray];
                 [self.tableView reloadData];
             } else {
                 [Dialog toast:@"没有更多数据了"];
             }
         }
     } failureBlock:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
     } showHUD:NO];
 }

#pragma mark - get and set
- (EaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[EaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor themeTableEdgeColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.estimatedRowHeight = 200;
    }
    return _tableView;
}


#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension < 90 ? 90 : UITableViewAutomaticDimension ;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CompanyRecommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyRecommentCellID" forIndexPath:indexPath];
    WICompanyInfo *info = self.dataArray[indexPath.row];
    [cell setCompanyInfo:info];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CompanyDetailController *detailController = [[CompanyDetailController alloc]init];
    detailController.info = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
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
    
}



@end
