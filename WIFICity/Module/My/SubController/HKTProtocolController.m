//
//  HKTProtocolController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HKTProtocolController.h"
#import <WebKit/WebKit.h>
@interface HKTProtocolController ()

@property (nonatomic,strong)UIWebView *uiwebView;
@property (nonatomic,strong)WKWebView *webView;

@end

@implementation HKTProtocolController

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
    self.title = @"服务协议";
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREENW, KSCREENH-kNavBarHeight-kStatusBarHeight)];
    webView.backgroundColor = [UIColor whiteColor];
    self.webView = webView;
    [self.view addSubview:webView];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"protocol" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://720yun.com/t/946jezwnuv5?scene_id=17042939&from=groupmessage"]]];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlString]];
}

- (void)loadData {
    
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
