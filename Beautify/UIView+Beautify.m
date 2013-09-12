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
#import "SCStyleRenderer.h"
#import "NSObject+Beautify.h"

@implementation UIView (Beautify)

-(SCStyleRenderer*)renderer {
    [self createRenderer];
    return objc_getAssociatedObject(self, @"renderer");
}

-(void)override_didMoveToWindow {
    [self createRenderer];
    [self override_didMoveToWindow];
}

-(BOOL)isImmuneToBeautify{
    if([super respondsToSelector:@selector(isImmuneToBeautify)]) {
        return [super isImmuneToBeautify];
    }
    return YES;
}

-(void)setImmuneToBeautify:(BOOL)immuneToBeautify{
    [super setImmuneToBeautify:immuneToBeautify];
}

@end