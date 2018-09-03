//
//  BaseViewController.m
//  TRGFShop
//
//  Created by 刘仰清 on 2017/9/5.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "BaseViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "WIFISevice.h"

@interface BaseViewController ()<WifiNetChangeProtocol,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,assign)BOOL recoverNet;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = [self easyTittle:kBundleId];
    [self addBackItem];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (!KSysVersionUP11) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netStatuschange:) name:@"WINetStatus_Change_Noti" object:nil];
    self.nodataModel = [EaseNoDataModel new];
    self.nodataModel.noNetImageName = @"disconnect";
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"WINetStatus_Change_Noti" object:nil];
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


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self hiddenKeyboard];
}

-(void)hiddenKeyboard{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark - 网络恢复重新加载数据

- (void)netStatuschange:(NSNotification *)noti {
    if ([WIFISevice netStatus] == WINetFail) {
        self.noNet = YES;
    } else {
        self.recoverNet = YES;
        self.noNet = NO;
    }
}

- (void)setRecoverNet:(BOOL)recoverNet {
    _recoverNet = recoverNet;
    if (_recoverNet) {
        [self reloadDataWhenNetRecover];
    }
}

- (void)loadData:(BOOL)refresh {
    
}

- (void)reloadDataWhenNetRecover {
    [self loadData:YES];
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
    _noDataSuperView = (UIScrollView *)view;
    _noDataSuperView.emptyDataSetDelegate = self;
    _noDataSuperView.emptyDataSetSource = self;

}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.nodataModel && self.nodataModel.tapViewBlock) {
        self.nodataModel.tapViewBlock();
    }
    NSLog(@"点击视图");

}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if ([WIFISevice netStatus] == WINetFail) {
        [self loadData:YES];
        return;
    }
    if (self.nodataModel) {
        self.nodataModel.btnActionBlock();
    }
    
}

- (nullable NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.nodataModel && self.nodataModel.titile) {
        return [[NSAttributedString alloc]initWithString:self.nodataModel.titile attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    }
    if ([WIFISevice netStatus] == WINetFail) {
           return [[NSAttributedString alloc]initWithString:@"暂无网络连接~" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    } else {
            return [[NSAttributedString alloc]initWithString:@"当前视图无数据" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    }

}

- (nullable NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    if ([WIFISevice netStatus] == WINetFail) {
        return [[NSAttributedString alloc]initWithString:@"重试" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    }
    if (self.nodataModel && self.nodataModel.buttonTitle) {
        return [[NSAttributedString alloc]initWithString:self.nodataModel.buttonTitle attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]}];
    } else {
        return nil;
        
    }
}

- (nullable UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if ([WIFISevice netStatus] == WINetFail) {
         return [UIImage qsImageNamed:self.nodataModel.noNetImageName];
    }
    if (self.nodataModel && self.nodataModel.noDataImageName) {
        return [UIImage qsImageNamed:self.nodataModel.noDataImageName];
        
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
