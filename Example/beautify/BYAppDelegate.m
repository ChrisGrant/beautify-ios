//
//  BYAppDelegate.m
//  Demo
//
//  Created by Chris Grant on 18/09/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "BYAppDelegate.h"
#import <Beautify/Beautify.h>
#import "DemoViewController.h"

@interface BYAppDelegate () <UITabBarControllerDelegate>

@property (nonatomic, strong) DemoViewController *standardVC;
@property (nonatomic, strong) DemoViewController *demoVC;
@property (nonatomic, strong) DemoViewController *customVC;
@property (nonatomic, strong) UINavigationController *standardNav;
@property (nonatomic, strong) UINavigationController *demoNav;
@property (nonatomic, strong) UINavigationController *customNav;

@end

@implementation BYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    [[BYBeautify instance] activate];
    
    UITabBarController *tbc = [UITabBarController new];
    [tbc setDelegate:self];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        self.standardVC = [[DemoViewController alloc] initWithNibName:@"DemoiPadViewController" bundle:nil];
        self.demoVC = [[DemoViewController alloc] initWithNibName:@"DemoiPadViewController" bundle:nil];
        self.customVC = [[DemoViewController alloc] initWithNibName:@"DemoiPadViewController" bundle:nil];
    }
    else {
        self.standardVC = [[DemoViewController alloc] initWithNibName:@"DemoiPhoneViewController" bundle:nil];
        self.demoVC = [[DemoViewController alloc] initWithNibName:@"DemoiPhoneViewController" bundle:nil];
        self.customVC = [[DemoViewController alloc] initWithNibName:@"DemoiPhoneViewController" bundle:nil];
    }
    
    self.standardVC.title = @"Standard";
    self.standardVC.beautifyDescripiton = @"This view controller has not been styled by beautify. All the controls you see here should be the default iOS style controls.";
    
    self.demoVC.title = @"Beautified";
    self.demoVC.beautifyDescripiton = @"This view controller has been styled by beautify. All the controls you see here have the default beautify style applied to them, which matches the system styling in iOS 6 and iOS 7. There are a few differences, but we are working on them ;-)";
    
    self.customVC.title = @"Customised";
    self.customVC.beautifyDescripiton = @"This view controller has been styled by beautify. All the controls you see here have had a custom beautify style applied to them. The switch above allows you to swap the current theme.";
    self.customVC.applyCustomStyles = YES;
    
    self.standardNav = [[UINavigationController alloc] initWithRootViewController:self.standardVC];
    self.demoNav = [[UINavigationController alloc] initWithRootViewController:self.demoVC];
    self.customNav = [[UINavigationController alloc] initWithRootViewController:self.customVC];
    
    [self.standardNav setImmuneToBeautify:YES];
    
    [tbc setViewControllers:@[self.standardNav, self.demoNav, self.customNav]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController{
    if(viewController == self.demoNav) {
        [[BYThemeManager instance] applyTheme:[BYTheme new]];
    }
}

@end