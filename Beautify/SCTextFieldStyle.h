//
//  SCTextFieldStyle.h
//  Beautify
//
//  Created by Colin Eberhardt on 29/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCViewStyle.h"
#import "SCText.h"
#import "SCFont.h"
#import "SCBorder.h"
#import "SCShadow.h"
#import "SCGradient.h"
#import "SCNineBoxedImage.h"
#import "UIColor+HexColors.h"

@class SCBorder;

@interface SCTextFieldStyle : SCViewStyle

// text
@property SCText *title;

// background
@property UIColor *backgroundColor;
@property SCGradient *backgroundGradient;
@property SCNineBoxedImage *backgroundImage;

// border
@property SCBorder *border;
@property NSArray *innerShadows;
@property NSArray *outerShadows;

+(SCTextFieldStyle*)defaultStyle;

@end