//
//  SCSliderRenderer.h
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCViewRenderer.h"

@class SCFont, SCGradient, SCBorder;

/*
 A renderer responsible for enhancing a UISlider.
 
 The style properties for a UIslider can be customized using methods defined in this class.
 */
@interface SCSliderRenderer : SCViewRenderer <UIGestureRecognizerDelegate>

#pragma mark - General Control customizers

/*
 Set the border for the control associated with this renderer.
 */
-(void)setBorder:(SCBorder*)border forState:(UIControlState)state;

/*
 Set the background color for the control of the control associated with this renderer.
 */
-(void)setBackgroundColor:(UIColor*)backgroundColor forState:(UIControlState)state;

#pragma mark - Slider bar customizers

/*
 Set the border for the slider bar associated with this renderer.
 */
-(void)setBarBorder:(SCBorder*)barBorder forState:(UIControlState)state;

/*
 Set the inner shadows for the slider bar associated with this renderer.
 */
-(void)setBarInnerShadows:(NSArray*)barInnerShadows forState:(UIControlState)state;

/*
 Set the outer shadows for the slider bar associated with this renderer.
 */
-(void)setBarOuterShadows:(NSArray*)barOuterShadows forState:(UIControlState)state;

#pragma mark - Minimum track customizers

/*
 Set the background color for the minimum track of the slider bar associated with this renderer.
 */
-(void)setMinimumTrackColor:(UIColor*)minimumTrackColor forState:(UIControlState)state;

/*
 Set the image for the minimum track of the slider bar associated with this renderer.
 */
-(void)setMinimumTrackImage:(UIImage*)minimumTrackImage forState:(UIControlState)state;

/*
 Set the background gradient for the minimum track of the slider bar associated with this renderer.
 */
-(void)setMinimumTrackBackgroundGradient:(SCGradient*)minimumTrackBackgroundGradient forState:(UIControlState)state;

#pragma mark - Maximum track customizers

/*
 Set the background color for the maximum track of the slider bar associated with this renderer.
 */
-(void)setMaximumTrackColor:(UIColor*)maximumTrackColor forState:(UIControlState)state;

/*
 Set the image for the maximum track of the slider bar associated with this renderer.
 */
-(void)setMaximumTrackImage:(UIImage*)maximumTrackImage forState:(UIControlState)state;

/*
 Set the background gradient for the maximum of the track of the slider bar associated with this renderer.
 */
-(void)setMaximumTrackBackgroundGradient:(SCGradient*)maximumTrackBackgroundGradient forState:(UIControlState)state;

#pragma mark - thumb customizers

/*
 Set the border for the thumb on the slider bar associated with this renderer.
 */
- (void)setThumbBorder:(SCBorder *)thumbBorder forState:(UIControlState)state;

/*
 Set the background color for the thumb on the slider bar associated with this renderer.
 */
-(void)setThumbBackgroundColor:(UIColor*)thumbBackgroundColor forState:(UIControlState)state;

/*
 Set the image for the thumb on the the slider bar associated with this renderer.
 */
-(void)setThumbImage:(UIImage*)thumbImage forState:(UIControlState)state;

/*
 Set the background gradient for the thumb on the slider bar associated with this renderer.
 */
-(void)setThumbBackgroundGradient:(SCGradient*)thumbBackgroundGradient forState:(UIControlState)state;

/*
 Set the size of the thumb on the slider bar associated with this renderer.
 */
-(void)setThumbSize:(float)thumbSize forState:(UIControlState)state;

/*
 Set the inner shadows for the thumb on the slider bar associated with this renderer.
 */
-(void)setThumbInnerShadows:(NSArray*)thumbInnerShadows forState:(UIControlState)state;

/*
 Set the outer shadows for the thumb on the slider bar associated with this renderer.
 */
-(void)setThumbOuterShadows:(NSArray*)thumbOuterShadows forState:(UIControlState)state;

@end
