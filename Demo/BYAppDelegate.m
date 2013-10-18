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
    standardVC.beautifyDescripiton = @"This view controller has not been styled by beautify. All the controls you see here should be the default iOS style controls.";
    
    demoVC.title = @"Beautified";
    demoVC.beautifyDescripiton = @"This view controller has been styled by beautify. All the controls you see here have the default beautify style applied to them, which matches the system styling in iOS 6 and iOS 7. There are a few differences, but we are working on them ;-)";
    
    customVC.title = @"Customised";
    customVC.beautifyDescripiton = @"This view controller has been styled by beautify. All the controls you see here have had a custom beautify style applied to them. The switch above allows you to swap the current theme.";
    customVC.applyCustomStyles = YES;
    
    standardNav = [[UINavigationController alloc] initWithRootViewController:standardVC];
    demoNav = [[UINavigationController alloc] initWithRootViewController:demoVC];
    customNav = [[UINavigationController alloc] initWithRootViewController:customVC];
    
    [standardNav setImmuneToBeautify:YES];
    
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
    }
}

@end