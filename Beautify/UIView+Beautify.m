//
//  UIView+Beautify.m
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+Beautify.h"
#import "UIView+BeautifyPrivate.h"
#import "BYStyleRenderer.h"
#import "NSObject+Beautify.h"

@implementation UIView (Beautify)

-(BYStyleRenderer*)renderer {
    [self createRenderer];
    return objc_getAssociatedObject(self, @"renderer");
}

-(void)override_didMoveToWindow {
    [self createRenderer];
    [self override_didMoveToWindow];
}

-(BOOL)isImmuneToBeautify{
    if ([super isImmuneToBeautify]) {
        return YES;
    }
    
    // This view isn't immune, but check that none of it's parents are immune to beautify.
    id resp = [self nextResponder];
    while (resp != nil) {
        if([resp respondsToSelector:@selector(isImmuneToBeautify)]) {
            if([resp isImmuneToBeautify]) {
                return YES;
            }
        }
        resp = [resp nextResponder];
    }
    
    return NO;
}

-(void)setImmuneToBeautify:(BOOL)immuneToBeautify{
    [super setImmuneToBeautify:immuneToBeautify];
}

@end