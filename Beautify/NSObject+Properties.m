//
//  NSObject+Properties.m
//  Beautify
//
//  Created by Chris Grant on 18/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "NSObject+Properties.h"
#import <objc/runtime.h>

@implementation NSObject (Properties)

+(NSMutableArray*)propertyNames:(Class)propertyClass {
    NSMutableArray *propertyNames = [NSMutableArray new];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(propertyClass, &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNames addObject:@(name)];
    }
    free(properties);
    
    // add superclass properties
    NSMutableArray *superPropertyNames = [NSMutableArray new];
    if (propertyClass.superclass != [NSObject class]) {
        superPropertyNames = [self propertyNames:propertyClass.superclass];
    }
    for (NSString *superPropertyName in superPropertyNames) {
        [propertyNames addObject:superPropertyName];
    }
    
    return propertyNames;
}

@end