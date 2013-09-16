//
//  BaseStyle.m
//  Beautify
//
//  Created by Adrian Conlin on 07/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYStyleCustomizer.h"

@implementation BYStyleCustomizer {
    NSMutableDictionary *_customizedProperties;
    id<BYStyleProtocol> _customizedStyle;
}

-(id)initWithStyle:(id<BYStyleProtocol>)style {
    if (self = [super init]) {
        _customizedStyle = style;
    }
    return self;
}

-(void)updateWithStyle:(id<BYStyleProtocol>)style {
    _customizedStyle = style;
}

-(void)setPropertyValue:(id)value forName:(NSString*)name {
    if(!_customizedProperties) {
        _customizedProperties = [NSMutableDictionary new];
    }
    _customizedProperties[name] = value;
}

-(void)removePropertyValueForName:(NSString*)name {
    [_customizedProperties removeObjectForKey:name];
}

-(id)propertyValueForName:(NSString*)name {
    id value = _customizedProperties[name];
    if (value == nil) {
        value = [_customizedStyle propertyValueForName:name];
    }
    return value;
}

@end