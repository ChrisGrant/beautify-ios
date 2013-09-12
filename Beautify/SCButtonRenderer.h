//
//  ButtonRenderer.h
//  Beautify
//
//  Created by Chris Grant on 20/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCControlRenderer.h"

@class SCText;
@class SCTextShadow;

/*
 A renderer responsible for enhancing a UIButton.
 
 The style properties for a UIButton can be customized using methods defined in this class.
 */
@interface SCButtonRenderer : SCControlRenderer

#pragma mark - Text customizers

/*
 Set the text style for the button associated with this renderer.
 */
-(void)setTitleStyle:(SCText*)titleStyle forState:(UIControlState)state;

-(void)setTitleShadowStyle:(SCTextShadow *)titleShadowStyle forState:(UIControlState)state;

@end