//
//  BYTableViewCellStyle.h
//  Beautify
//
//  Created by Colin Eberhardt on 02/06/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//
#import "BYViewStyle.h"
#import "BYText.h"
#import "BYFont.h"
#import "BYBorder.h"
#import "BYShadow.h"
#import "BYGradient.h"
#import "BYNineBoxedImage.h"
#import "BYTextShadow.h"
#import "UIColor+HexColors.h"

@interface BYTableViewCellStyle : BYViewStyle

// text
@property BYText *title;
@property BYTextShadow* titleShadow;

// background
@property UIColor *backgroundColor;
@property BYGradient *backgroundGradient;
@property BYNineBoxedImage *backgroundImage;

// border
@property BYBorder *border;
@property NSArray *innerShadows;
@property NSArray *outerShadows;

// accessory views
@property UIImage *accessoryViewImage;
@property UIImage *editingAccessoryViewImage;

+(BYTableViewCellStyle*)defaultStyle;

@end