//
//  BYStateSetter.m
//  Beautify
//
//  Created by Colin Eberhardt on 09/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYStateSetter.h"
#import "JSONValueTransformer+BeautifyExtension.h"
#import "BYText.h"
#import "BYBackgroundImage.h"
#import "BYShadow.h"
#import "BYTextShadow.h"
#import "BYBorder.h"
#import "BYSwitchState.h"
#import "BYGradient.h"

static JSONValueTransformer* valueTransformer = nil;
static NSArray* colors = nil;
static NSDictionary* styleProperties = nil;

@implementation BYStateSetter {
    id _val;
    UIControlState _state;
}

- (id)value {
    return _val;
}

- (void)setValue:(id)val {
    _val = val;
}

- (UIControlState)state {
    return _state;
}

- (void)setState:(UIControlState)state {
    _state = state;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"property : %@, value : %@",
            self.propertyName, self.value];
}

// Override initWithDictionary here because we don't know what "value" will be. So we need to handle it manually.
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    if([dict.allKeys containsObject:@"value"] && [dict.allKeys containsObject:@"state"] &&
       [dict.allKeys containsObject:@"propertyName"]) {
        
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            valueTransformer = [[JSONValueTransformer alloc] init];
            colors = @[@"color",
                       @"backgroundcolor",
                       @"thumbbackgroundcolor",
                       @"minimumtrackcolor",
                       @"maximumtrackcolor",
                       @"thumbbackgroundcolor",
                       @"highlightcolor"];
            styleProperties = @{@"title"  : [BYText class],
                                @"titleshadow" : [BYTextShadow class],
                                @"backgroundgradient" : [BYGradient class],
                                @"backgroundimage" : [BYBackgroundImage class],
                                @"border" : [BYBorder class],
                                @"barborder" : [BYBorder class],
                                @"minimumtrackimage" : [UIImage class],
                                @"minimumtrackbackgroundgradient" : [BYGradient class],
                                @"maximumtrackimage" : [UIImage class],
                                @"maximumtrackbackgroundgradient" : [BYGradient class],
                                @"thumbborder" : [BYBorder class],
                                @"thumbimage" : [UIImage class],
                                @"thumbbackgroundgradient" : [BYGradient class],
                                @"tracklayerimage" : [UIImage class],
                                @"borderlayerimage" : [UIImage class],
                                @"accessoryviewimage" : [UIImage class],
                                @"editingaccessoryviewimage" : [UIImage class],
                                @"onstate" : [BYSwitchState class],
                                @"offstate" : [BYSwitchState class],
                                @"innershadow" : [BYShadow class],
                                @"outershadow" : [BYShadow class],
                                @"barinnershadow" : [BYShadow class],
                                @"baroutershadow" : [BYShadow class],
                                @"thumbinnershadow" : [BYShadow class],
                                @"thumboutershadow" : [BYShadow class],
                                };
        });
        
        BYStateSetter *stateSetter = [BYStateSetter new];
        stateSetter.propertyName = dict[@"propertyName"];
        stateSetter.state = [valueTransformer stateFromString:dict[@"state"]];
        
        id value = dict[@"value"];

        if([colors containsObject:stateSetter.propertyName.lowercaseString]) {
            stateSetter.value = [valueTransformer UIColorFromNSString:value];
        }
        else if ([styleProperties.allKeys containsObject:stateSetter.propertyName.lowercaseString]) {
            Class c = styleProperties[stateSetter.propertyName.lowercaseString];
            if(c == [UIImage class]) {
                stateSetter.value = [valueTransformer UIImageFromNSString:value];
            }
            else {
                if([c instancesRespondToSelector:@selector(initWithDictionary:error:)]) {
                    stateSetter.value = [[c alloc] initWithDictionary:value error:err];
                }
                else {
                    NSLog(@"State Setter Error - Class %@ does not respond to init with dictionary.", c);
                }
            }
        }
        else {
            NSLog(@"State Setter Error - Unknown Property Name %@", stateSetter.propertyName);
        }
        return stateSetter;
    }
    NSLog(@"State Setter Error - State setters MUST have propertyName, state and value");
    return nil;
}

+ (BOOL)propertyIsIgnored:(NSString *)propertyName {
    return YES;
}

@end