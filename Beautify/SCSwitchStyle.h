//
//  SwitchConfig.h
//  Beautify
//
//  Created by Chris Grant on 27/02/2013.
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
 * Represents a group of rendering properties for a given switch style.
 */
@interface SCSwitchStyle : SCViewStyle

// the render state of the on and off positions
@property SCSwitchState *onState;
@property SCSwitchState *offState;

// background
@property UIColor *highlightColor;

// border
@property SCBorder *border;
@property NSArray *innerShadows;
@property NSArray *outerShadows;

// knob
@property SCBorder *knobBorder;
@property UIColor *knobBackgroundColor;
@property SCGradient *knobBackgroundGradient;
@property NSArray *knobInnerShadows;
@property NSArray *knobOuterShadows;
@property UIImage *knobImage, *trackLayerImage, *borderLayerImage;

+(SCSwitchStyle*)defaultStyle;

@end