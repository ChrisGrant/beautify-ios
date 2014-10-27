//
//  LabelStyle.h
//  Beautify
//
//  Created by Adrian Conlin on 30/04/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYViewStyle.h"
#import "BYText.h"
#import "BYFont.h"
#import "BYShadow.h"
#import "BYTextShadow.h"

/**
 Represents a group of rendering properties for a given label style.
 */
@interface BYLabelStyle : BYViewStyle

@property BYText *title;

@property BYTextShadow<Optional> *titleShadow;

+(BYLabelStyle*)defaultStyle;

@end