//
//  MALocationAnnotationView.m
//  mapView
//
//  Created by DZM on 2017/11/2.
//  Copyright © 2017年 DZM.CM. All rights reserved.
//

#import "MALocationAnnotationView.h"

#define kWidth          60.f
#define kHeight         60.f

@implementation MALocationAnnotationView

@synthesize imageView = _imageView;

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self setBounds:CGRectMake(0.f, 0.f, kWidth, kHeight)];
        [self setBackgroundColor:[UIColor clearColor]];

        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    
    return self;
}

#pragma mark - Override

- (void)setAnnotation:(id<MAAnnotation>)annotation
{
    [super setAnnotation:annotation];
    
    
}


@end
