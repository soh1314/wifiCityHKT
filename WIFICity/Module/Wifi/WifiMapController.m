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
#import "EasyCLLocationManager.h"

//x +23.979 y -21.313 z -26.714
static NSString *const WIFIPositionAPI = @"http://www.hktfi.com/index.php/Api/ap/getPosition";

@interface WifiMapController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property (nonatomic,strong)BMKMapManager *mapManager;
@property (nonatomic,strong)BMKMapView* mapView;
@property (nonatomic,strong)BMKLocationService* locService;
@property(nonatomic,strong) BMKUserLocation *userLocation;//用户的位置
@property (nonatomic, strong) NSMutableArray * annotationArray;//标注数组
@property (nonatomic,strong)UIButton *refreshBtn;
@property (nonatomic,strong)UIButton *relocateBtn;
@property (nonatomic,assign)NSInteger status;

@end

@implementation WifiMapController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;

    }
    return self;
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
//    [self setWhiteTrasluntNavBar];
    [self checkAuthorization];
    if (self.status < 3) {
        return;
    }
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    [_locService startUserLocationService];
}

- (void)checkAuthorization {
    int status = [CLLocationManager authorizationStatus];
    self.status = status;
    if (status < 3) {
        [Dialog simpleToast:@"请前往设置打开位置权限才能使用地图功能"];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    [_locService stopUserLocationService];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlackNavBar];
    self.title = @"WiFi地图";
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
    [mapView setZoomLevel:17];
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
    [self loadData:YES];
}

- (void)loadData:(BOOL)refresh {
    [Dialog showRingLoadingView:self.view];
    [MHNetworkManager postReqeustWithURL:WIFIPositionAPI params:nil successBlock:^(NSDictionary *returnData) {
         [Dialog hideToastView:self.view];
        NSArray *data = (NSArray *)returnData;
        NSArray *wifiArray = [WIGeometryInfo arrayOfModelsFromDictionaries:data error:nil];
        [self getNearWifi:wifiArray];
//        [self relocate:nil];
        
    } failureBlock:^(NSError *error) {
        [Dialog hideToastView:self.view];
        kHudNetError;
    } showHUD:NO];
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
    [self loadData:YES];
}

- (void)relocate:(id)sender {
    [self checkAuthorization];
    if (self.status < 3) {
        return;
    }
    [self reLocation];
}

- (void)getNearWifi:(NSArray *)wifiArray {
    
    [self.mapView removeAnnotations:self.annotationArray];
    [self.annotationArray removeAllObjects];
    for (int i = 0 ; i < wifiArray.count; i++) {
        WIGeometryInfo *model = wifiArray[i];
        WIFIAnnotation* annotation = [[WIFIAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor = CLLocationCoordinate2DMake([model.latitude doubleValue], [model.longitude doubleValue]);
        //    annotation.title = model.wifiName;
        annotation.coordinate = coor;
        annotation.model = model;
        [self.annotationArray addObject:annotation];
    }
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
        _mapView.centerCoordinate = self.userLocation.location.coordinate;
    }
}

- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}


- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"%@",error.localizedDescription);
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
    if (self.userLocation.location) {
        [bubbleView setLocation:self.userLocation.location];
    }
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
