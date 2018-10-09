//
//  UIViewController+Extension.m
//  CNOGASingularV2
//
//  Created by n005116 on 16/5/16.
//  Copyright © 2016年 Archermind. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "UIBarButtonItem+Extension.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

static NSString* const kVCRestorationIdentifier              = @"presentInViewController";

@implementation UIViewController (Extension)

- (void)presentInViewController:(UIViewController*)viewController
{
    if(self && viewController)
    {
        UINavigationController *navigationController = nil;
        navigationController = [[UINavigationController alloc] initWithRootViewController:self];
        navigationController.view.backgroundColor = [UIColor whiteColor];
        [navigationController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backButtonPressed:) image:@"top_icon_jiantou_2" highImage:@"top_icon_jiantou_2_on"];
        self.automaticallyAdjustsScrollViewInsets = NO;
        [viewController presentViewController:navigationController animated:YES completion:nil];
        self.restorationIdentifier = kVCRestorationIdentifier;
    }
};

- (void)presentInViewController:(UIViewController*)viewController title:(NSString*)title
{
    if(self && viewController)
    {
        self.title = title;
        [self presentInViewController:viewController];
    }
};

- (void)backButtonPressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
};




@end

#pragma clang diagnostic pop
