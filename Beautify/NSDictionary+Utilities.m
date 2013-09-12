//
//  NSDictionary+Utilities.m
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "NSDictionary+Utilities.h"

@implementation NSDictionary (Utilities)

-(id)objectForMandatoryKey:(NSString*)key {
    id value = self[key];
    if (value == nil || value == [NSNull null]) {
        NSLog(@"ERROR: Mandatory property was missing key \"%@\"", key);
    }
    return value;
}

-(BOOL)boolForMandatoryKey:(NSString*)key {
    id value = [self objectForMandatoryKey:key];
    if(value == [NSNull null]) {
        return NO;
    }
    return [value boolValue];
}

-(int)intForMandatoryKey:(NSString*)key {
    id value = [self objectForMandatoryKey:key];
    if(value == [NSNull null]) {
        return 0;
    }
    return [value intValue];
}

-(float)floatForMandatoryKey:(NSString*)key {
    id value = [self objectForMandatoryKey:key];
    if(value == [NSNull null]) {
        return 0.0f;
    }
    return [value floatValue];
}

@end