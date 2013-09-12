//
//  SCSwitchState.h
//  Beautify
//
//  Created by Colin Eberhardt on 28/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCText.h"
#import "SCTextShadow.h"

@interface SCSwitchState : NSObject

/*
 The font and colour of the text
 */
@property SCText* textStyle;

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
@property SCTextShadow* textShadow;

@end