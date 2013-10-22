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

#import "BYBarButtonItemRenderer.h"

@implementation UINavigationBar (Beautify)

-(void)override_layoutSubviews{
    [self override_layoutSubviews];
    
    if (!self.isImmuneToBeautify) {
        
        // Find all of the UINavigationItems and then set the last one to be the back button renderer.
        NSArray *barviews = [self searchForBackButtonInSubviewsOfView:self];
        if(barviews.count > 0) {
            UIView *backBarView = barviews[barviews.count - 1];
            [backBarView createRenderer];
            if([[backBarView renderer] isKindOfClass:[BYBarButtonItemRenderer class]]) {
                BYBarButtonItemRenderer *renderer = (BYBarButtonItemRenderer*)backBarView.renderer;
                [renderer setIsBackButtonRenderer:YES];
                [renderer setTheme:[[BYThemeManager instance] currentTheme]];
                [renderer redraw];
            }
        }
        
        [[self renderer] redraw];

        [[self allBarItems] enumerateObjectsUsingBlock:^(UIBarButtonItem *item, NSUInteger idx, BOOL *stop) {
            UIView *v = [item valueForKey:@"view"];
            [v createRenderer];
            [[v renderer] redraw];
        }];
    }
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
        
        if([self respondsToSelector:@selector(setBackIndicatorImage:)]
           && [self respondsToSelector:@selector(setBackIndicatorTransitionMaskImage:)]) {
            // Hide the default back indicator images.
            [self setBackIndicatorImage:[UIImage new]];
            [self setBackIndicatorTransitionMaskImage:[UIImage new]];
        }
    }
}

-(void)override_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self override_dealloc];
}

-(void)themeUpdated:(NSNotification*)notification {
    // Commit the whole theme update as a CATransaction without animations. This improves performance.
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    {
        BYTheme *theme = notification.object;
        [self.renderer setTheme:theme];
        
        [[self allBarItems] enumerateObjectsUsingBlock:^(UIBarButtonItem *item, NSUInteger idx, BOOL *stop) {
            UIView *v = [item valueForKey:@"view"];
            [[v renderer] setTheme:theme];
        }];
    }
    [CATransaction commit];
}

// Combines all of the bar items into a single array.
-(NSArray*)allBarItems {
    NSMutableArray *array = [NSMutableArray new];
    for (UINavigationItem *item in self.items) {
        if(item.leftBarButtonItems)
            [array addObject:item.leftBarButtonItem];
        [array addObjectsFromArray:item.leftBarButtonItems];
        
        if(item.rightBarButtonItem)
            [array addObject:item.rightBarButtonItem];
        [array addObjectsFromArray:item.rightBarButtonItems];
        
        if(item.backBarButtonItem)
            [array addObject:item.backBarButtonItem];
    }
    return array;
}

@end