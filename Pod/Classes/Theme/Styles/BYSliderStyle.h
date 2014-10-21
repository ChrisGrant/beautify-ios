//
//  BYSliderStyle.h
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYViewStyle.h"
#import "BYBorder.h"
#import "BYFont.h"
#import "BYGradient.h"
#import "BYSwitchState.h"
#import "BYShadow.h"

@class Font, Border;

/**
 * Represents a group of rendering properties for a given slider style.
 */
@interface BYSliderStyle : BYViewStyle

// slider bar customizers
@property BYBorder<Optional> *barBorder;
@property BYShadow<Optional> *barInnerShadow;
@property BYShadow<Optional> *barOuterShadow;
@property float barHeightFraction;

// minimum track customizers
@property UIColor<Optional> *minimumTrackColor;
@property UIImage<Optional> *minimumTrackImage;
@property BYGradient<Optional> *minimumTrackBackgroundGradient;

// maximum track customizers
@property UIColor<Optional> *maximumTrackColor;
@property UIImage<Optional> *maximumTrackImage;
@property BYGradient<Optional> *maximumTrackBackgroundGradient;

// thumb
@property BYBorder<Optional> *thumbBorder;
@property UIColor<Optional> *thumbBackgroundColor;
@property UIImage<Optional> *thumbImage;
@property BYGradient<Optional> *thumbBackgroundGradient;
@property BYShadow<Optional> *thumbInnerShadow;
@property BYShadow<Optional> *thumbOuterShadow;

+(BYSliderStyle*)defaultStyle;

@end