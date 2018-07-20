//
//  BaseViewController.m
//  TRGFShop
//
//  Created by 刘仰清 on 2017/9/5.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "BaseViewController.h"
#import "UIScrollView+EmptyDataSet.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = [self easyTittle:kBundleId];
    [self addBackItem];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self checkNet];
    if (!KSys11Up) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }  else {
        
    }
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache]clearMemory];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


#pragma mark - 网络恢复重新加载数据

- (void)reloadDataWhenNetRecover {
    NSLog(@"baseviewcontroller 重新加载数据");
}

- (void)checkNet
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            self.noNet = YES;
        } else {
            self.noNet = NO;
        }
    }];
}

#pragma mark - 空视图

- (void)setNoNet:(BOOL)noNet {
    _noNet = noNet;
    if (self.nodataModel) {
        self.nodataModel.noNet = noNet;
        [self.noDataSuperView reloadEmptyDataSet];
    }
}

- (void)setNoDataViewWithBaseView:(UIView *)view {
    if ([view isKindOfClass:[UIScrollView class]] ) {
        UIScrollView *scrollView = (UIScrollView *)view;
        _noDataSuperView = view;
        __weak typeof(self)wself = self;
        scrollView.emptyDataSetDelegate = wself;
        scrollView.emptyDataSetSource = wself;
        
    } else if ( [view isKindOfClass:[UITableView class]] ) {
        UITableView *tableview = (UITableView *)view;
        _noDataSuperView = view;
        __weak typeof(self)wself = self;
        tableview.emptyDataSetDelegate = wself;
        tableview.emptyDataSetDelegate = wself;
        
    } else {
        
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.nodataModel) {
        self.nodataModel.tapViewBlock();
    }
    NSLog(@"点击视图");

}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.nodataModel) {
        self.nodataModel.btnActionBlock();
    }
    
}

- (nullable NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.nodataModel) {
        return [[NSAttributedString alloc]initWithString:self.nodataModel.titile attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    }
    return [[NSAttributedString alloc]initWithString:@"当前视图无数据" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
}

- (nullable NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if (self.nodataModel && self.nodataModel.buttonTitle) {
        return [[NSAttributedString alloc]initWithString:self.nodataModel.buttonTitle attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    } else {
        return nil;
    }
}

- (nullable UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.nodataModel && self.nodataModel.noDataImageName) {
        if (!self.nodataModel.noNet) {
            return [UIImage qsImageNamed:self.nodataModel.noDataImageName];
        } else {
            return [UIImage qsImageNamed:self.nodataModel.noNetImageName];
        }
        
    } else {
        return nil;
    }

}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.nodataModel.verticalOffset) {
        return self.nodataModel.verticalOffset;
    }
    return -30;
}

- (nullable UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

@end
