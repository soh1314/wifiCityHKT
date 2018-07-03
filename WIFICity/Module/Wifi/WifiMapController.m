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

//x +23.979 y -21.313 z -26.714

@interface WifiMapController ()

@property (nonatomic,strong)BMKMapManager *mapManager;
@property (nonatomic,strong)BMKMapView* mapView;
@property (nonatomic,strong)BMKLocationService* locService;
@property(nonatomic,strong) BMKUserLocation *userLocation;//用户的位置
@property (nonatomic, strong) NSMutableArray * annotationArray;//标注数组

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
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    [_locService startUserLocationService];

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
    self.title = @"WIFI地图";
    [self setBlackNavBar];
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"NAjg8KLy6H3sotqy7Qa1UQRoVwvnXagz"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    mapView.overlookEnabled = YES; //设定地图View能否支持俯仰角
    mapView.buildingsEnabled = YES;//设定地图是否现显示3D楼块效果
    mapView.userTrackingMode = BMKUserTrackingModeFollow;
    mapView.showsUserLocation = YES;
    [mapView setZoomLevel:18];
    mapView.minZoomLevel = 10;
    self.mapView = mapView;
    self.view = mapView;

    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isAccuracyCircleShow=YES;//精度圈是否显示
    displayParam.locationViewImgName=@"icon_center_point";//定位图标名称去除蓝色的圈
    [_mapView updateLocationViewWithParam:displayParam];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.desiredAccuracy=kCLLocationAccuracyBest;
    _locService.distanceFilter = 20;//设定定位的最小更新距离，这里设置 200m 定位一次，频繁定位
    _locService.desiredAccuracy = kCLLocationAccuracyBest;//设定定位精度
    
}

- (void)getNearWifi {
    
    WIGeometryInfo *model = [[WIGeometryInfo alloc]init];
    model.wifiName = @"hkt1";
    model.mac = @"sdfdsLsdfsdf";
    model.longitude = @"112.863" ;
    model.latitude = @"28.248";
    WIFIAnnotation* annotation = [[WIFIAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor = CLLocationCoordinate2DMake([model.latitude doubleValue], [model.longitude doubleValue]);
//    annotation.title = model.wifiName;
    annotation.coordinate = coor;
    annotation.model = model;
    [self.annotationArray addObject:annotation];
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
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.userLocation = userLocation;
    NSLog(@"%.3f %.3f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    /*******************************设置定位中心************************************************/
    [_mapView updateLocationData:userLocation];
    
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
    annotationView.image = [UIImage imageNamed:@"gps_me"];
    annotationView.canShowCallout = YES;
    
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 45)];
    popView.backgroundColor = [UIColor whiteColor];
    [popView.layer setMasksToBounds:YES];
    [popView.layer setCornerRadius:3.0];
    popView.alpha = 0.9;
    //        //设置弹出气泡图片
    //        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:tt.imgPath]];
    //        image.frame = CGRectMake(0, 160, 50, 60);
    //        [popView addSubview:image];
    
    //自定义气泡的内容，添加子控件在popView上
    UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(8, 4, 160, 30)];
    driverName.text = annotation.title;
    driverName.numberOfLines = 0;
    driverName.backgroundColor = [UIColor clearColor];
    driverName.font = [UIFont systemFontOfSize:15];
    driverName.textColor = [UIColor blackColor];
    driverName.textAlignment = NSTextAlignmentLeft;
    [popView addSubview:driverName];
    
    UILabel *carName = [[UILabel alloc]initWithFrame:CGRectMake(8, 30, 180, 30)];
    carName.text = annotation.subtitle;
    carName.backgroundColor = [UIColor clearColor];
    carName.font = [UIFont systemFontOfSize:11];
    carName.textColor = [UIColor lightGrayColor];
    carName.textAlignment = NSTextAlignmentLeft;
    [popView addSubview:carName];
    
    if (annotation.subtitle != nil) {
        UIButton *searchBn = [[UIButton alloc]initWithFrame:CGRectMake(170, 0, 50, 60)];
        [searchBn setTitle:@"查看路线" forState:UIControlStateNormal];
        searchBn.titleLabel.numberOfLines = 0;
        [popView addSubview:searchBn];
    }
    
    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
    pView.frame = CGRectMake(0, 0,150, 45);
    ((BMKPinAnnotationView*)annotationView).paopaoView = nil;
    ((BMKPinAnnotationView*)annotationView).paopaoView = pView;
    
    return annotationView;
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
