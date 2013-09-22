//
//  BYAppDelegate.m
//  Demo
//
//  Created by Chris Grant on 18/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYAppDelegate.h"
#import <Beautify/Beautify.h>
#import "DemoViewController.h"

@interface BYAppDelegate () <UITabBarControllerDelegate>
@end

@implementation BYAppDelegate {
    DemoViewController *standardVC;
    DemoViewController *demoVC;
    DemoViewController *customVC;
    UINavigationController *standardNav;
    UINavigationController *demoNav;
    UINavigationController *customNav;
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    
    [[BYBeautify instance] activate];
    
    UITabBarController *tbc = [UITabBarController new];
    [tbc setDelegate:self];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        standardVC = [[DemoViewController alloc] initWithNibName:@"DemoiPadViewController" bundle:nil];
        demoVC = [[DemoViewController alloc] initWithNibName:@"DemoiPadViewController" bundle:nil];
        customVC = [[DemoViewController alloc] initWithNibName:@"DemoiPadViewController" bundle:nil];
    }
    else {
        standardVC = [[DemoViewController alloc] initWithNibName:@"DemoiPhoneViewController" bundle:nil];
        demoVC = [[DemoViewController alloc] initWithNibName:@"DemoiPhoneViewController" bundle:nil];
        customVC = [[DemoViewController alloc] initWithNibName:@"DemoiPhoneViewController" bundle:nil];
    }
    
    standardVC.title = @"Standard";
    demoVC.title = @"Beautified";
    customVC.title = @"Customised";
    
    [standardVC setImmuneToBeautify:YES];
    
    standardNav = [[UINavigationController alloc] initWithRootViewController:standardVC];
    demoNav = [[UINavigationController alloc] initWithRootViewController:demoVC];
    customNav = [[UINavigationController alloc] initWithRootViewController:customVC];
    
    [tbc setViewControllers:@[standardNav, demoNav, customNav]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

-(void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController{
    if(viewController == standardNav) {
    }
    else if(viewController == demoNav) {
        [[BYThemeManager instance] applyTheme:[BYTheme new]];
    }
    else if (viewController == customNav) {
        BYTheme *theme = [BYTheme fromFile:@"flat"];
        [[BYThemeManager instance] applyTheme:theme];
    }
}

@end