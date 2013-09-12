//
//  ButtonStyle.h
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCViewStyle.h"
#import "SCText.h"
#import "SCTextShadow.h"
#import "SCBorder.h"
#import "SCShadow.h"
#import "SCGradient.h"
#import "SCNineBoxedImage.h"

/**
 * Represents a group of rendering properties for a given button style.
 */
@interface SCButtonStyle : SCViewStyle

// text
@property SCText *title;
@property SCTextShadow* titleShadow;

// background
@property UIColor *backgroundColor;
@property SCGradient *backgroundGradient;
@property SCNineBoxedImage *backgroundImage;

// border
@property SCBorder *border;
@property NSArray *innerShadows;
@property NSArray *outerShadows;

+(SCButtonStyle*)defaultStyle;

@end