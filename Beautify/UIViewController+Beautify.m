//
//  UIViewController+Beautify.m
//  Beautify
//
//  Created by Adrian Conlin on 24/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <objc/runtime.h>
#import "BYVersionUtils.h"
#import "UIViewController+Beautify.h"
#import "UIViewController+BeautifyPrivate.h"
#import "BYStyleRenderer.h"
#import "BYStyleRenderer_Private.h"
#import "UIView+BeautifyPrivate.h"
#import "UIView+Beautify.h"
#import "NSObject+Beautify.h"
#import "UIView+Utilities.h"

@implementation UIViewController (Beautify)

-(BYStyleRenderer*)renderer {
    [self createRenderer];
    return objc_getAssociatedObject(self, @"renderer");
}

// overrides viewDidLoad to create and associate a renderer with this control
-(void)override_viewDidLoad {
    if([self shouldCreateRenderer]) {
        [self createRenderer];
        UIBarButtonItem *i = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain
                                                             target:nil action:nil];
        self.navigationItem.backBarButtonItem = i;
    }
    [self override_viewDidLoad];
}

-(void)override_viewWillLayoutSubviews {
    [[self renderer] redraw];
    [self override_viewWillLayoutSubviews];
}

-(BOOL)isImmuneToBeautify {
    return [super isImmuneToBeautify];
}

-(void)setImmuneToBeautify:(BOOL)immuneToBeautify {
    [super setImmuneToBeautify:immuneToBeautify];
    
    if([self isKindOfClass:[UINavigationController class]]) {
        // If this is a navigation controller, make sure all of the view controllers recieve the immunity message too.
        UINavigationController *nc = (UINavigationController*)self;
        for (UIViewController *vc in nc.viewControllers) {
            [vc setImmuneToBeautify:immuneToBeautify];
        }
    }
    [self.view recursivelySetSubViewImmunity:immuneToBeautify];
}

-(BOOL)shouldCreateRenderer {
    if([self isKindOfClass:NSClassFromString(@"_UIModalItemsPresentingViewController")]) {
        return NO;
    }
    return YES;
}

-(void)themeUpdated:(NSNotification*)notification {
    // Commit the whole theme update as a CATransaction without animations. This improves performance.
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    {
        BYTheme *theme = notification.object;
        [self.renderer setTheme:theme];
        [self.view applyTheme:theme];
    }
    [CATransaction commit];
}

-(void)didRotate:(NSNotification*)notification {
    [self.renderer redraw];
}

@end