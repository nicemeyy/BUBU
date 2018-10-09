//
//  UIViewController+Extension.h
//  CNOGASingularV2
//
//  Created by n005116 on 16/5/16.
//  Copyright © 2016年 Archermind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

- (void)presentInViewController:(UIViewController*)viewController;

- (void)presentInViewController:(UIViewController*)viewController title:(NSString*)title;

- (UIViewController *)appRootViewController;



@end
