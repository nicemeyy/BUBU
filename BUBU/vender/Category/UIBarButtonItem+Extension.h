//
//  UIBarButtonItem+Externsion.h
//  CnogaHealthyClient
//
//  Created by MAC_W on 15/8/5.
//  Copyright (c) 2015年 WNT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title;
@end
