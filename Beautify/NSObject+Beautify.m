//
//  NSObject+Beautify.m
//  Beautify
//
//  Created by Daniel Allsop on 06/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "NSObject+Beautify.h"
#import <objc/runtime.h>

#define IMMUNE_TO_BEAUTIFY_NAME @"immuneToBeautify"

@implementation NSObject (Beautify)

-(BOOL)isImmuneToBeautify {
    id immunityObject = objc_getAssociatedObject(self, IMMUNE_TO_BEAUTIFY_NAME);
    if(immunityObject) {
        return [immunityObject boolValue];
    }
    else {
        if([self isKindOfClass:[UIImageView class]]) {
            // If the object is nil, usually we return NO. In this case we return YES. Don't style images by default.
            return YES;
        }
        return NO;
    }
}

-(void)setImmuneToBeautify:(BOOL)immune {
    objc_setAssociatedObject(self,
                             IMMUNE_TO_BEAUTIFY_NAME,
                             [NSNumber numberWithBool:immune],
                             OBJC_ASSOCIATION_RETAIN);
    
}

@end