//
//  BYSliderStyle.h
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYViewStyle.h"
#import "BYBorder.h"
#import "BYFont.h"
#import "BYGradient.h"
#import "BYSwitchState.h"

@class Font, Border;

/**
 * Represents a group of rendering properties for a given slider style.
 */
@interface BYSliderStyle : BYViewStyle

// general control customizers
@property BYBorder *border;
@property UIColor *backgroundColor;

// slider bar customizers
@property BYBorder *barBorder;
@property NSArray *barInnerShadows;
@property NSArray *barOuterShadows;
@property float barHeightFraction;

// minimum track customizers
@property UIColor *minimumTrackColor;
@property UIImage *minimumTrackImage;
@property BYGradient *minimumTrackBackgroundGradient;

// maximum track customizers
@property UIColor *maximumTrackColor;
@property UIImage *maximumTrackImage;
@property BYGradient *maximumTrackBackgroundGradient;

// thumb
@property BYBorder *thumbBorder;
@property UIColor *thumbBackgroundColor;
@property UIImage *thumbImage;
@property BYGradient *thumbBackgroundGradient;
@property NSArray *thumbInnerShadows;
@property NSArray *thumbOuterShadows;

+(BYSliderStyle*)defaultStyle;

@end