//
//  Gradient.h
//  Beautify
//
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "BYGradientStop.h"

/**
 * A style property representing a background gradient for a UIView.
 */
@interface BYGradient : JSONModel <NSCopying>

/**
 * Whether the gradient is radial or not.
 */
@property BOOL radial;

/**
 * If the gradient is radial, the origin of the gradient.
 */
@property CGSize radialOffset;

/**
 *  An array of BYGradientStops defining the gradient colors and locations.
 */
@property NSArray<BYGradientStop> *stops;

/**
 *  Create with the specified array of BYGradientStops, this will create a linear gradient.
 *
 *  @param colors An array of gradient stops.
 *
 *  @return A new BYGradient with the specifed color stops.
 */
+ (BYGradient*)gradientWithStops:(NSArray*)colors;

/**
 *  Creates a gradient with the specified array of BYGradientStops. Optionally create a radial gradient
 *
 *  @param stops        An array of BYGradientStop objects.
 *  @param radial       Whether the gradient is radial
 *  @param radialOffset The offset for the radial gradient.
 *
 *  @return A gradient with the specified stops and radial offset (if radial)
 */
+ (BYGradient*)gradientWithStops:(NSArray*)stops isRadial:(BOOL)radial radialOffset:(CGSize)radialOffset;

@end