//
//  BYTabBarRenderer.m
//  Beautify
//
//  Created by CG on 24/11/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYTabBarRenderer.h"
#import "BYStyleRenderer_Private.h"
#import "BYTabBarStyle.h"
#import "BYControlRenderingLayer.h"
#import "BYViewRenderer_Private.h"

@implementation BYTabBarRenderer {
    BYControlRenderingLayer *_backgroundLayer;
}

-(id)initWithView:(id)view theme:(BYTheme*)theme{
    if(self = [super initWithView:view theme:theme]) {
        [self setup:view theme:theme];
    }
    return self;
}

-(void)setup:(UITabBar*)tabBar theme:(BYTheme*)theme {
    [tabBar setBackgroundImage:[UIImage new]];
    [tabBar setShadowImage:[UIImage new]];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:tabBar.bounds];
    [backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    _backgroundLayer = [[BYControlRenderingLayer alloc] initWithRenderer:self];
    [backgroundView.layer addSublayer:_backgroundLayer];
    
    [tabBar addSubview:backgroundView];
    [tabBar sendSubviewToBack:backgroundView];
    
    [self configureFromStyle];
}

-(void)configureFromStyle {
    [super configureFromStyle];
    
    UITabBar *bar = self.adaptedView;
    [bar setTintColor:[self.style tintColor]];
    
    [_backgroundLayer setFrame:bar.bounds];
    [_backgroundLayer setNeedsDisplay];
}

-(BYTabBarStyle*)styleFromTheme:(BYTheme*)theme {
    if(theme.tabBarStyle) {
        return theme.tabBarStyle;
    }
    return [BYTabBarStyle defaultStyle];
}

@end