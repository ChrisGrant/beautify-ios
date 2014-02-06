//
//  BYSearchBarRenderer.m
//  Beautify
//
//  Created by Chris Grant on 06/02/2014.
//  Copyright (c) 2014 Beautify. All rights reserved.
//

#import "BYSearchBarRenderer.h"
#import "BYControlRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYStyleRenderer_Private.h"
#import "BYSearchBarStyle.h"

@implementation BYSearchBarRenderer

-(id)initWithView:(id)view theme:(BYTheme*)theme{
    if(self = [super initWithView:view theme:theme]) {
        [self setup:view theme:theme];
    }
    return self;
}

-(void)setup:(UISearchBar*)searchBar theme:(BYTheme*)theme {
    [searchBar setBackgroundImage:[UIImage new]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:searchBar.bounds];
    [backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
//    _backgroundLayer = [[BYControlRenderingLayer alloc] initWithRenderer:self];
//    [backgroundView.layer addSublayer:_backgroundLayer];
//    
//    [tabBar addSubview:backgroundView];
//    [tabBar sendSubviewToBack:backgroundView];
    
    [self configureFromStyle];
}

-(void)configureFromStyle {
    [super configureFromStyle];
    
    UISearchBar *bar = self.adaptedView;
    [bar setTintColor:[UIColor redColor]];
}

-(BYSearchBarStyle*)styleFromTheme:(BYTheme*)theme {
//    if(theme.tabBarStyle) {
//        return theme.tabBarStyle;
//    }
    return [BYSearchBarStyle defaultStyle];
}

@end