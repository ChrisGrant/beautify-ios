//
//  BYControlRenderer.h
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYViewRenderer.h"

@class BYGradient, BYBackgroundImage, BYBorder, BYShadow;

@interface BYControlRenderer : BYViewRenderer

#pragma mark - Background customizers

/*
 Set the background color for the button associated with this renderer.
 */
-(void)setBackgroundColor:(UIColor*)backgroundColor forState:(UIControlState)state;

/*
 Set the background gradient for the button associated with this renderer.
 */
-(void)setBackgroundGradient:(BYGradient*)backgroundGradient forState:(UIControlState)state;

/*
 Set the background image for the button associated with this renderer.
 */
-(void)setBackgroundImage:(BYBackgroundImage*)backgroundImage forState:(UIControlState)state;

#pragma mark - Border customizers

/*
 Set the border for the button associated with this renderer.
 */
-(void)setBorder:(BYBorder*)border forState:(UIControlState)state;

#pragma mark - Shadow customizers

/*
 Set the inner shadow for the button associated with this renderer.
 */
-(void)setInnerShadow:(BYShadow*)innerShadow forState:(UIControlState)state;

/*
 Set the outer shadow for the button associated with this renderer.
 */
-(void)setOuterShadow:(BYShadow*)outerShadow forState:(UIControlState)state;

@end