//
//  SCSliderStyle.h
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scViewStyle.h"
#import "SCBorder.h"
#import "SCFont.h"
#import "SCGradient.h"
#import "SCSwitchState.h"

@class Font, Border;

/**
 * Represents a group of rendering properties for a given slider style.
 */
@interface SCSliderStyle : SCViewStyle

// general control customizers
@property SCBorder *border;
@property UIColor *backgroundColor;

// slider bar customizers
@property SCBorder *barBorder;
@property NSArray *barInnerShadows;
@property NSArray *barOuterShadows;

// minimum track customizers
@property UIColor *minimumTrackColor;
@property UIImage *minimumTrackImage;
@property SCGradient *minimumTrackBackgroundGradient;

// maximum track customizers
@property UIColor *maximumTrackColor;
@property UIImage *maximumTrackImage;
@property SCGradient *maximumTrackBackgroundGradient;

// knob
@property SCBorder *knobBorder;
@property UIColor *knobBackgroundColor;
@property UIImage *knobImage;
@property SCGradient *knobBackgroundGradient;
@property NSArray *knobInnerShadows;
@property NSArray *knobOuterShadows;

+(SCSliderStyle*)defaultStyle;

@end