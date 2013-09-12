//
//  UISlider+Beautify.m
//  Beautify
//
//  Created by Chris Grant on 11/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UISlider+Beautify.h"
#import "UIView+BeautifyPrivate.h"

@implementation UISlider (Beautify)

-(void)override_didMoveToWindow {
    [self createRenderer];
    [self override_didMoveToWindow];
}

@end