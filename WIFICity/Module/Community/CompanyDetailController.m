//
//  CompanyDetailController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyDetailController.h"
#import "CompanyDetailSectionOne.h"
#import "CompanyDetailSectionTwo.h"
#import "CompanyDetailSectionFour.h"

@interface CompanyDetailController ()

@property (nonatomic,strong)EaseTableView *tableView;

@end

@implementation CompanyDetailController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业详情";
    [self setBlackNavBar];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyDetailSectionFour" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyDetailSectionFourID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyDetailSectionTwo" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyDetailSectionTwoID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyDetailSectionOne" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyDetailSectionOneID"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        CompanyDetailSectionOne *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyDetailSectionOneID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (section == 1) {
        CompanyDetailSectionTwo *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyDetailSectionTwoID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    } else {
        CompanyDetailSectionFour *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyDetailSectionFourID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

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
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
