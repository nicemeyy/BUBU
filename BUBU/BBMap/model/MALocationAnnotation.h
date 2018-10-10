//
//  MALocationAnnotation.h
//  mapView
//
//  Created by DZM on 2017/11/2.
//  Copyright © 2017年 DZM.CM. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface MALocationAnnotation : NSObject<MAAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) NSArray *locationImages;


@end
