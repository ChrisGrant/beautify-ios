//
//  AppDelegate.m
//  ParserTest
//
//  Created by Chris Grant on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "AppDelegate.h"
#import "FullVisualTestViewController.h"
#import "ShadowTestViewController.h"

#import "Beautify.h"

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // enhance the UI controls
    [[BYBeautify instance] activate];
    
    return YES;
}

@end