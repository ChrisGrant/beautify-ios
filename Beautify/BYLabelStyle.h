//
//  LabelStyle.h
//  Beautify
//
//  Created by Adrian Conlin on 30/04/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYViewStyle.h"
#import "BYText.h"
#import "BYFont.h"
#import "BYShadow.h"
#import "BYTextShadow.h"

/*
 Represents a group of rendering properties for a given label style.
 */
@interface BYLabelStyle : BYViewStyle

// text
@property BYText *title;

@property BYTextShadow* titleShadow;

+(BYLabelStyle*)defaultStyle;

@end