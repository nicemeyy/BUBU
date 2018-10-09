//
//  BBMapViewController.m
//  BUBU
//
//  Created by 董志盟 on 2018/10/9.
//  Copyright © 2018年 DZM. All rights reserved.
//
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO) || ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)


#import "BBMapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

@interface BBMapViewController ()

@end

@implementation BBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"影院";
    self.view.backgroundColor = [UIColor whiteColor];
    
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.view = mapView;
    
    UIButton  *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 44, KIsiPhoneX?88-37:64-37, 30, 30)];
    [button setImage:[UIImage imageNamed:@"icon_remove"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
}

- (void)butClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
