//
//  BYNavigationBarStyle.h
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYViewStyle.h"
#import "BYFont.h"
#import "BYText.h"
#import "BYDropShadow.h"

@class BYText, BYTextShadow, BYGradient;

@interface BYNavigationBarStyle : BYViewStyle

@property UIColor<Optional> *tintColor;
@property UIColor<Optional> *backgroundColor;
@property BYGradient<Optional> *backgroundGradient;

@property BYText *title;
@property BYTextShadow<Optional> *titleShadow;

@property BYDropShadow<Optional> *dropShadow;

+(BYNavigationBarStyle*)defaultStyle;

@end