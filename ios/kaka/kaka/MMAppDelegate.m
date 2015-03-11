//
//  MMAppDelegate.m
//
//  Created by towne on 14-11-12.
//  Copyright (c) 2014年 MM. All rights reserved.
//

#import "MMAppDelegate.h"
#import "MMTalkData.h"
#import "NetworkUtil.h"
#import "MMTalkTransfersCenter.h"

#import "MMMessageController.h"
#import "MMLinkmanViewController.h"
#import "MMCircleViewController.h"
#import "MMProfileViewController.h"

#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "MMTalkToolBar.h"
#import "Config.h"


NSString * const  A = @"towne";
NSString * const  B = @"qi";

@implementation MMAppDelegate

extern MMTalkToolBar * mmmtalktoolbar;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    [[MMDBHelper shareDBHelper] updateToDB:[MMTalkData class] set:[NSString stringWithFormat:@"status=3"] where:[NSString stringWithFormat:@"status=1"]];


    
    [[MMTalkTransfersCenter shareCenter ] connectToServer:@"119.97.220.38" onPort:4810 atUsekey:A];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[MMDBHelper shareDBHelper] createTableWithModelClass:[MMTalkData class]];
    
    [self setupViewControllers];
    
//    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:controller];
    
    [self.window setRootViewController:self.viewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self customizeInterface];
    
//    MMLoginController *vc = [MMLoginController new];
//    
//    [self.viewController presentViewController:vc animated:NO completion:nil];
    
    
    // 资源消耗巨大,预先建立缓存
    
     mmmtalktoolbar = [MMTalkToolBar newTalkToolBar:nil];
     return YES;
}

#pragma mark - Methods

- (void)setupViewControllers {
    UIViewController *messageViewController = [[MMMessageController alloc] init];
    UIViewController *messageNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:messageViewController];
    
    UIViewController *linkmanViewController = [[MMLinkmanViewController alloc] init];
    UIViewController *linkmanNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:linkmanViewController];
    
    UIViewController *circleViewController = [[MMCircleViewController alloc] init];
    UIViewController *circleNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:circleViewController];
    
    UIViewController *profileViewController = [[MMProfileViewController alloc] init];
    UIViewController *profileNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:profileViewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[messageNavigationController, linkmanNavigationController,circleNavigationController,profileNavigationController]];
    
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"tab_bar_msg", @"tab_bar_contacts", @"tab_bar_ds",@"tab_bar_me"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_pre",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nor",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
