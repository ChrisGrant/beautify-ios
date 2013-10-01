//
//  ConfigParser.m
//  Property Finder
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYConfigParser_Private.h"
#import "BYButtonStyle.h"
#import "BYSwitchStyle.h"
#import "BYLabelStyle.h"
#import "BYViewControllerStyle.h"
#import "BYGradientStop.h"
#import "UIColor+HexColors.h"
#import "NSObject+Properties.h"
#import "BYFont.h"
#import "BYBorder.h"
#import "BYBackgroundImage.h"
#import "BYTheme.h"
#import "BYStateSetter.h"
#import "BYTextFieldStyle.h"
#import "BYSwitchState.h"
#import "NSDictionary+Utilities.h"
#import "BYTextShadow.h"
#import "BYNavigationBarStyle.h"
#import "BYTableViewCellStyle.h"
#import "BYImageViewStyle.h"
#import "BYSliderStyle.h"

@implementation BYConfigParser

#pragma mark - Beautify Property parsing

+(BYTextShadow*)textShadowFromDict:(NSDictionary *)dict {
    if(![dict.allKeys containsObject:@"offset"]) {
        return nil;
    }
    BYTextShadow* shadow = [BYTextShadow new];
    [shadow setOffset:[self sizeFromDict:[dict objectForMandatoryKey:@"offset"]]];
    [shadow setColor:[self colorFromDict:dict key:@"color"]];
    return shadow;
}

+(BYStateSetter*)stateSetterFromDict:(NSDictionary *)setterDict {
    if(![setterDict.allKeys containsObject:@"propertyName"] || ![setterDict.allKeys containsObject:@"state"]) {
        return nil;
    }
    
    BYStateSetter* setter = [BYStateSetter new];
    setter.propertyName = [setterDict objectForMandatoryKey:@"propertyName"];
    setter.state = [self stateFromString:[setterDict objectForMandatoryKey:@"state"]];
    
    // Package the value into a dictionary so that it is in the same format as the original JSON
    NSMutableDictionary* propertyDict = [NSMutableDictionary new];
    [propertyDict setValue:[setterDict objectForMandatoryKey:@"value"] forKey:setter.propertyName];
    
    // Check the propertyName. Is it a property we need to parse from JSON or is it a primitive?
    
    
//    setter.value = [self parseValueForName:setter.propertyName dict:propertyDict];
    
    return setter;
}

+(BYBackgroundImage*)backgroundImageFromDict:(NSDictionary *)backgroundImageDict {
    BYBackgroundImage *bgImage = [BYBackgroundImage new];
    
    if(![backgroundImageDict isKindOfClass:[NSDictionary class]]) {
        NSLog(@"WARNING - Image was not a dictionary. Can not parse.");
        return nil;
    }
    
    if([backgroundImageDict.allKeys containsObject:@"data"]) {
        NSString* dataStr = [backgroundImageDict objectForMandatoryKey:@"data"];
        bgImage.data = [self imageFromBase64String:dataStr];
    }
    else {
        NSLog(@"WARNING - Image had no 'data' property");
    }
    
    bgImage.contentMode = [BYConfigParser contentModeFromDict:backgroundImageDict];
    
    return bgImage;
}

+(BYImageContentMode)contentModeFromDict:(NSDictionary*)dict {
    if([[dict allKeys] containsObject:@"contentMode"]) {
        NSString *contentString = [dict[@"contentMode"] lowercaseString];
        if([contentString isEqualToString:@"fill"]) {
            return BYImageContentModeFill;
        }
        else if([contentString isEqualToString:@"aspectfill"]) {
            return BYImageContentModeAspectFill;
        }
        else if([contentString isEqualToString:@"tile"]) {
            return BYImageContentModeTile;
        }
    }
    return BYImageContentModeFill; // Default to fill.
}

#pragma mark Gradients

+(BYGradient*)gradientFromDict:(NSDictionary*)gradientDict {
    if(!gradientDict || ![gradientDict.allKeys containsObject:@"radial"] || ![gradientDict.allKeys containsObject:@"stops"]) {
        return nil;
    }
    
    BYGradient *gradient = [BYGradient new];
    gradient.radial = [gradientDict boolForMandatoryKey:@"radial"];
    gradient.radialOffset = [self sizeFromDict:gradientDict[@"radialOffset"]];
    gradient.stops = [self colorGradientFromArray:[gradientDict objectForMandatoryKey:@"stops"]];
    return gradient;
}

#pragma mark - Generic utilities

+(CGSize)sizeFromDict:(NSDictionary *)offsetDict {
    float x = 0;
    float y = 0;
    
    if(offsetDict) {
        if ([[offsetDict allKeys] containsObject:@"x"]) {
            if([NSNull null] != offsetDict[@"x"]) {
                x = [offsetDict[@"x"] floatValue];
            }
        }
        if ([[offsetDict allKeys] containsObject:@"y"]) {
            if([NSNull null] != offsetDict[@"y"]) {
                y = [offsetDict[@"y"] floatValue];
            }
        }
    }
    return CGSizeMake(x, y);
}

+(UIControlState)stateFromString:(NSString*)stateString {
    if ([[stateString lowercaseString] isEqualToString:@"highlighted"]) {
        return UIControlStateHighlighted;
    }
    else if ([[stateString lowercaseString] isEqualToString:@"disabled"]) {
        return UIControlStateDisabled;
    }
    else if ([[stateString lowercaseString] isEqualToString:@"selected"]) {
        return UIControlStateSelected;
    }
    return UIControlStateNormal;
}

@end