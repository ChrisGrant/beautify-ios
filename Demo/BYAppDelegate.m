//
//  BYAppDelegate.m
//  Demo
//
//  Created by Chris Grant on 18/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYAppDelegate.h"
#import <Beautify/BYBeautify.h>

@implementation BYAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    
    [[BYBeautify instance] activate];
    
    return YES;
}

@end