//
//  SwitchConfig.h
//  Beautify
//
//  Created by Chris Grant on 27/02/2013.
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
 * Represents a group of rendering properties for a given switch style.
 */
@interface BYSwitchStyle : BYViewStyle

// The render state of the on and off positions
@property BYSwitchState *onState;
@property BYSwitchState *offState;

// Background
@property UIColor *highlightColor;

// Border
@property BYBorder *border;
@property NSArray *innerShadows;
@property NSArray *outerShadows;

// Thumb
@property BYBorder *thumbBorder;
@property UIColor *thumbBackgroundColor;
@property BYGradient *thumbBackgroundGradient;
@property NSArray *thumbInnerShadows;
@property NSArray *thumbOuterShadows;
@property UIImage *thumbImage, *trackLayerImage, *borderLayerImage;

+(BYSwitchStyle*)defaultStyle;

@end