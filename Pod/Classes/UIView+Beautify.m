//
//  UIView+Beautify.m
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+Beautify.h"
#import "UIView+BeautifyPrivate.h"
#import "BYStyleRenderer.h"
#import "NSObject+Beautify.h"
#import "UIView+Utilities.h"

@implementation UIView (Beautify)

-(BYStyleRenderer*)renderer {
    [self createRenderer];
    return objc_getAssociatedObject(self, @"renderer");
}

-(void)override_didMoveToWindow {
    [self createRenderer];
    [self override_didMoveToWindow];
}

-(BOOL)isImmuneToBeautify {
    return [super isImmuneToBeautify];
}

-(void)setImmuneToBeautify:(BOOL)immuneToBeautify{
    [super setImmuneToBeautify:immuneToBeautify];
    for (UIView *v in self.subviews) {
        [v recursivelySetSubViewImmunity:immuneToBeautify];
    }
}

@end