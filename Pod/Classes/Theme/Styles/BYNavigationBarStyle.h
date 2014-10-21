//
//  BYNavigationBarStyle.h
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYViewStyle.h"
#import "BYFont.h"
#import "BYText.h"
#import "BYDropShadow.h"

@class BYText, BYTextShadow, BYGradient, BYBackgroundImage;

@interface BYNavigationBarStyle : BYViewStyle

@property UIColor<Optional> *tintColor;
@property UIColor<Optional> *backgroundColor;
@property BYGradient<Optional> *backgroundGradient;
@property BYBackgroundImage<Optional> *backgroundImage;

@property BYText *title;
@property BYTextShadow<Optional> *titleShadow;

@property BYDropShadow<Optional> *dropShadow;

+(BYNavigationBarStyle*)defaultStyle;

@end