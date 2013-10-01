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
#import "BYBarButtonStyle.h"

// A 'stack' for generating useful errors when a property parse operation fails
static NSMutableArray* _objectStack;

@implementation BYConfigParser

+(id)parseStyleObjectPropertiesOnClass:(Class)theClass fromDict:(NSDictionary*)dict {
    if(!dict) {
        NSLog(@"Error! Dictionary for %@ was empty!", theClass);
        return nil;
    }
    
    if (_objectStack == nil) {
        _objectStack = [NSMutableArray new];
    }
    
    id newInstance = [theClass new];
    NSMutableArray *names = [self propertyNames:[theClass class]];
    for (NSString *name in names) {
        [self parseName:name newInstance:newInstance withDict:dict];
    }
    
    return newInstance;
}

+(void)parseName:(NSString *)name newInstance:(id)newInstance withDict:(NSDictionary *)dict {
    if([dict isKindOfClass:[NSDictionary class]]) {
        id value = dict[name];
        if (value == nil || value == [NSNull null]) {
            return;
        }
        
        value = [self parseValueForName:name dict:dict];
        if (value) {
            [newInstance setValue:value forKey:name];
        }
    }
}

+(id)parseValueForName:(NSString*)name dict:(NSDictionary*)dict {
    // Put the current name on the stack
    [_objectStack addObject:name];
    
    NSString* lowerCaseName = [name lowercaseString];
    id value;
    
    // handle properties that end with a certain suffix
    if ([lowerCaseName hasSuffix:@"color"]) {
        value = [self colorFromDict:dict key:name];
    }
    else if ([lowerCaseName hasSuffix:@"gradient"]) {
        value = [self gradientFromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([lowerCaseName isEqualToString:@"switchText"]) {
        value = (NSString*)dict[name];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"text"] ||
             [name isEqualToString:@"title"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYText class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"titleShadow"]) {
        value = [self textShadowFromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([lowerCaseName hasSuffix:@"border"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYBorder class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([lowerCaseName hasSuffix:@"offsetx"] ||
             [lowerCaseName hasSuffix:@"offsety"]) {
        value = @([dict[name] intValue]);
    }
    else if ([lowerCaseName hasSuffix:@"visible"] ||
             [lowerCaseName hasSuffix:@"radial"] ||
             [lowerCaseName hasSuffix:@"inset"]) {
        value = @([dict[name] boolValue]);
    }
    else if ([lowerCaseName hasSuffix:@"font"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYFont class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([lowerCaseName hasSuffix:@"size"] ||
             [lowerCaseName hasSuffix:@"fraction"] ||
             [lowerCaseName hasSuffix:@"radius"] ||
             [lowerCaseName hasSuffix:@"thickness"] ||
             [lowerCaseName hasSuffix:@"width"]) {
        value = @([dict[name] floatValue]);
    }
    else if ([lowerCaseName hasSuffix:@"insets"]) {
        NSArray *val = dict[name];
        UIEdgeInsets insets = UIEdgeInsetsMake([val[0] floatValue], [val[1] floatValue], [val[2] floatValue], [val[3] floatValue]);
        value = [NSValue valueWithUIEdgeInsets:insets];
    }
    else if ([lowerCaseName hasSuffix:@"innershadows"]) {
        value = [self shadowsFromArray:dict[name] isInner:YES];
    }
    else if ([lowerCaseName hasSuffix:@"outershadows"]) {
        value = [self shadowsFromArray:dict[name] isInner:NO];
    }
    
    // top-level theme properties
    else if ([name hasSuffix:@"buttonStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYButtonStyle class] fromDict:dict[name]];
        if(value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"switchStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYSwitchStyle class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"navigationBarStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYNavigationBarStyle class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"tableViewCellStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYTableViewCellStyle class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name hasSuffix:@"textFieldStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYTextFieldStyle class] fromDict:dict[name]];
        if(value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"labelStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYLabelStyle class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"viewControllerStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYViewControllerStyle class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"imageViewStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYImageViewStyle class] fromDict:dict[name]];
        if(value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([lowerCaseName hasSuffix:@"barbuttonitemstyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYBarButtonStyle class] fromDict:dict[name]];
        if(value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"sliderStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[BYSliderStyle class] fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    
    // handle other specific properties
    else if ([name isEqualToString:@"backgroundImage"]) {
        value = [self backgroundImageFromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"thumbImage"]) {
        value = [self imageFromBase64String:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"minimumTrackImage"]) {
        value = [self imageFromBase64String:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"maximumTrackImage"]) {
        value = [self imageFromBase64String:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"trackLayerImage"]) {
        value = [self imageFromBase64String:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"borderLayerImage"]) {
        value = [self imageFromBase64String:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"onState"] ||
             [name isEqualToString:@"offState"]) {
        value = [self switchStateFromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"accessoryViewImage"]) {
        value = [self imageFromBase64String:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"editingAccessoryViewImage"]) {
        value = [self imageFromBase64String:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"stateSetters"]) {
        NSMutableArray *newStateSetters = [NSMutableArray new];
        NSArray *stateSetters = dict[name];
        for (NSDictionary *stateSetterDict in stateSetters) {
            BYStateSetter* stateSetter = [self stateSetterFromDict:stateSetterDict];
            if (stateSetter == nil) {
                NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
            } else {
                [newStateSetters addObject:stateSetter];
            }
        }
        value = newStateSetters;
    }
    else if ([name isEqualToString:@"dropShadow"]) {
        value = [self dropShadowFromDict:dict[name]];
    }
    else if ([name isEqualToString:@"name"]) {
        value = dict[name];
    }
    else {
        NSLog(@"ERROR: Unknown property (%@) when parsing!", name);
    }
    
    // Remove the latest name after parsing has completed
    if ([_objectStack count] > 0) {
        [_objectStack removeLastObject];
    }
    
    return value;
}

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
    setter.value = [self parseValueForName:setter.propertyName dict:propertyDict];
    
    return setter;
}

+(BYSwitchState*)switchStateFromDict:(NSDictionary *)setterDict {
    if(![setterDict.allKeys containsObject:@"text"] && ![setterDict.allKeys containsObject:@"textStyle"] &&
       ![setterDict.allKeys containsObject:@"backgroundColor"] && ![setterDict.allKeys containsObject:@"textShadow"]) {
        return nil;
    }
    
    BYSwitchState* state = [BYSwitchState new];
    state.text = setterDict[@"text"];
    state.textStyle = (BYText*)[self parseStyleObjectPropertiesOnClass:[BYText class]
                                                              fromDict:[setterDict objectForMandatoryKey:@"textStyle"]];
    state.backgroundColor = [self colorFromDict:setterDict key:@"backgroundColor"];
    state.textShadow = [self textShadowFromDict:[setterDict objectForKey:@"textShadow"]];
    return state;
}

+(NSArray*)shadowsFromArray:(NSArray*)shadowsArray isInner:(BOOL)isInner {
    
    NSMutableArray *newShadows = [NSMutableArray new];
    
    for (NSDictionary *shadowDict in shadowsArray) {
        
        BYShadow* shadow = isInner ? [self innerShadowFromDict:shadowDict]
        : [self outerShadowFromDict:shadowDict];
        
        if (shadow == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        } else {
            [newShadows addObject:shadow];
        }
    }
    
    return newShadows;
}

+(BYShadow*)innerShadowFromDict:(NSDictionary *)shadowDict {
    NSMutableDictionary *innerShadowDict = [shadowDict mutableCopy];
    innerShadowDict[@"inset"] = [NSNumber numberWithBool:YES];
    
    return [self shadowFromDict:innerShadowDict];
}

+(BYShadow*)outerShadowFromDict:(NSDictionary *)shadowDict {
    NSMutableDictionary *outerShadowDict = [shadowDict mutableCopy];
    outerShadowDict[@"inset"] = [NSNumber numberWithBool:NO];
    
    return [self shadowFromDict:outerShadowDict];
}

+(BYShadow*)shadowFromDict:(NSDictionary *)shadowDict {
    if(!shadowDict ||
       (![shadowDict.allKeys containsObject:@"radius"] &&
        ![shadowDict.allKeys containsObject:@"offset"] &&
        ![shadowDict.allKeys containsObject:@"color"])) {
        return nil;
    }
    
    BYShadow *shadow = [BYShadow new];
    if ([[shadowDict allKeys] containsObject:@"radius"]) {
        [shadow setRadius:[shadowDict[@"radius"] doubleValue]];
    }
    
    [shadow setOffset:[self sizeFromDict:[shadowDict objectForMandatoryKey:@"offset"]]];
    [shadow setColor:[self colorFromDict:shadowDict key:@"color"]];
    return shadow;
}

+(BYDropShadow*)dropShadowFromDict:(NSDictionary *)dropShadowDict {
    UIColor *color = [self colorFromDict:dropShadowDict key:@"color"];
    float height = [dropShadowDict[@"height"] intValue];
    
    BYDropShadow *dropShadow = [BYDropShadow shadowWithColor:color andHeight:height];
    
    return dropShadow;
}

+(BYBackgroundImage*)backgroundImageFromDict:(NSDictionary *)backgroundImageDict {
    BYBackgroundImage *bgImage = [BYBackgroundImage new];
    
    if(![backgroundImageDict isKindOfClass:[NSDictionary class]]) {
        NSLog(@"WARNING - Image was not a dictionary. Can not parse.");
        return nil;
    }
    
    if([backgroundImageDict.allKeys containsObject:@"data"]) {
        NSString* dataStr = [backgroundImageDict objectForMandatoryKey:@"data"];
        bgImage.image = [self imageFromBase64String:dataStr];
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
                x = [offsetDict[@"x"] doubleValue];
            }
        }
        if ([[offsetDict allKeys] containsObject:@"y"]) {
            if([NSNull null] != offsetDict[@"y"]) {
                y = [offsetDict[@"y"] doubleValue];
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

+(UIColor*)colorFromDict:(NSDictionary*)dict key:(NSString*)key {
    UIColor *color;
    NSString* colorString = dict[key];
    if (colorString) {
        color = [UIColor colorWithHexString:colorString];
        if (color == nil) {
            NSLog(@"Error: Could not parse UIColor from '%@' for %@", colorString,
                  [self generateObjectStackTrace:@"color"]);
        }
    }
    return color;
}

+(NSArray*)colorGradientFromArray:(NSArray*)colorGradientArray {
    NSMutableArray *colorGradient = [NSMutableArray new];
    for (NSDictionary *stopConfig in colorGradientArray) {
        if([stopConfig.allKeys containsObject:@"position"] && [stopConfig.allKeys containsObject:@"color"]) {
            BYGradientStop *stop = [BYGradientStop new];
            stop.stop = [stopConfig floatForMandatoryKey:@"position"];
            stop.color = [self colorFromDict:stopConfig key:@"color"];
            [colorGradient addObject:stop];
        }
    }
    return [NSArray arrayWithArray:colorGradient];
}

+(UIImage*)imageFromBase64String:(NSString*)dataStr {
    UIImage *image;
    
    if(![dataStr isKindOfClass:[NSString class]]) {
        NSLog(@"Image data string was not a string! Image will be nil.");
        return nil;
    }
    
    if(dataStr.length > 22) {
        dataStr = [dataStr substringFromIndex:22];
        NSData *data = [self base64DataFromString:dataStr];
        image = [UIImage imageWithData:data];
    }
    return image;
}

+(NSData*)base64DataFromString:(NSString*)string {
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (string == nil) {
        return [NSData data];
    }
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)[string UTF8String];
    
    lentext = [string length];
    
    theData = [NSMutableData dataWithCapacity: lentext];
    
    ixinbuf = 0;
    
    while (true) {
        if (ixtext >= lentext) {
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        } else if (ch == '+') {
            ch = 62;
        } else if (ch == '=') {
            flendtext = true;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = true;
        }
        
        if (!flignore) {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                } else {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4) {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    return theData;
}

+(NSString*)generateObjectStackTrace:(NSString*)name {
    NSString* stackTrace = @"";
    
    for (NSString* object in _objectStack) {
        stackTrace = [NSString stringWithFormat:@"%@.%@", stackTrace, object];
    }
    
    if (name != nil) {
        stackTrace = [NSString stringWithFormat:@"%@.%@", stackTrace, name];
    }
    
    return [stackTrace substringFromIndex:1];
}

@end