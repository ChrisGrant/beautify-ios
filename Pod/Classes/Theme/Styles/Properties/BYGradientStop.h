//
//  GradientStop.h
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol BYGradientStop
@end

@interface NSArray (Stop) <BYGradientStop>
@end

/**
 A style property representing a stop for a background gradient for a UIView.
 */
@interface BYGradientStop : JSONModel <NSCopying>

/**
 The color to use for this stop.
 */
@property UIColor *color;

/**
 The location of the stop, in the range 0-1.
 */
@property float position;

/**
 Create with the specified color at the specified location.
 */
+(BYGradientStop*)stopWithColor:(UIColor*)color at:(float)stop;

@end