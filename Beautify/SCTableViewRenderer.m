//
//  SCTableViewRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 03/06/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCTableViewRenderer.h"
#import "SCViewRenderer_Private.h"
#import "SCStyleRenderer_Private.h"
#import "SCTheme.h"

@implementation SCTableViewRenderer

-(id)initWithView:(id)view theme:(SCTheme*)theme {
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

-(id)styleFromTheme:(SCTheme*)theme {
    return nil;
}

@end