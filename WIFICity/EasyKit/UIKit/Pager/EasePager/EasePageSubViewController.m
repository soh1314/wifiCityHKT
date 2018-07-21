//
//  EasePageSubViewController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/19.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EasePageSubViewController.h"
#import "WIFISevice.h"

@interface EasePageSubViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EasePageSubViewController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.dataArray = [NSMutableArray array];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        
    }];
    [self.tableView registerNib:[UINib nibWithNibName:self.pageModel.cellClass bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[NSString stringWithFormat:@"%@ID",self.pageModel.cellClass]];
    [self loadData:self.pageModel.index refresh:YES];
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

#pragma mark - get and set
- (EaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[EaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.pageModel.cellClass) {
        return nil ;
    }
    Class cls = NSClassFromString(self.pageModel.cellClass);
    id obj = [[cls alloc] init];
    obj = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@ID",self.pageModel.cellClass] forIndexPath:indexPath];
    return obj;
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

#pragma mark - 空视图

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
