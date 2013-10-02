//
//  JSONModel+Subclassing.m
//  Beautify
//
//  Created by Chris Grant on 02/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "JSONModel+Subclassing.h"

@implementation JSONModel (Subclassing)

+(BOOL)isSubclassOfClass:(Class)aClass {
    for(Class candidate = self; candidate != nil; candidate = [candidate superclass]) {
        if ([NSStringFromClass(candidate) isEqualToString:NSStringFromClass(aClass)]) {
            return YES;
        }
    }
    return NO;
}

@end