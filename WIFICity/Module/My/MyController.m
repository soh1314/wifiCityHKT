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
#import "BindPhoneController.h"
#import "AboutUsController.h"
#import "BindAccountController.h"
#import "HKTProtocolController.h"
#import "WXWaveView.h"

@interface MyController ()<UITableViewDelegate,UIScrollViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)EaseTableView *tableView;
@property (nonatomic,copy)NSArray *UserCenterItemTitleArray;
@property (nonatomic,copy)NSArray *UserCenterItemImageNameArray;
@property (nonatomic,strong)WXWaveView *waveView;
@end

@implementation MyController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.UserCenterItemTitleArray = @[@"系统消息",@"推荐给好友",@"关于我们",@"服务协议",@"设备管理",@"退出登录"];
    self.UserCenterItemImageNameArray = @[@"phone_bind",@"binding",@"share",@"deal",@"about",@"quit"];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.waveView wave];
    if ([self phoneBinded]) {
       self.UserCenterItemTitleArray = @[@"更换手机号",@"绑定账号",@"推荐给好友",@"服务协议",@"关于我们",@"退出登录"];
    } else {
       self.UserCenterItemTitleArray = @[@"绑定手机号",@"绑定账号",@"推荐给好友",@"服务协议",@"关于我们",@"退出登录"];
    }
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.waveView stop];
}

- (void)initUI {
    UserInfoView *infoView = [[UserInfoView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, KSCREENW/2.2f)];

    infoView.backgroundColor = [UIColor themeColor];
    if ([[AccountManager shared].user.type isEqualToString:@"sj"]) {
        infoView.avartar .image = [UIImage qsImageNamed:@"head"];
    } else {
        NSString *avatarString = [EasyCacheHelper getResponseCacheForKey:MobThirdLoginAvartarKey];
        [infoView.avartar sd_setImageWithURL:[NSURL URLWithString:avatarString] placeholderImage:[UIImage qsImageNamed:@"head"]];
    }
    

    if ([[AccountManager shared].user.type isEqualToString:@"wx"]) {
        [infoView.nickNameLabel setText:[AccountManager shared].user.wxName];
    }
    if ([[AccountManager shared].user.type isEqualToString:@"qq"]) {
        [infoView.nickNameLabel setText:[AccountManager shared].user.qqName];
    }
    if ([[AccountManager shared].user.type isEqualToString:@"sj"]) {
        [infoView.nickNameLabel setText:[AccountManager shared].user.nickname];
    }
    
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithSubView:infoView];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    [self.tableView setTableHeaderView:headerView];
//    self.waveView = [WXWaveView addToView:headerView withFrame:CGRectMake(0, CGRectGetHeight(headerView.frame) - 5, CGRectGetWidth(headerView.frame), 5)];
//    self.waveView.waveColor = [UIColor whiteColor];
//    self.waveView.waveTime = 0.f;
//    self.waveView.angularSpeed = 1.2f;
//    self.waveView.waveSpeed = 5.f;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCenterItemCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"UserCenterItemCellID"];
}

- (BOOL)phoneBinded {
    if ( [AccountManager shared].user.phone && ![[AccountManager shared].user.phone isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
   
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.UserCenterItemTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserCenterItemCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"UserCenterItemCellID" forIndexPath:indexPath];
//    NSArray *itemLabelArray = self.UserCenterItemTitleArray[indexPath.section];
//    NSArray *itemImageNameArray = self.UserCenterItemImageNameArray[indexPath.section];
    itemCell.itemLabel.text =  self.UserCenterItemTitleArray[indexPath.row];
    itemCell.itemIcon.image = [UIImage qsImageNamed:self.UserCenterItemImageNameArray[indexPath.row]];
    return itemCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        BindPhoneController *ctrl = [BindPhoneController new];
        ctrl.bindNewPhone = [self phoneBinded];
        if ([self phoneBinded]) {
            ctrl.title = @"更换手机号";
        } else {
            ctrl.title = @"绑定手机号";
        }
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    
    if ( indexPath.row == 1) {
        BindAccountController *ctrl = [BindAccountController new];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    
    if (indexPath.row == 2) {
        [EaysShare shareApp];

        
    }
    
    if (indexPath.row == 3) {
        HKTProtocolController *hktProtocolCtrl = [HKTProtocolController new];
        [self.navigationController pushViewController:hktProtocolCtrl animated:YES];
        
    }
    
    if ( indexPath.row == 4) {
        AboutUsController *usCtrl = [AboutUsController new];
        [self.navigationController pushViewController:usCtrl animated:YES];
//        DeviceInfoController *deviceInfoCtrl = [DeviceInfoController new];
//        [self.navigationController pushViewController:deviceInfoCtrl animated:YES];
    }
    if ( indexPath.row == 5) {
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
    return CGFLOAT_MIN;
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



@end
