//
//  SCTableViewCellStyle.h
//  Beautify
//
//  Created by Colin Eberhardt on 02/06/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//
#import "SCViewStyle.h"
#import "SCText.h"
#import "SCFont.h"
#import "SCBorder.h"
#import "SCShadow.h"
#import "SCGradient.h"
#import "SCNineBoxedImage.h"
#import "SCTextShadow.h"
#import "UIColor+HexColors.h"

@interface SCTableViewCellStyle : SCViewStyle

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

// accessory views
@property UIImage *accessoryViewImage;
@property UIImage *editingAccessoryViewImage;

+(SCTableViewCellStyle*)defaultStyle;

@end