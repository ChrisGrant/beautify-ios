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

@property UIColor* backgroundColor;
@property BYGradient *backgroundGradient;

@property BYText *title;
@property BYTextShadow* titleShadow;

@property BYDropShadow *dropShadow;

+(BYNavigationBarStyle*)defaultStyle;

@end