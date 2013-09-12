//
//  LabelRenderer.h
//  Beautify
//
//  Created by Adrian Conlin on 30/04/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCViewRenderer.h"

@class SCText, SCTextShadow;

/*
 A renderer responsible for enhancing a UILabel.
 
 The style properties for a UILabel can be customized using methods defined in this class.
 */
@interface SCLabelRenderer : SCViewRenderer

#pragma mark - Text customizers

/*
 Set the text style for the button associated with this renderer.
 */
-(void)setTextStyle:(SCText*)textStyle forState:(UIControlState)state;

/*
 Set the text style for the button associated with this renderer.
 */
-(void)setTextShadow:(SCTextShadow*)textShadow forState:(UIControlState)state;

@end
