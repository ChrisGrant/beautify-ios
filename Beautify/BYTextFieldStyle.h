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
#import "UIColor+HexColors.h"

@class BYBorder;

@interface BYTextFieldStyle : BYViewStyle

// text
@property BYText *title;

// background
@property UIColor<Optional> *backgroundColor;
@property BYGradient<Optional> *backgroundGradient;
@property BYBackgroundImage<Optional> *backgroundImage;

// border
@property BYBorder<Optional> *border;
@property NSArray<BYShadow, Optional> *innerShadows;
@property NSArray<BYShadow, Optional> *outerShadows;

+(BYTextFieldStyle*)defaultStyle;

@end