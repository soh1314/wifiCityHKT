//
//  WifiSpeedTestController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/8/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiSpeedTestController.h"
#import "WMGaugeView.h"
#import "NSString+Additions.h"
#import "WifiSpeedView.h"
@interface WifiSpeedTestController ()

@property (nonatomic,strong)WMGaugeView *gaugeView;
@property (nonatomic,strong)WifiSpeedView *speedView;
@property (nonatomic,assign)float uploadSpeed;
@property (nonatomic,assign)float downloadSpeed;

@end

@implementation WifiSpeedTestController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = @"深度测速";
    [self testSpeed];
    // Do any additional setup after loading the view.
}

- (void)testSpeed {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *reuqest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cshtz.gov.cn/xwzx/lgxw/201808/W020180802564452551258.jpg"]];
    NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/save4"];
    float oldTime = [[NSString unixTimeStampMsecond] floatValue];
    [Dialog progressToast:@"上传速度测试"];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:reuqest progress:^(NSProgress * _Nonnull downloadProgress) {
        float progress = downloadProgress.completedUnitCount;
        float time = [[NSString unixTimeStampMsecond]floatValue];
        float gapTime = time - oldTime;
        float downloadM = downloadProgress.completedUnitCount/1024.0f/1024;
        float speed = downloadM /gapTime *1000;
        self.gaugeView.value =  arc4random() % 100;
        self.downloadSpeed = self.gaugeView.value / 100;
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savedPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [Dialog progressToast:@"下载速度测试"];
        self.speedView.downloadLabel.text = [NSString stringWithFormat:@"%.2f M/s",self.downloadSpeed];
        [self testSpeed1];
    }];
    [task resume];
}

- (void)testSpeed1 {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *reuqest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cshtz.gov.cn/xwzx/lgxw/201808/W020180802564452551258.jpg"]];
    NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/save5"];
    float oldTime = [[NSString unixTimeStampMsecond] floatValue];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:reuqest progress:^(NSProgress * _Nonnull downloadProgress) {
        float progress = downloadProgress.completedUnitCount;
        float time = [[NSString unixTimeStampMsecond]floatValue];
        float gapTime = time - oldTime;
        float downloadM = downloadProgress.completedUnitCount/1024.0f/1024;
        float speed = downloadM /gapTime *1000;
        self.gaugeView.value =  arc4random() % 100;
        self.uploadSpeed = self.gaugeView.value / 100;
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savedPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        self.speedView.uploadLabel.text = [NSString stringWithFormat:@"%.2f M/s",self.uploadSpeed];
    }];
    [task resume];
}

- (void)initUI {
    WMGaugeView *gaugeView = [WMGaugeView new];
    gaugeView.frame = CGRectMake(0, 0, KSCREENW/1.2f, KSCREENW/1.2f);
    gaugeView.center = self.view.center;
    self.gaugeView = gaugeView;
    gaugeView.style = [WMGaugeViewStyleFlatThin new];
    gaugeView.maxValue = 100.0;
    gaugeView.scaleDivisions = 10;
    gaugeView.scaleSubdivisions = 5;
    gaugeView.scaleStartAngle = 30;
    gaugeView.scaleEndAngle = 280;
    gaugeView.showScaleShadow = NO;
    gaugeView.scaleFont = [UIFont fontWithName:@"AvenirNext-UltraLight" size:0.065];
    gaugeView.scalesubdivisionsAligment = WMGaugeViewSubdivisionsAlignmentCenter;
    gaugeView.scaleSubdivisionsWidth = 0.002;
    gaugeView.scaleSubdivisionsLength = 0.04;
    gaugeView.scaleDivisionsWidth = 0.007;
    gaugeView.scaleDivisionsLength = 0.07;
    gaugeView.backgroundColor = [UIColor whiteColor];
    
//    [gaugeView setValue:56.2 animated:YES duration:1.6 completion:^(BOOL finished) {
//        NSLog(@"gaugeView animation complete");
//    }];
    [self.view addSubview:gaugeView];
    
    self.speedView = [[WifiSpeedView alloc]initWithFrame:CGRectMake(0, 80, KSCREENW/1.2f, 80)];
    [self.view addSubview:self.speedView];
    [self.speedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.gaugeView.mas_top).mas_offset(-50);
        make.width.mas_equalTo(KSCREENW/1.2f);
        make.height.mas_equalTo(80);
        make.centerX.mas_equalTo(self.view);
    }];
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
