//
//  BYTableViewRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 03/06/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYTableViewRenderer.h"
#import "BYViewRenderer_Private.h"
#import "BYStyleRenderer_Private.h"
#import "BYTheme.h"

@implementation BYTableViewRenderer

-(instancetype)initWithView:(id)view theme:(BYTheme*)theme {
    if (self = [super initWithView:view theme:theme]) {
        // Hijack the label rendering
        [self setup:(UITableView*)view];
    }
    return self;
}

-(void)setup:(UITableView*)tableView {
    tableView.separatorColor = [UIColor clearColor];
    [self configureFromStyle];
}

-(id)styleFromTheme:(BYTheme*)theme {
    return nil;
}

@end