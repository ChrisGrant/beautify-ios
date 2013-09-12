//
//  UISwitch+Beautify.m
//  Beautify
//
//  Created by Chris Grant on 05/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UISwitch+Beautify.h"
#import <objc/runtime.h>
#import "UIView+Beautify.h"

#define BEAUTIFY_SWITCH_SIZE @"DESIRED_SWITCH_SIZE"

@implementation UISwitch (Beautify)

-(void)setDesiredSwitchSize:(CGSize)size {
    objc_setAssociatedObject(self, BEAUTIFY_SWITCH_SIZE, [NSValue valueWithCGSize:size], OBJC_ASSOCIATION_RETAIN);
}

-(CGSize)desiredSwitchSize {
    NSValue *val = objc_getAssociatedObject(self, BEAUTIFY_SWITCH_SIZE);
    if(!val) {
        return self.frame.size;
    }
    return [val CGSizeValue];
}

@end