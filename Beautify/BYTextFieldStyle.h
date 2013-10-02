//
//  BYTextFieldStyle.h
//  Beautify
//
//  Created by Colin Eberhardt on 29/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYViewStyle.h"
#import "BYText.h"
#import "BYFont.h"
#import "BYBorder.h"
#import "BYShadow.h"
#import "BYGradient.h"
#import "BYBackgroundImage.h"

@class BYBorder;

@interface BYTextFieldStyle : BYViewStyle

// text
@property BYText *title;

// background
@property UIColor *backgroundColor;
@property BYGradient *backgroundGradient;
@property BYBackgroundImage *backgroundImage;

// border
@property BYBorder *border;
@property NSArray *innerShadows;
@property NSArray *outerShadows;

+(BYTextFieldStyle*)defaultStyle;

@end