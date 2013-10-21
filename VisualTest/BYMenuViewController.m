//
//  BYMenuViewController.m
//  Beautify
//
//  Created by Chris Grant on 21/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "BYMenuViewController.h"
#import "BYThemeManager.h"

@implementation BYMenuViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BYTheme *theme = [BYTheme new];
    [[BYThemeManager instance] applyTheme:theme];
}

@end