//
//  SCConfigParser_Private.h
//  Beautify
//
//  Created by Chris Grant on 13/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCConfigParser.h"

@class SCStateSetter;
@class SCShadow;
@class SCShadowImage;
@class SCNineBoxedImage;

@interface SCConfigParser (SCConfigParser)

// Beautify Property Parsing
+(SCTextShadow*)textShadowFromDict:(NSDictionary*)dict;
+(SCStateSetter*)stateSetterFromDict:(NSDictionary*)setterDict;
+(SCSwitchState*)switchStateFromDict:(NSDictionary*)setterDict;
+(NSArray*)shadowsFromArray:(NSArray*)shadowsArray isInner:(BOOL)isInner;
+(SCShadow*)innerShadowFromDict:(NSDictionary*)shadowDict;
+(SCShadow*)outerShadowFromDict:(NSDictionary*)shadowDict;
+(SCShadow*)shadowFromDict:(NSDictionary*)shadowDict;
+(SCShadowImage*)shadowImageFromDict:(NSDictionary*)shadowImageDict;
+(SCNineBoxedImage*)nineBoxedImageFromDict:(NSDictionary*)nineBoxedImageDict;
+(SCGradient*)gradientFromDict:(NSDictionary *)gradientDict;

// Generic utilities
+(CGSize)sizeFromDict:(NSDictionary *)offsetDict;
+(UIControlState)stateFromString:(NSString*)stateString;
+(UIColor*)colorFromDict:(NSDictionary*)dict key:(NSString*)key;
+(NSArray*)colorGradientFromArray:(NSArray*)colorGradientArray;
+(UIImage*)imageFromBase64String:(NSString*)dataStr;

@end