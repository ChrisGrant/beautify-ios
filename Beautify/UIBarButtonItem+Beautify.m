//
//  UIBarButtonItem+Beautify.m
//  Beautify
//
//  Created by Daniel Allsop on 02/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIBarButtonItem+Beautify.h"
#import "BYStyleRenderer.h"
#import "BYStyleRenderer_Private.h"
#import "BYThemeManager.h"
#import "BYThemeManager_Private.h"
#import <objc/runtime.h>
#import "UIView+Beautify.h"
#import "UIView+BeautifyPrivate.h"
#import "UIBarButtonItem+BeautifyPrivate.h"
#import "NSObject+Beautify.h"

@implementation UIBarButtonItem (Beautify)

-(BYStyleRenderer*)renderer {
    [self createRenderer];
    return objc_getAssociatedObject(self, @"renderer");
}

-(void)override_init{
    [self override_init];
    [self createRenderer];
}

-(void)createRenderer {
    // create a renderer for instances not marked as immune to Beautify
    if (!self.isImmuneToBeautify && objc_getAssociatedObject(self, @"renderer") == nil){// && [self valueForKey:@"view"] != nil) {
        BYStyleRenderer* renderer = [[BYThemeManager instance] rendererForView:self];

        if (renderer != nil) {
            objc_setAssociatedObject(self, @"renderer", renderer, OBJC_ASSOCIATION_RETAIN);
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeUpdated:)
                                                         name:CSThemeUpdatedNotification object:nil];
        }
        else {
            NSLog(@"Renderer for UI element not found: %@", self.class);
        }
    }
}

-(void)removeRenderer{
    objc_setAssociatedObject(self, @"renderer", nil, OBJC_ASSOCIATION_RETAIN);
}

-(void)override_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self override_dealloc];
}

-(void)themeUpdated:(NSNotification*)notification {
    if(!self.isImmuneToBeautify){
        BYTheme *theme = notification.object;
        [self.renderer setTheme:theme];
    }
}

-(BOOL)isImmuneToBeautify{
    return [super isImmuneToBeautify];
}

-(void)setImmuneToBeautify:(BOOL)immuneToBeautify{
    [super setImmuneToBeautify:immuneToBeautify];
}

@end
