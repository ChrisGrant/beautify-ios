//
//  Gradient.h
//  Beautify
//
//  Created by Chris Grant on 20/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 A style property representing a background gradient for a UIView.
 */
@interface SCGradient : NSObject

/*
 Whether the gradient is radial or not.
 */
@property BOOL radial;

/*
 If the gradient is radial, the origin of the gradient.
 */
@property CGSize radialOffset;

/*
 An array of SCGradientStops defining the gradient colors and locations.
 */
@property NSArray *stops;

/*
 Init with the specified array of SCGradientStops, this will create a linear gradient.
 */
-(id)initWithStops:(NSArray*)colors;

/*
 Init with the specified array of SCGradientStops, will optionally create a radial gradient.
 */
-(id)initWithStops:(NSArray*)colors isRadial:(BOOL)isRadial radialOffset:(CGSize)radialOffset;

@end
