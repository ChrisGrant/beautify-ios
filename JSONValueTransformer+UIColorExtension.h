//
//  JSONValueTransformer+UIColorExtension.h
//  Beautify
//
//  Created by Chris Grant on 30/09/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "JSONValueTransformer.h"
#import <UIKit/UIKit.h>
#import "BYGradient.h"

@interface JSONValueTransformer (UIColorExtension)

-(UIColor*)UIColorFromNSString:(NSString*)color;

-(NSValue*)CGSizeFromNSDictionary:(NSDictionary*)dict;

-(BYGradient*)BYGradientFromNSDictionary:(NSDictionary*)dict;

@end