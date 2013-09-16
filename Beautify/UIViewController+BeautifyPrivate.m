//
//  UIViewController+BeautifyPrivate.m
//  Beautify
//
//  Created by Adrian Conlin on 24/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+Beautify.h"
#import "UIViewController+BeautifyPrivate.h"
#import "BYThemeManager.h"
#import "BYStyleRenderer.h"
#import "BYStyleRenderer_Private.h"
#import "BYThemeManager_Private.h"

@implementation UIViewController (BeautifyPrivate)

-(void)createRenderer {
    // create a renderer for instances not marked as immune to Beautify
    if (!self.isImmuneToBeautify && objc_getAssociatedObject(self, @"renderer") == nil) {
        BYStyleRenderer* renderer = [[BYThemeManager instance] rendererForView:self];
        if (renderer != nil) {
            objc_setAssociatedObject(self, @"renderer", renderer, OBJC_ASSOCIATION_RETAIN);
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(themeUpdated:)
                                                         name:CSThemeUpdatedNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(didRotate:)
                                                         name:@"UIDeviceOrientationDidChangeNotification"
                                                       object:nil];
        }
    }
}

-(void)override_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self override_dealloc];
}

@end