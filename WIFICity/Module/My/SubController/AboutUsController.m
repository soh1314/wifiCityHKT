//
//  AboutUsController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "AboutUsController.h"
#import "UserCenterItemCell.h"
#import "TableViewCellHeader.h"
#import "WebViewController.h"
#import "WIUtil.h"
@interface AboutUsController ()

@property (nonatomic,strong)EaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,copy)NSArray *cellHeaderTitleArray;
@property (nonatomic,copy)NSArray *cellImageArray;
@property (nonatomic,copy)NSArray *cellContentArray;

@end

@implementation AboutUsController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    [self setBlackNavBar];
    self.title = @"关于我们";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topBg.mas_bottom);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCenterItemCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"UserCenterItemCellID"];
}

- (void)loadData {
    self.cellHeaderTitleArray = @[@"官方网站",@"业务交流",@"联系方式"];
    self.cellImageArray = @[@[@"link"],@[@"apply",@"wireless city"],@[@"email"]];
    self.cellContentArray = @[@[@"公司网站： http://www.hkttech.cn"],@[@"移动应用定制：18603062966",@"无线WiFi接入：18603062966"],@[@"tech@hktchn.com"]];
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellImageArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellImageArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserCenterItemCell *itemcell = [tableView dequeueReusableCellWithIdentifier:@"UserCenterItemCellID" forIndexPath:indexPath];
    [itemcell setUIStyle:@"AboutUs"];
    NSArray *contentItemArray = self.cellContentArray[indexPath.section];
    NSArray *imageItemArray = self.cellImageArray[indexPath.section];
    itemcell.itemLabel.text = contentItemArray[indexPath.row];
    itemcell.itemIcon.image = [UIImage qsImageNamed:imageItemArray[indexPath.row]];
    return itemcell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        WebViewController *ctrl = [WebViewController new];
        ctrl.URLString = @"http://www.hkttech.cn";
        [self.myNavigationController pushViewController:ctrl animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        [WIUtil callPhone:@"18603062966"];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        [WIUtil callPhone:@"18603062966"];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableViewCellHeader *header = [[TableViewCellHeader alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 30)];
    header.titleLabel.text = self.cellHeaderTitleArray[section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
