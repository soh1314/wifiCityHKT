//
//  WifiMapController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/3.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WifiMapController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "CustomPinAnnotationView.h"
#import "WIFIAnnotation.h"
#import "WIMapBubbleView.h"
#import <NetworkExtension/NetworkExtension.h>

//x +23.979 y -21.313 z -26.714

@interface WifiMapController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property (nonatomic,strong)BMKMapManager *mapManager;
@property (nonatomic,strong)BMKMapView* mapView;
@property (nonatomic,strong)BMKLocationService* locService;
@property(nonatomic,strong) BMKUserLocation *userLocation;//用户的位置
@property (nonatomic, strong) NSMutableArray * annotationArray;//标注数组
@property (nonatomic,strong)UIButton *refreshBtn;
@property (nonatomic,strong)UIButton *relocateBtn;

@end

@implementation WifiMapController

//- (id)init {
//    if (self = [super init]) {
//        self.hidesBottomBarWhenPushed = YES;
//
//    }
//    return self;
//}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    [_locService startUserLocationService];
    [self startWifi];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    [_locService stopUserLocationService];
}

- (void)startWifi {
    NSLog(@"1.Start");
    
    NSMutableDictionary* options = [[NSMutableDictionary alloc] init];
    [options setObject:@"华宽通无线城市😄wifi" forKey: kNEHotspotHelperOptionDisplayName];
    dispatch_queue_t queue = dispatch_queue_create("WIHKTWIFISEARCHQUEUE", NULL);
    
    NSLog(@"2.Try");
    BOOL returnType = [NEHotspotHelper registerWithOptions: options queue: queue handler: ^(NEHotspotHelperCommand * cmd) {
        
        NSLog(@"4.Finish");
        NEHotspotNetwork* network;
        if (cmd.commandType == kNEHotspotHelperCommandTypeEvaluate || cmd.commandType == kNEHotspotHelperCommandTypeFilterScanList) {
            // 遍历 WiFi 列表，打印基本信息
            for (network in cmd.networkList) {
                NSString* wifiInfoString = [[NSString alloc] initWithFormat: @"---------------------------\nSSID: %@\nMac地址: %@\n信号强度: %f\nCommandType:%ld\n---------------------------\n\n", network.SSID, network.BSSID, network.signalStrength, (long)cmd.commandType];
                NSLog(@"附近wifi信息%@", wifiInfoString);
                // 检测到指定 WiFi 可设定密码直接连接
                if ([network.SSID isEqualToString: @"test2"]) {
                    [network setConfidence: kNEHotspotHelperConfidenceHigh];
                    [network setPassword: @""];
                    NEHotspotHelperResponse *response = [cmd createResponse: kNEHotspotHelperResultSuccess];
                    NSLog(@"Response CMD: %@", response);
                    [response setNetworkList: @[network]];
                    [response setNetwork: network];
                    [response deliver];
                }
            }
        } else {
            NSLog(@"其他");
        }
    }];
    
    // 注册成功 returnType 会返回一个 Yes 值，否则 No
    NSLog(@"3.Result: %@", returnType == YES ? @"Yes" : @"No");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = tabbar_wifi;
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"NAjg8KLy6H3sotqy7Qa1UQRoVwvnXagz" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    mapView.overlookEnabled = YES; //设定地图View能否支持俯仰角
    mapView.buildingsEnabled = YES;//设定地图是否现显示3D楼块效果
    mapView.userTrackingMode = BMKUserTrackingModeFollow;
    mapView.showsUserLocation = YES;
    [mapView setZoomLevel:18];
//    mapView.minZoomLevel = 10;
    self.mapView = mapView;
    self.view = mapView;

    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isAccuracyCircleShow=NO;//精度圈是否显示
    displayParam.locationViewImgName=@"current_location";//定位图标名称去除蓝色的圈
    [_mapView updateLocationViewWithParam:displayParam];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.desiredAccuracy=kCLLocationAccuracyBest;
    _locService.distanceFilter = 200;//设定定位的最小更新距离，这里设置 200m 定位一次，频繁定位
    _locService.desiredAccuracy = kCLLocationAccuracyBest;//设定定位精度
    
    [self initButton];
}

- (void)initButton {
    self.relocateBtn = [UIButton new];
    [self.view addSubview:self.relocateBtn];
    [self.relocateBtn setImage:[UIImage qsImageNamed:@"location_top_right"] forState:UIControlStateNormal];
    [self.relocateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(self.view).mas_offset(30);
    }];
    [self.relocateBtn addTarget:self action:@selector(relocate:) forControlEvents:UIControlEventTouchUpInside];
    
    self.refreshBtn = [UIButton new];
    [self.view addSubview:self.refreshBtn];
    [self.refreshBtn setImage:[UIImage qsImageNamed:@"refurbish_top_right"] forState:UIControlStateNormal];
    [self.refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(self.view).mas_offset(83);
    }];
    [self.refreshBtn addTarget:self action:@selector(refreshNearWifi:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)refreshNearWifi:(id)sender {
    [self getNearWifi];
}

- (void)relocate:(id)sender {
   [_locService stopUserLocationService];
   [_locService startUserLocationService];
}

- (void)getNearWifi {
    
    WIGeometryInfo *model = [[WIGeometryInfo alloc]init];
    model.wifiName = @"hkt1";
    model.mac = @"sdfdsLsdfsdf";
    model.longitude = @"112.863" ;
    model.latitude = @"28.248";
    
    WIGeometryInfo *model1 = [[WIGeometryInfo alloc]init];
    model1.wifiName = @"hkt2";
    model1.mac = @"sdfdsLsdfsdfs";
    model1.longitude = @"112.864" ;
    model1.latitude = @"28.245";
    
    WIFIAnnotation* annotation = [[WIFIAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor = CLLocationCoordinate2DMake([model.latitude doubleValue], [model.longitude doubleValue]);
//    annotation.title = model.wifiName;
    annotation.coordinate = coor;
    annotation.model = model;
    
    WIFIAnnotation* annotation1 = [[WIFIAnnotation alloc]init];
    CLLocationCoordinate2D coor1;
    coor1 = CLLocationCoordinate2DMake([model1.latitude doubleValue], [model1.longitude doubleValue]);
    //    annotation.title = model.wifiName;
    annotation1.coordinate = coor1;
    annotation1.model = model1;
    
    [self.annotationArray addObject:annotation];
    [self.annotationArray addObject:annotation1];
    
    
    [_mapView addAnnotations:self.annotationArray];
}

//标注数组
- (NSMutableArray *)annotationArray {
    if (!_annotationArray) {
        _annotationArray = [NSMutableArray array];
    }
    return _annotationArray;
}


#pragma mark - location delegate

- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}


- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
}


- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    self.userLocation = userLocation;
    NSLog(@"%.3f %.3f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    /*******************************设置定位中心************************************************/
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;
    
}

- (void)reLocation {
    if (self.userLocation) {
        [self.mapView updateLocationData:self.userLocation];
    }
}

- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}


- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

#pragma mark - 大头针代理

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
    if ([ view isKindOfClass:[CustomPinAnnotationView class ]])
    {

    }
    
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    //装换坐标
//    [self getNearWifi];
    
    
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{

    CustomPinAnnotationView *annotationView = (CustomPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"otherAnnotationView"];
    if (annotationView == nil) {
        annotationView = [[CustomPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"otherAnnotationView"];
    }
    
    WIFIAnnotation *myAnnotation = (id)annotation;
    annotationView.image = [UIImage imageNamed:@"hkt_wifi"];
    annotationView.canShowCallout = YES;
    
    WIMapBubbleView *bubbleView = [[WIMapBubbleView alloc]initWithFrame:CGRectMake(0, 0, 252, 106)];
    [bubbleView setInfo:myAnnotation.model];
    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:bubbleView];
    pView.frame = CGRectMake(0, 0,252, 106);
    ((BMKPinAnnotationView*)annotationView).paopaoView = nil;
    ((BMKPinAnnotationView*)annotationView).paopaoView = pView;
    return annotationView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
