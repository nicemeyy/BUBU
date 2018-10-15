//
//  UIBarButtonItem+Extension.m
//  CnogaHealthyClient
//
//  Created by MAC_W on 15/8/5.
//  Copyright (c) 2015年 WNT. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 *  create BarButtonItem
 *
 *  @param target    self
 *  @param action
 *  @param image
 *  @param highImage 
 *
 *  @return new BarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    CGRect frame;
    frame = btn.frame;
    frame.size.height = btn.currentBackgroundImage.size.height;
    frame.size.width = btn.currentBackgroundImage.size.width;
    btn.frame = frame;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    // 设置尺寸
    CGRect frame;
    frame = btn.frame;
    frame.size.height = btn.currentBackgroundImage.size.height;
    frame.size.width = btn.currentBackgroundImage.size.width;
    btn.frame = frame;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    // 设置尺寸
    CGRect frame;
    frame = btn.frame;
    frame.size.height = 30;
    frame.size.width = 80;
    btn.frame = frame;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
