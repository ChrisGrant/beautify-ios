//
//  BYSwitchState.h
//  Beautify
//
//  Created by Colin Eberhardt on 28/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYText.h"
#import "BYTextShadow.h"
#import "JSONModel.h"

@interface BYSwitchState : JSONModel <NSCopying>

/*
 The font and colour of the text
 */
@property BYText<Optional> *textStyle;

/*
 The text rendered for this switch state
 */
@property NSString<Optional> *text;

/*
 The background color for the switch at this state
 */
@property UIColor<Optional> *backgroundColor;

/*
 The shadow for the text at this state
 */
@property BYTextShadow<Optional> *textShadow;

/*
 The border color for the swich at this state
 */
@property UIColor<Optional> *borderColor;

/*
 Create a Switch State with the specified text style, text, background color and text shadow.
 */
+(BYSwitchState*)stateWithTextStyle:(BYText*)textStyle text:(NSString*)string backgroundColor:(UIColor*)bgColor textShadow:(BYTextShadow*)textShadow;

@end