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

@implementation UIViewController (Beautify)

-(BYStyleRenderer*)renderer {
    [self createRenderer];
    return objc_getAssociatedObject(self, @"renderer");
}

// overrides viewDidLoad to create and associate a renderer with this control
-(void)override_viewDidLoad {
    if([self shouldCreateRenderer]) {
        [self createRenderer];
    }
    [self override_viewDidLoad];
}

-(BOOL)isImmuneToBeautify {
    return objc_getAssociatedObject(self, @"immuneToBeautify") != nil;
}

-(void)setImmuneToBeautify:(BOOL)immuneToBeautify {
    id immunityFlag = immuneToBeautify ? [NSObject new] : nil;
    objc_setAssociatedObject(self, @"immuneToBeautify", immunityFlag, OBJC_ASSOCIATION_RETAIN);
}

-(BOOL)shouldCreateRenderer {
    if([self isKindOfClass:NSClassFromString(@"_UIModalItemsPresentingViewController")]) {
        return NO;
    }
    return YES;
}

-(void)themeUpdated:(NSNotification*)notification {
    BYTheme *theme = notification.object;
    [self.renderer setTheme:theme];
    [self.view applyTheme:theme];
}

-(void)didRotate:(NSNotification*)notification {
    [self.renderer redraw];
}

@end