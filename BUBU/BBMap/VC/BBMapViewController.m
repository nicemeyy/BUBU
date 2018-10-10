//
//  BBMapViewController.m
//  BUBU
//
//  Created by 董志盟 on 2018/10/9.
//  Copyright © 2018年 DZM. All rights reserved.
//
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)


#import "BBMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "MALocationAnnotation.h"
#import "MALocationAnnotationView.h"
#import "POIAnnotation.h"
#import "YDCelloutView.h"

@interface BBMapViewController ()<MAMapViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) MAMapView                   *mapView;
@property (nonatomic, copy)   AMapLocatingCompletionBlock completionBlock;
@property (nonatomic, strong) AMapLocationManager         *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D      locationCoordinate;

@property (nonatomic, strong) NSDictionary                 *locationDic;

@property (nonatomic, strong) MALocationAnnotation            *locAnnotation;

@property (nonatomic, strong) YDCelloutView *calloutView;
@property (nonatomic, strong) MAAnnotationView  *selectedAnnotationView;

@end

@implementation BBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"影院";
    self.view.backgroundColor = [UIColor whiteColor];
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
//    _mapView.showsUserLocation = YES;
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    UIButton  *button = [[UIButton alloc] initWithFrame:CGRectMake(7, KIsiPhoneX?88-37:64-37, 30, 30)];
    [button setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.layer.cornerRadius = 15;
    [button addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
}

- (void)butClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self configLocationManager];
    
    _mapView.centerCoordinate = _locationCoordinate;
}

/* 根据中心点坐标来搜周边的POI. */
- (void)searchPoiByCenterCoordinate
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:_locationCoordinate.latitude longitude:_locationCoordinate.longitude];
    request.keywords            = @"电影院";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.radius              = 50000;
    request.requireExtension    = YES;
    
    [self.search AMapPOIAroundSearch:request];
}
#pragma mark - 定位
//开启定位
- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];

}


#pragma mark - annotation相关
//添加标注(annotation)信息
- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:15.1 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}

//添加bike annotation
-(void)addBikeAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate bikeDic:(NSDictionary *)dic
{
    
    self.locAnnotation = [[MALocationAnnotation alloc] init];
    self.locAnnotation.coordinate   = coordinate;
    self.locAnnotation.title        = [dic valueForKey:@"district"];
    
    [self addAnnotationToMapView:self.locAnnotation];
    
}

#pragma mark - 根据coordinate 做逆地理编码的的搜索
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}

#pragma mark - 地图代理方法
//添加annotation是调用
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    //定位annotation
    if ([annotation isKindOfClass:[MALocationAnnotation class]]) {
        
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"user_location_white"];
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.selected = YES;
        
        return annotationView;
    }if ([annotation isKindOfClass:[POIAnnotation class]]) {
        
        static NSString *userLocationStyleReuseIndetifier = @"userBikeStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"icon_location_white"];
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.selected = NO;
        
        return annotationView;
    }
    
    return nil;
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //定位错误
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    //定位结果
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    _locationCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude);
    //停止定位
    [self.locationManager stopUpdatingLocation];
    [self searchReGeocodeWithCoordinate:_locationCoordinate];
    [self.mapView removeAnnotations:self.mapView.annotations];
    //根据定位信息，添加annotation
    MALocationAnnotation *annotation = [[MALocationAnnotation alloc] init];
    [annotation setCoordinate:location.coordinate];
    [self addAnnotationToMapView:annotation];
    
    [self searchPoiByCenterCoordinate];
}

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    _locationDic = @{
                         @"region":response.regeocode.addressComponent.province,
                         @"district":response.regeocode.formattedAddress,
                         @"latitude":[NSString stringWithFormat:@"%f",_locationCoordinate.latitude],
                         @"longitude":[NSString stringWithFormat:@"%f",_locationCoordinate.longitude],
                         @"page":@"1"};
    //添加车的位子
    [self addBikeAnnotationWithCoordinate:_locationCoordinate bikeDic:_locationDic];
    
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
//    NSLog(@"Error: %@ - %@", error, [ErrorInfoUtility errorDescriptionWithCode:error.code]);
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
//    [self.mapView addAnnotations:poiAnnotations];
    for (POIAnnotation *ann in poiAnnotations) {
        [self addAnnotationToMapView:ann];
    }
    _mapView.centerCoordinate = _locationCoordinate;
}

#pragma mark 点击站点弹出气泡
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    _selectedAnnotationView = view;
    if ([_selectedAnnotationView.annotation isKindOfClass:[POIAnnotation class]]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"导航地图选择",nil)
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* baiduAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"百度地图", nil) style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                [self navBaidu];
                                                            }];
        UIAlertAction* gaodeAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"高德地图", nil) style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                
                                                                [self navGaode];
                                                            }];
        
        UIAlertAction* canaelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                             }];
        [alert addAction:baiduAction];
        [alert addAction:gaodeAction];
        [alert addAction:canaelAction];
        [[self appRootViewController] presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark -
- (void)navGaode
{
    //iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=A&did=BGVIS2&dlat=%f&dlon=%f&dname=B&dev=0&t=0
//    iosamap://navi?sourceApplication=applicationName&poiname=fangheng&poiid=BGVIS&lat=36.547901&lon=104.258354&dev=1&style=2
    //导航
    NSURL *appURL = [NSURL URLWithString:[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=%f&slon=%f&sname=A&did=BGVIS2&dlat=%f&dlon=%F&dname=B&dev=0&t=0",self.locationCoordinate.latitude,self.locationCoordinate.longitude,self.selectedAnnotationView.annotation.coordinate.latitude,self.selectedAnnotationView.annotation.coordinate.longitude]];
    //路线规划
    //                                                            iosamap://path?sourceApplication=applicationName&sid=BGVIS1&slat=39.92848272&slon=116.39560823&sname=A&did=BGVIS2&dlat=39.98848272&dlon=116.47560823&dname=B&dev=0&t=0
    if ([[UIApplication sharedApplication] canOpenURL:appURL])
    {
        [[UIApplication sharedApplication] openURL:appURL options:@{} completionHandler:nil];
    }
    else
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"未安装高德地图", nil) preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        
        [controller addAction:okAction];
        
        [self.appRootViewController presentViewController:controller animated:YES completion:nil];
        
    }
}

- (void)navBaidu
{
    CLLocationCoordinate2D baiduBikelocationCoordinate = [self getBaiDuCoordinateByGaoDeCoordinate:self.selectedAnnotationView.annotation.coordinate];
    CLLocationCoordinate2D baidulocationCoordinate = [self getBaiDuCoordinateByGaoDeCoordinate:self.locationCoordinate];
    
    NSURL *appURL = [NSURL URLWithString:[NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&mode=driving&src=webapp.navi.yourCompanyName.yourAppName",baiduBikelocationCoordinate.latitude,baiduBikelocationCoordinate.longitude,baidulocationCoordinate.latitude,baidulocationCoordinate.longitude]];
    if ([[UIApplication sharedApplication] canOpenURL:appURL])
    {
        [[UIApplication sharedApplication] openURL:appURL options:@{} completionHandler:nil];
    }
    else
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"未安装百度地图", nil) preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        
        [controller addAction:okAction];
        
        [self.appRootViewController presentViewController:controller animated:YES completion:nil];
    }
}

//获取顶层视图
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController)
    {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

// 高德地图经纬度转换为百度地图经纬度
- (CLLocationCoordinate2D)getBaiDuCoordinateByGaoDeCoordinate:(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(coordinate.latitude + 0.006, coordinate.longitude + 0.0065);
}

@end
