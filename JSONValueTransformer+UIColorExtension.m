//
//  JSONValueTransformer+UIColorExtension.m
//  Beautify
//
//  Created by Chris Grant on 30/09/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "JSONValueTransformer+UIColorExtension.h"
#import "UIColor+HexColors.h"
#import "BYConfigParser_Private.h"

@implementation JSONValueTransformer (UIColorExtension)

-(UIColor*)UIColorFromNSString:(NSString*)string {
    return [UIColor colorWithHexString:string];
}

-(NSValue*)CGSizeFromNSDictionary:(NSDictionary*)dict {
    return [NSValue valueWithCGSize:CGSizeZero];
}

-(BYGradient*)BYGradientFromNSDictionary:(NSDictionary *)dict {
    return [BYConfigParser gradientFromDict:dict];
}

//CGPoint
-(id)CGPointFromNSString:(NSString*)string
{
    return [NSValue valueWithCGPoint: CGPointFromString(string)];
}
-(id)JSONObjectFromCGPoint:(NSValue*)pointValue
{
    return NSStringFromCGPoint([pointValue CGPointValue]);
}

//CGSize
-(id)CGSizeFromNSString:(NSString*)string
{
    return [NSValue valueWithCGSize: CGSizeFromString(string)];
}
-(id)JSONObjectFromCGSize:(NSValue*)sizeValue
{
    return NSStringFromCGSize([sizeValue CGSizeValue]);
}

//CGRect
-(id)CGRectFromNSString:(NSString*)string
{
    return [NSValue valueWithCGRect: CGRectFromString(string)];
}
-(id)JSONObjectFromCGRect:(NSValue*)rectValue
{
    return NSStringFromCGRect([rectValue CGRectValue]);
}

@end