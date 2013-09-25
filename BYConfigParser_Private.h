//
//  BYConfigParser_Private.h
//  Beautify
//
//  Created by Chris Grant on 13/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYConfigParser.h"

@class BYStateSetter;
@class BYShadow;
@class BYShadowImage;
@class BYBackgroundImage;

@interface BYConfigParser (BYConfigParser)

// Beautify Property Parsing
+(BYTextShadow*)textShadowFromDict:(NSDictionary*)dict;
+(BYStateSetter*)stateSetterFromDict:(NSDictionary*)setterDict;
+(BYSwitchState*)switchStateFromDict:(NSDictionary*)setterDict;
+(NSArray*)shadowsFromArray:(NSArray*)shadowsArray isInner:(BOOL)isInner;
+(BYShadow*)innerShadowFromDict:(NSDictionary*)shadowDict;
+(BYShadow*)outerShadowFromDict:(NSDictionary*)shadowDict;
+(BYShadow*)shadowFromDict:(NSDictionary*)shadowDict;
+(BYShadowImage*)shadowImageFromDict:(NSDictionary*)shadowImageDict;
+(BYBackgroundImage*)backgroundImageFromDict:(NSDictionary*)backgroundImageDict;
+(BYGradient*)gradientFromDict:(NSDictionary *)gradientDict;

// Generic utilities
+(CGSize)sizeFromDict:(NSDictionary *)offsetDict;
+(UIControlState)stateFromString:(NSString*)stateString;
+(UIColor*)colorFromDict:(NSDictionary*)dict key:(NSString*)key;
+(NSArray*)colorGradientFromArray:(NSArray*)colorGradientArray;
+(UIImage*)imageFromBase64String:(NSString*)dataStr;

@end