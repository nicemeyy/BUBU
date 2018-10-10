//
//  AppDelegate.m
//  BUBU
//
//  Created by 董志盟 on 2018/10/8.
//  Copyright © 2018年 DZM. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BBMainViewController.h"
#import "BBDeputyViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()
{
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

   [AMapServices sharedServices].apiKey = @"38748979dd8306129618d948ee690436";
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    UITabBarController *vc = [[UITabBarController alloc] init];
    [self initTabBar:vc];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _window.rootViewController = vc;
    [_window makeKeyAndVisible];
    


    return YES;
}

- (void)initTabBar:(UITabBarController *)tabbarVC
{
    NSArray *titles = @[@"主页", @"推荐"];
    NSArray *images = @[@"tabbar_home@3x", @"tabbar_profile@3x"];
    NSArray *selectImages = @[@"tabbar_home_selected@3x", @"tabbar_profile_selected@3x"];
    
    BBMainViewController * oneVc = [[BBMainViewController alloc] init];
    
    BBDeputyViewController * twoVc = [[BBDeputyViewController alloc] init];
    NSArray *viewControllers = @[oneVc, twoVc];
    for (int i = 0; i < viewControllers.count; i++)
    {
        UIViewController *childVc = viewControllers[i];
        childVc.tabBarItem.image = [UIImage imageNamed:images[i]];
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectImages[i]];
        childVc.title = titles[i];
        [self setVC:childVc title:titles[i] image:images[i] selectedImage:nil tabbarVC:tabbarVC];
    }
}

- (void)setVC:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage tabbarVC:(UITabBarController *)tabbarVC
{
//    VC.tabBarItem.title = title;
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
//    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    [VC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
//    VC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    [tabbarVC addChildViewController:nav];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
