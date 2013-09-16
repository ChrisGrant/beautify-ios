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
#import "UIBarButtonItem+BeautifyPrivate.h"

@implementation UINavigationBar (Beautify)

-(void)override_layoutSubviews{
    [self override_layoutSubviews];
    
    for(UINavigationItem *uiNavigationbarItem in self.items){
        if([uiNavigationbarItem.rightBarButtonItems count] > 0){
            [self createRedererForEachItemInArray:uiNavigationbarItem.rightBarButtonItems];
        }
    
        if([uiNavigationbarItem.leftBarButtonItems count] > 0){
            [self createRedererForEachItemInArray:uiNavigationbarItem.leftBarButtonItems];
        }
    
        if(uiNavigationbarItem.backBarButtonItem){
            UIBarButtonItem *barButtonItem = uiNavigationbarItem.backBarButtonItem;
            if(![barButtonItem isImmuneToBeautify]){
                [barButtonItem createRenderer];
            }
        }
    }
}

-(void)createRedererForEachItemInArray:(NSArray*)array{
    for(UINavigationItem *navBarItem in array){
        if([[navBarItem valueForKey:@"view"] isKindOfClass:[UIToolbar class]]){
            UIToolbar *toolbar = (UIToolbar*)[navBarItem valueForKey:@"view"];
            [self createRedererForEachItemInArray:toolbar.items];
        }
        else {
            UIBarButtonItem *barButtonItem = (UIBarButtonItem*)navBarItem;
            if([navBarItem isKindOfClass:[UIBarButtonItem class]] && ![barButtonItem isImmuneToBeautify]){
                if(barButtonItem.renderer && [barButtonItem.renderer adaptedView] != nil){
                    [barButtonItem createRenderer];
                }
                else {
                    NSMutableArray *values = [(BYBarButtonItemRenderer*)barButtonItem.renderer values];
                    NSMutableArray *names = [(BYBarButtonItemRenderer*)barButtonItem.renderer names];
                    NSMutableArray *controlStates = [(BYBarButtonItemRenderer*)barButtonItem.renderer controlStates];
                    [barButtonItem removeRenderer];
                    [barButtonItem createRenderer];
                    [barButtonItem.renderer setValues:values];
                    [barButtonItem.renderer setNames:names];
                    [barButtonItem.renderer setControlStates:controlStates];
                    [barButtonItem.renderer styleViaStoredValueNamesAndStates];
                }
            }
        }
    }
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