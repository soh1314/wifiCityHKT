//
//  EasePageController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/19.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EasePageController.h"
#import "UIViewController+EasyUtil.h"
#import "EasePageDelegateHelper.h"

@interface EasePageController ()

@property (nonatomic,strong)EasePageDelegateHelper *helper;

@end

@implementation EasePageController

- (id)init {
    if (self = [super init]) {
        [self setBlackNavBar];
        [self addBackItem];
        self.hidesBottomBarWhenPushed = YES;
        self.showOnNavigationBar = NO;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleColorNormal = [UIColor lightGrayColor];
        self.titleColorSelected = [UIColor blackColor];
        self.titleSizeSelected = [UIFont systemFontOfSize:14.0].pointSize;
        self.titleSizeNormal = [UIFont systemFontOfSize:14.0].pointSize;
        self.helper = [[EasePageDelegateHelper alloc]init];
        self.helper.sourceType = EasePageSourceNewsType;
        self.delegate = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addBackItem];
}

- (void)initUI {

    [self setBlackNavBar];
}

#pragma mark - pagecontroller delegate datasource

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.itemModel.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    EasePageModel *model = self.itemModel[index];
    return model.title;
}

- (UIViewController *)easePageController:(EasePageController *)viewController AtIndex:(NSInteger)index {
    return [self.helper easePageController:self viewControllerAtIndex:index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {

    return [self easePageController:self AtIndex:index];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width ;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    //    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, 0, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 44, self.view.frame.size.width, KSCREENH-kNavBarHeight-kStatusBarHeight-44);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
