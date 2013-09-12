//
//  AppDelegate.m
//  ParserTest
//
//  Created by Chris Grant on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "AppDelegate.h"
#import "VisualTestViewController.h"
#import "ShadowTestViewController.h"

#import "Beautify.h"

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // enhance the UI controls
    [[SCBeautify instance] activate];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[VisualTestViewController new]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end