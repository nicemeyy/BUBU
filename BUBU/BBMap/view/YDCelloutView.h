//
//  YDCelloutView.h
//  YDSmartBike
//
//  Created by DZM on 2017/11/27.
//  Copyright © 2017年 Archermind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface YDCelloutView : UIView


//@property (nonatomic, strong) UIImage *image; //商户图
@property (nonatomic, copy) NSString *subtitle; //电话
@property (nonatomic, copy) NSString *title; //地址
@property (nonatomic, strong) UIButton *cellButton;
@property (nonatomic, strong) UIButton *navButton;

//起始位置  终点位置
@property (nonatomic, assign) CLLocationCoordinate2D      locationCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D      bikelocationCoordinate;
@property (nonatomic, copy) NSString     *sName;
@property (nonatomic, copy) NSString     *eName;

@end
