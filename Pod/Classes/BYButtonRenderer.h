//
//  ButtonRenderer.h
//  Beautify
//
//  Created by Chris Grant on 20/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYControlRenderer.h"

@class BYText;
@class BYTextShadow;

/*
 A renderer responsible for enhancing a UIButton.
 
 The style properties for a UIButton can be customized using methods defined in this class.
 */
@interface BYButtonRenderer : BYControlRenderer

#pragma mark - Text customizers

/*
 Set the text style for the button associated with this renderer.
 */
-(void)setTitleStyle:(BYText*)titleStyle forState:(UIControlState)state;

-(void)setTitleShadowStyle:(BYTextShadow *)titleShadowStyle forState:(UIControlState)state;

@end