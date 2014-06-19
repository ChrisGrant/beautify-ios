//
//  BYSearchBarRenderer.h
//  Beautify
//
//  Created by Chris Grant on 06/02/2014.
//  Copyright (c) 2014 Beautify. All rights reserved.
//

#import <Beautify/Beautify.h>

@interface BYSearchBarRenderer : BYControlRenderer

#pragma mark Text Field Customizers

-(void)setTextFieldTitle:(BYText*)title
                forState:(UIControlState)state;

-(void)setTextFieldBackgroundColor:(UIColor*)backgroundColor
                          forState:(UIControlState)state;

-(void)setTextFieldBackgroundGradient:(BYGradient*)backgroundGradient
                    forState:(UIControlState)state;

-(void)setTextFieldBackgroundImage:(BYBackgroundImage*)backgroundImage
                          forState:(UIControlState)state;

-(void)setTextFieldBorder:(BYBorder*)border
                 forState:(UIControlState)state;

-(void)setTextFieldInnerShadow:(BYShadow*)innerShadow
                      forState:(UIControlState)state;

-(void)setTextFieldOuterShadow:(BYShadow*)outerShadow
                      forState:(UIControlState)state;

@end