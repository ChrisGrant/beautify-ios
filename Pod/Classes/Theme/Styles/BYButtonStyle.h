//
//  ButtonStyle.h
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYViewStyle.h"
#import "BYText.h"
#import "BYTextShadow.h"
#import "BYBorder.h"
#import "BYShadow.h"
#import "BYGradient.h"
#import "BYBackgroundImage.h"

/**
 * Represents a group of rendering properties for a given button style.
 */
@interface BYButtonStyle : BYViewStyle 

// text
@property BYText *title;
@property BYTextShadow<Optional>* titleShadow;

// background
@property UIColor<Optional> *backgroundColor;
@property BYGradient<Optional> *backgroundGradient;
@property BYBackgroundImage<Optional> *backgroundImage;

// border
@property BYBorder<Optional> *border;
@property BYShadow<Optional> *innerShadow;
@property BYShadow<Optional> *outerShadow;

// This is the default style for UIButtonTypeCustom
+(BYButtonStyle*)defaultCustomStyle;

// This is the default style for UIButtonTypeSystem (or UIButtonTypeRoundedRect in iOS6)
+(BYButtonStyle*)defaultSystemStyle;

@end