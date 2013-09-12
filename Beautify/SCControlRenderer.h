//
//  SCControlRenderer.h
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCViewRenderer.h"

@class SCGradient, SCNineBoxedImage, SCBorder;

@interface SCControlRenderer : SCViewRenderer

#pragma mark - Background customizers

/*
 Set the background color for the button associated with this renderer.
 */
-(void)setBackgroundColor:(UIColor*)backgroundColor forState:(UIControlState)state;

/*
 Set the background gradient for the button associated with this renderer.
 */
-(void)setBackgroundGradient:(SCGradient*)backgroundGradient forState:(UIControlState)state;

/*
 Set the background image for the button associated with this renderer.
 */
-(void)setBackgroundImage:(SCNineBoxedImage*)backgroundImage forState:(UIControlState)state;

#pragma mark - Border customizers

/*
 Set the border for the button associated with this renderer.
 */
-(void)setBorder:(SCBorder*)border forState:(UIControlState)state;

#pragma mark - Shadow customizers

/*
 Set the inner shadows for the button associated with this renderer.
 */
-(void)setInnerShadows:(NSArray*)innerShadows forState:(UIControlState)state;

/*
 Set the outer shadows for the button associated with this renderer.
 */
-(void)setOuterShadows:(NSArray*)outerShadows forState:(UIControlState)state;

@end