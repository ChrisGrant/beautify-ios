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
        NSString *propertyName = @(name);
        if (![self shouldExclude:propertyName]) {
            [propertyNames addObject:propertyName];
        }
    }
    free(properties);
    
    // add superclass properties
    NSMutableArray *superPropertyNames = [NSMutableArray new];
    if (propertyClass.superclass != [NSObject class]) {
        if(propertyClass) {
            superPropertyNames = [self propertyNames:propertyClass.superclass];
        }
    }
    for (NSString *superPropertyName in superPropertyNames) {
        if (![self shouldExclude:superPropertyName]) {
            [propertyNames addObject:superPropertyName];
        }
    }
    
    return propertyNames;
}

+ (BOOL)shouldExclude:(NSString *)string {
    return [string isEqualToString:@"hash"] || [string isEqualToString:@"superclass"] ||
        [string isEqualToString:@"description"] || [string isEqualToString:@"debugDescription"];
}

@end