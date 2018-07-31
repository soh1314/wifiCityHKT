//
//  MyController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "MyController.h"

#import "UserCenterConst.h"
#import "UserCenterItemCell.h"
#import "UserInfoView.h"
#import "ParallaxHeaderView.h"

#import "EasyCacheHelper.h"
#import "EaysShare.h"

#import "SystemMessageController.h"
#import "DeviceInfoController.h"
#import "AboutUsController.h"
#import "HKTProtocolController.h"


@interface MyController ()<UITableViewDelegate,UIScrollViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)EaseTableView *tableView;
@property (nonatomic,copy)NSArray *UserCenterItemTitleArray;
@property (nonatomic,copy)NSArray *UserCenterItemImageNameArray;

@end

@implementation MyController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.UserCenterItemTitleArray = @[@[@"系统消息",@"推荐给好友"],@[@"关于我们",@"服务协议"],@[@"设备管理",@"退出登录"]];
    self.UserCenterItemImageNameArray = @[@[@"message",@"share"],@[@"about",@"deal"],@[@"equipment",@"quit"]];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)initUI {
    UserInfoView *infoView = [[UserInfoView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 110)];
    infoView.backgroundColor = [UIColor darkTextColor];
    NSString *avatarString = [EasyCacheHelper getResponseCacheForKey:MobThirdLoginAvartarKey];
    [infoView.avartar sd_setImageWithURL:[NSURL URLWithString:avatarString]];
    if ([AccountManager shared].user.nickname) {
        [infoView.nickNameLabel setText:[AccountManager shared].user.nickname];
    }
    
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithSubView:infoView];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    [self.tableView setTableHeaderView:headerView];
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCenterItemCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"UserCenterItemCellID"];
    
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.UserCenterItemTitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *itemArray = self.UserCenterItemTitleArray[section];
    return itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserCenterItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"UserCenterItemCellID" forIndexPath:indexPath];
    NSArray *itemLabelArray = self.UserCenterItemTitleArray[indexPath.section];
    NSArray *itemImageNameArray = self.UserCenterItemImageNameArray[indexPath.section];
    itemCell.itemLabel.text =  itemLabelArray[indexPath.row];
    itemCell.itemIcon.image = [UIImage qsImageNamed:itemImageNameArray[indexPath.row]];
    return itemCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        SystemMessageController *msgCtrl = [SystemMessageController new];
        [self.navigationController pushViewController:msgCtrl animated:YES];
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        [EaysShare shareApp];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        AboutUsController *usCtrl = [AboutUsController new];
        [self.navigationController pushViewController:usCtrl animated:YES];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        HKTProtocolController *hktProtocolCtrl = [HKTProtocolController new];
        [self.navigationController pushViewController:hktProtocolCtrl animated:YES];
        
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        DeviceInfoController *deviceInfoCtrl = [DeviceInfoController new];
        [self.navigationController pushViewController:deviceInfoCtrl animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        [AccountManager logout];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

//    [AccountManager logout];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
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
