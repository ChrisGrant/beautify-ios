//
//  ConfigParser.m
//  Property Finder
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCConfigParser.h"
#import "SCButtonStyle.h"
#import "SCSwitchStyle.h"
#import "SCLabelStyle.h"
#import "SCViewControllerStyle.h"
#import "SCGradientStop.h"
#import "UIColor+HexColors.h"
#import "NSObject+Properties.h"
#import "SCFont.h"
#import "SCBorder.h"
#import "SCNineBoxedImage.h"
#import "SCTheme.h"
#import "SCStateSetter.h"
#import "SCTextFieldStyle.h"
#import "SCSwitchState.h"
#import "NSDictionary+Utilities.h"
#import "SCTextShadow.h"
#import "SCNavigationBarStyle.h"
#import "SCTableViewCellStyle.h"
#import "SCImageViewStyle.h"
#import "SCSliderStyle.h"

// A 'stack' for generating useful errors when a property parse operation fails
static NSMutableArray* _objectStack;

@implementation SCConfigParser

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
    id value = dict[name];
    if (value == nil || value == [NSNull null]) {
        NSLog(@"Warning: No property value found for %@.%@", [newInstance class], name);
        return;
    }
    
    value = [self parseValueForName:name dict:dict];
    if (value) {
        [newInstance setValue:value forKey:name];
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
        value = [self parseStyleObjectPropertiesOnClass:[SCText class]
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
        value = [self parseStyleObjectPropertiesOnClass:[SCBorder class]
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
        value = [self parseStyleObjectPropertiesOnClass:[SCFont class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([lowerCaseName hasSuffix:@"size"] ||
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
        value = [self parseStyleObjectPropertiesOnClass:[SCButtonStyle class] fromDict:dict[name]];
        if(value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"switchStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[SCSwitchStyle class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"navigationBarStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[SCNavigationBarStyle class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"tableViewCellStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[SCTableViewCellStyle class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name hasSuffix:@"textFieldStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[SCTextFieldStyle class] fromDict:dict[name]];
        if(value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"labelStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[SCLabelStyle class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"viewControllerStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[SCViewControllerStyle class]
                                               fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"imageViewStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[SCImageViewStyle class] fromDict:dict[name]];
        if(value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name hasSuffix:@"barButtonItemStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[SCButtonStyle class] fromDict:dict[name]];
        if(value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"sliderStyle"]) {
        value = [self parseStyleObjectPropertiesOnClass:[SCSliderStyle class] fromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    
    // handle other specific properties
    else if ([name isEqualToString:@"backgroundImage"]) {
        value = [self nineBoxedImageFromDict:dict[name]];
        if (value == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        }
    }
    else if ([name isEqualToString:@"knobImage"]) {
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
            SCStateSetter* stateSetter = [self stateSetterFromDict:stateSetterDict];
            if (stateSetter == nil) {
                NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
            } else {
                [newStateSetters addObject:stateSetter];
            }
        }
        value = newStateSetters;
    }
    else if ([name isEqualToString:@"shadowImage"]) {
        value = [self shadowImageFromDict:dict[name]];
    }
    
    // handle other generic properties, typically string values
    else {
        value = dict[name];
    }
    
    // Remove the latest name after parsing has completed
    if ([_objectStack count] > 0) {
        [_objectStack removeLastObject];
    }
    
    return value;
}

#pragma mark - Property parsing

+(SCTextShadow*)textShadowFromDict:(NSDictionary *)dict {
    SCTextShadow* shadow = [SCTextShadow new];
    [shadow setOffset:[self sizeFromDict:[dict objectForMandatoryKey:@"offset"]]];
    [shadow setColor:[self colorFromDict:dict key:@"color"]];
    return shadow;
}

+(SCStateSetter*)stateSetterFromDict:(NSDictionary *)setterDict {
    SCStateSetter* setter = [SCStateSetter new];
    
    setter.propertyName = [setterDict objectForMandatoryKey:@"propertyName"];
    setter.state = [self stateFromString:[setterDict objectForMandatoryKey:@"state"]];
    
    // package the value into a dictionray so that it 'looks' the same as in the original JSON
    // Yeah - this is a bit hacky!
    NSMutableDictionary* propertyDict = [NSMutableDictionary new];
    [propertyDict setValue:[setterDict objectForMandatoryKey:@"value"] forKey:setter.propertyName];
    setter.value = [self parseValueForName:setter.propertyName dict:propertyDict];
    
    return setter;
}

+(SCSwitchState*)switchStateFromDict:(NSDictionary *)setterDict {
    SCSwitchState* state = [SCSwitchState new];
    
    state.text = [setterDict objectForMandatoryKey:@"text"];
    state.textStyle = (SCText*)[self parseStyleObjectPropertiesOnClass:[SCText class]
                                                              fromDict:[setterDict objectForMandatoryKey:@"textStyle"]];
    state.backgroundColor = [self colorFromDict:setterDict key:@"backgroundColor"];
    state.textShadow = [self textShadowFromDict:[setterDict objectForKey:@"textShadow"]];
    return state;
}

+(UIControlState)stateFromString:(NSString*)stateString {
    if ([stateString isEqualToString:@"highlighted"]) {
        return UIControlStateHighlighted;
    } else if ([stateString isEqualToString:@"disabled"]) {
        return UIControlStateDisabled;
    } else if ([stateString isEqualToString:@"selected"]) {
        return UIControlStateSelected;
    }
    
    return UIControlStateNormal;
}

+(NSArray*)shadowsFromArray:(NSArray*)shadowsArray isInner:(BOOL)isInner {
    
    NSMutableArray *newShadows = [NSMutableArray new];
    
    for (NSDictionary *shadowDict in shadowsArray) {
        
        SCShadow* shadow = isInner ? [self innerShadowFromDict:shadowDict]
        : [self outerShadowFromDict:shadowDict];
        
        if (shadow == nil) {
            NSLog(@"Error: Could not parse %@", [self generateObjectStackTrace:nil]);
        } else {
            [newShadows addObject:shadow];
        }
    }
    
    return newShadows;
}

+(SCShadow*)innerShadowFromDict:(NSDictionary *)shadowDict {
    NSMutableDictionary *innerShadowDict = [shadowDict mutableCopy];
    innerShadowDict[@"inset"] = [NSNumber numberWithBool:YES];
    
    return [self shadowFromDict:innerShadowDict];
}

+(SCShadow*)outerShadowFromDict:(NSDictionary *)shadowDict {
    NSMutableDictionary *outerShadowDict = [shadowDict mutableCopy];
    outerShadowDict[@"inset"] = [NSNumber numberWithBool:NO];
    
    return [self shadowFromDict:outerShadowDict];
}

+(SCShadow*)shadowFromDict:(NSDictionary *)shadowDict {
    SCShadow *shadow = [SCShadow new];
    
    if ([[shadowDict allKeys] containsObject:@"radius"]) {
        [shadow setRadius:[shadowDict[@"radius"] doubleValue]];
    }
    
    if ([shadowDict[@"inset"] boolValue]) {
        [shadow setInset:YES];
    }
    
    [shadow setOffset:[self sizeFromDict:[shadowDict objectForMandatoryKey:@"offset"]]];
    [shadow setColor:[self colorFromDict:shadowDict key:@"color"]];
    return shadow;
}

+(SCShadowImage*)shadowImageFromDict:(NSDictionary *)shadowImageDict {
    UIColor *color = [self colorFromDict:shadowImageDict key:@"color"];
    float height = [shadowImageDict[@"height"] intValue];
    
    SCShadowImage *shadowImage = [[SCShadowImage alloc] initWithColor:color andHeight:height];
    
    return shadowImage;
}

+(UIColor*)colorFromDict:(NSDictionary*)dict key:(NSString*)key
{
    UIColor *color;
    NSString* colorString = dict[key];
    if (colorString != nil) {
        color = [UIColor colorWithHexString:colorString];
        if (color == nil) {
            NSLog(@"Error: Could not parse UIColor from '%@' for %@", colorString,
                  [self generateObjectStackTrace:@"color"]);
        }
    }
    return color;
}

+(SCNineBoxedImage*)nineBoxedImageFromDict:(NSDictionary *)nineBoxedImageDict {
    SCNineBoxedImage *image = [SCNineBoxedImage new];
    
    NSString* dataStr = [nineBoxedImageDict objectForMandatoryKey:@"data"];
    image.data = [self imageFromBase64String:dataStr];
    image.top = [nineBoxedImageDict intForMandatoryKey:@"top"];
    image.right = [nineBoxedImageDict intForMandatoryKey:@"right"];
    image.bottom = [nineBoxedImageDict intForMandatoryKey:@"bottom"];
    image.left = [nineBoxedImageDict intForMandatoryKey:@"left"];
    
    return image;
}

+(SCGradient*)gradientFromDict:(NSDictionary *)gradientDict {
    SCGradient *gradient = [SCGradient new];
    
    gradient.radial = [gradientDict boolForMandatoryKey:@"radial"];
    gradient.radialOffset = [self sizeFromDict:gradientDict[@"radialOffset"]];
    gradient.stops = [self colorGradientFromArray:[gradientDict objectForMandatoryKey:@"stops"]];
    
    return gradient;
}

#pragma mark - Generic utilities

+(NSArray*)colorGradientFromArray:(NSArray*)colorGradientArray {
    NSMutableArray *colorGradient = [NSMutableArray new];
    
    for (NSDictionary *stopConfig in colorGradientArray) {
        SCGradientStop *stop = [SCGradientStop new];
        stop.stop = [stopConfig floatForMandatoryKey:@"position"];
        stop.color = [self colorFromDict:stopConfig key:@"color"];
        [colorGradient addObject:stop];
    }
    
    return [NSArray arrayWithArray:colorGradient];
}

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

+(UIImage*)imageFromBase64String:(NSString *)dataStr {
    dataStr = [dataStr substringFromIndex:22];
    NSData *data = [self base64DataFromString:dataStr];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

+(NSData *)base64DataFromString:(NSString *)string {
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