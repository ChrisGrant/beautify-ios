//
//  BYSwitchState.h
//  Beautify
//
//  Created by Colin Eberhardt on 28/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYText.h"
#import "BYTextShadow.h"

@interface BYSwitchState : NSObject <NSCopying>

/*
 The font and colour of the text
 */
@property BYText* textStyle;

/*
 The text rendered for this switch state
 */
@property NSString* text;

/*
 The background color for the switch at this state
 */
@property UIColor* backgroundColor;

/*
 The shadow for the text at this state
 */
@property BYTextShadow* textShadow;

/*
 The border color for the swich at this state
 */
@property UIColor* borderColor;

/*
 Create a Switch State with the specified text style, text, background color and text shadow.
 */
+(BYSwitchState*)stateWithTextStyle:(BYText*)textStyle text:(NSString*)string backgroundColor:(UIColor*)bgColor textShadow:(BYTextShadow*)textShadow;

@end