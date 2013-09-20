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

@implementation BYAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    
    [[BYBeautify instance] activate];
    
    UITabBarController *tbc = [UITabBarController new];
    
    DemoViewController *standardVC;
    DemoViewController *demoVC;
    DemoViewController *customVC;
    
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
    
    [tbc setViewControllers:@[[[UINavigationController alloc] initWithRootViewController:standardVC],
                              [[UINavigationController alloc] initWithRootViewController:demoVC],
                              [[UINavigationController alloc] initWithRootViewController:customVC]]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end