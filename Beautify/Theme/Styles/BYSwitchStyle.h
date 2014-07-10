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
#import "BYShadow.h"

@class Font, Border;

/**
 * Represents a group of rendering properties for a given switch style.
 */
@interface BYSwitchStyle : BYViewStyle

// The render state of the on and off positions
@property BYSwitchState *onState;
@property BYSwitchState *offState;

// Background
@property UIColor<Optional> *highlightColor;

// Border
@property BYBorder<Optional> *border;
@property BYShadow<Optional> *innerShadow;
@property BYShadow<Optional> *outerShadow;

// Thumb
@property BYBorder<Optional> *thumbBorder;
@property UIColor<Optional> *thumbBackgroundColor;
@property BYGradient<Optional> *thumbBackgroundGradient;
@property BYShadow<Optional> *thumbInnerShadow;
@property BYShadow<Optional> *thumbOuterShadow;
@property UIImage<Optional> *thumbImage;
@property UIImage<Optional> *trackLayerImage;
@property UIImage<Optional> *borderLayerImage;
@property CGFloat thumbInset;

+(BYSwitchStyle*)defaultStyle;

@end