//
//  UINavigationBar+Beautify.m
//  Beautify
//
//  Created by Daniel Allsop on 24/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <objc/runtime.h>
#import "BYStyleRenderer_Private.h"
#import "UIView+Beautify.h"
#import "BYThemeManager_Private.h"
#import "UIView+BeautifyPrivate.h"

#import "UIView+Utilities.h"

#import "BYBackBarButtonItemRenderer.h"

@implementation UINavigationBar (Beautify)

-(void)override_layoutSubviews{
    [self override_layoutSubviews];
    [self searchForBackButtonInSubviewsOfView:self];
    
    // Find all of the UINavigationItems and then set the last one to be the back button renderer.
    NSArray *barviews = [self searchForBackButtonInSubviewsOfView:self];
    if(barviews.count > 0) {
        UIView *backBarView = barviews[barviews.count - 1];
        [backBarView createRenderer];
        if([[backBarView renderer] isKindOfClass:[BYBackBarButtonItemRenderer class]]) {
            BYBackBarButtonItemRenderer *renderer = (BYBackBarButtonItemRenderer*)backBarView.renderer;
            [renderer setIsBackButtonRenderer:YES];
        }
    }
    
    // Go through all of the items and check they have a renderer.
    for (UINavigationItem *item in self.items) {
        [self createRendererForItem:item.leftBarButtonItem];
        for(UIBarButtonItem *bbi in item.rightBarButtonItems) {
            [self createRendererForItem:bbi];
        }
        
        [self createRendererForItem:item.rightBarButtonItem];
        for(UIBarButtonItem *bbi in item.leftBarButtonItems) {
            [self createRendererForItem:bbi];
        }
    }
}

-(void)createRendererForItem:(UIBarButtonItem *)bbi {
    UIView *v = [bbi valueForKey:@"view"];
    [v createRenderer];
}

// Recursively finds an array of all the UINavigationItemButtonViews
-(NSArray*)searchForBackButtonInSubviewsOfView:(UIView*)view {
    NSMutableArray *array = [NSMutableArray new];
    if([view isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
        [array addObject:view];
    }
    else {
        for (UIView *v in view.subviews) {
            [array addObjectsFromArray:[self searchForBackButtonInSubviewsOfView:v]];
        }
    }
    return array;
}

-(void)createRenderer {
    // create a renderer for instances not marked as immune to Beautify
    if (!self.isImmuneToBeautify && objc_getAssociatedObject(self, @"renderer") == nil) {
        BYStyleRenderer* renderer = [[BYThemeManager instance] rendererForView:self];
        if (renderer != nil) {
            objc_setAssociatedObject(self, @"renderer", renderer, OBJC_ASSOCIATION_RETAIN);
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeUpdated:) name:CSThemeUpdatedNotification object:nil];
        }
        else {
            NSLog(@"Renderer for UI element not found: %@", self.class);
        }
        
#warning TODO - do we want to do this? Check the style to see. If it's default and we don't specify any bg etc we don't want to. Otherwise yes.
        [self setBackIndicatorImage:[UIImage new]];
        [self setBackIndicatorTransitionMaskImage:[UIImage new]];
    }
}

-(void)override_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self override_dealloc];
}

-(void)themeUpdated:(NSNotification*)notification {
    BYTheme *theme = notification.object;
    [self.renderer setTheme:theme];
}

@end