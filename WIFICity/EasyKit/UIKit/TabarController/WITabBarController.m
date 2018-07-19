//
//  TGTabBarController.m
//  TRGFShop
//
//  Created by 刘仰清 on 2017/9/4.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "WITabBarController.h"
#import "WITabBarSubViewController.h"
#import "WINavigationCotroller.h"
#import "BaseNavController.h"
//#import "JZNavigationExtension.h"
#import "WifiMapController.h"

@interface TGTabBarController ()<UITabBarControllerDelegate>


@end

@implementation TGTabBarController

#pragma mark - init

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setSubControllers];
    [self setUI];
   
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)dealloc {

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.translucent = NO;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor lightGrayColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor blackColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    for (UITabBarItem * i in self.tabBar.items) {
        i.titlePositionAdjustment = UIOffsetMake(0, -2.5);
        i.imageInsets = UIEdgeInsetsMake( -2.5, 0, 2.5, 0);
    }
}

- (void)setSubControllers {
    HomeController *home = [[HomeController alloc]init];
    BaseNavController *homeNav = [[BaseNavController alloc]initWithRootViewController:home];
//     home.jz_navigationBarBackgroundHidden = YES;
//    home.jz_wantsNavigationBarVisible = NO;
    homeNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:tabbar_shouye image:[UIImage qsAutoImageNamed:@"home_default"] selectedImage:[UIImage qsAutoImageNamed:@"home"]];
    WifiMapController *movieController = [[WifiMapController alloc]init];
    BaseNavController *movieNav = [[BaseNavController alloc]initWithRootViewController:movieController];
    movieNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:tabbar_wifi image:[UIImage qsAutoImageNamed:@"location_default"] selectedImage:[UIImage qsAutoImageNamed:@"location"]  ];
    CommunityController *communityController = [[CommunityController alloc]init];
//    message.jz_wantsNavigationBarVisible = YES;
//    message.jz_navigationBarBackgroundHidden = NO;
    BaseNavController *communityNav = [[BaseNavController alloc]initWithRootViewController:communityController];
    communityNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:tabbar_square image:[UIImage qsAutoImageNamed:@"square_default"]  selectedImage:[UIImage qsAutoImageNamed:@"square"]  ];
    
    MyController *userCenter = [[MyController alloc]init];
//    userCenter.jz_wantsNavigationBarVisible = NO;
//    userCenter.jz_navigationBarBackgroundHidden = YES;
    BaseNavController *userCenterNav = [[BaseNavController alloc]initWithRootViewController:userCenter];
    userCenterNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:tabbar_userCenter image:[UIImage qsAutoImageNamed:@"mine_default"]  selectedImage:[UIImage qsAutoImageNamed:@"mine"] ];
    self.viewControllers = @[homeNav,movieNav,communityNav,userCenterNav];

}

#pragma mark - TabBarController Delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
