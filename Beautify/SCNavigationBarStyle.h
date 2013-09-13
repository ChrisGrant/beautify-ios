//
//  SCNavigationBarStyle.h
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCViewStyle.h"
#import "SCFont.h"
#import "SCText.h"
#import "SCDropShadow.h"
#import "UIColor+HexColors.h"

@class SCText, SCTextShadow, SCGradient;

@interface SCNavigationBarStyle : SCViewStyle

@property UIColor* backgroundColor;
@property SCGradient *backgroundGradient;

@property SCText *title;
@property SCTextShadow* titleShadow;

@property SCDropShadow *dropShadow;

+(SCNavigationBarStyle*)defaultStyle;

@end