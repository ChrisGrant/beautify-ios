//
//  Gradient.h
//  Beautify
//
//  Created by Chris Grant on 20/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "BYGradientStop.h"

/*
 A style property representing a background gradient for a UIView.
 */
@interface BYGradient : JSONModel <NSCopying>

/*
 Whether the gradient is radial or not.
 */
@property BOOL radial;

/*
 If the gradient is radial, the origin of the gradient.
 */
@property CGSize radialOffset;

/*
 An array of BYGradientStops defining the gradient colors and locations.
 */
@property NSArray<BYGradientStop> *stops;

/*
 Create with the specified array of BYGradientStops, this will create a linear gradient.
 */
+(BYGradient*)gradientWithStops:(NSArray*)colors;

/*
 Create with the specified array of BYGradientStops, will optionally create a radial gradient.
 */
+(BYGradient*)gradientWithStops:(NSArray*)stops isRadial:(BOOL)radial radialOffset:(CGSize)radialOffset;

@end