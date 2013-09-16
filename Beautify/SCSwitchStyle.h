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

// The render state of the on and off positions
@property SCSwitchState *onState;
@property SCSwitchState *offState;

// Background
@property UIColor *highlightColor;

// Border
@property SCBorder *border;
@property NSArray *innerShadows;
@property NSArray *outerShadows;

// Thumb
@property SCBorder *thumbBorder;
@property UIColor *thumbBackgroundColor;
@property SCGradient *thumbBackgroundGradient;
@property NSArray *thumbInnerShadows;
@property NSArray *thumbOuterShadows;
@property UIImage *thumbImage, *trackLayerImage, *borderLayerImage;

+(SCSwitchStyle*)defaultStyle;

@end