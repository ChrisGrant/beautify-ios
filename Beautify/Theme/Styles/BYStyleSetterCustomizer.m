//
//  BYStyleSetterCustomizer.m
//  Beautify
//
//  Created by Colin Eberhardt on 10/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYStyleSetterCustomizer.h"
#import "BYStateSetter.h"

@implementation BYStyleSetterCustomizer {
    __weak BYStyle* _style;
    NSMutableDictionary* _stateSetters;
}

-(id)initWithStyle:(BYStyle*)style forState:(UIControlState)state {
    if (self = [super init]) {
        _style = style;
        
        // extract the setters that relate to the given state
        _stateSetters = [NSMutableDictionary new];
        for (BYStateSetter* setter in style.stateSetters) {
            if (setter.state == state) {
                [_stateSetters setValue:setter forKey:setter.propertyName];
            }
        }
    }
    return self;
}

-(id)propertyValueForName:(NSString*)name {
    // if we have a state setter for the named property - use that value from that
    BYStateSetter* stateSetter = [_stateSetters valueForKey:name];
    id value;
    if (stateSetter != nil) {
        value = stateSetter.value;
    } else  {
        // otherwise delegate to the adapted style
        value = [_style propertyValueForName:name];
    }
    return value;
}

@end