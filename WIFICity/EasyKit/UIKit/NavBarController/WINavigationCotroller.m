//
//  TGNavigationCotroller.m
//  TRGFShop
//
//  Created by 刘仰清 on 2017/9/4.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "WINavigationCotroller.h"


@interface TGNavigationCotroller ()

@end

@implementation TGNavigationCotroller

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldFont5]}];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#111111"],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor blackColor];
   
//    self.navigationBar.barTintColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return NO;
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
