//
//  GradientStop.h
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 A style property representing a stop for a background gradient for a UIView.
 */
@interface SCGradientStop : NSObject

/*
 The color to use for this stop.
 */
@property UIColor *color;

/*
 The location of the stop, in the range 0-1.
 */
@property float stop;

/*
 Init with the specified color at the specified location.
 */
-(id)initWithColor:(UIColor*)color at:(float)stop;

@end
