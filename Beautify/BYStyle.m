//
//  BYStyle.m
//  Beautify
//
//  Created by Colin Eberhardt on 09/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYStyle.h"

@implementation BYStyle

-(id)propertyValueForName:(NSString *)name
{
    return [self valueForKey:name];
}

-(id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
