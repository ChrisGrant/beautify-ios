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

#pragma mark - knob customizers

/*
 Set the border for the knob on the slider bar associated with this renderer.
 */
- (void)setKnobBorder:(SCBorder *)knobBorder forState:(UIControlState)state;

/*
 Set the background color for the knob on the slider bar associated with this renderer.
 */
-(void)setKnobBackgroundColor:(UIColor*)knobBackgroundColor forState:(UIControlState)state;

/*
 Set the image for the knob on the the slider bar associated with this renderer.
 */
-(void)setKnobImage:(UIImage*)knobImage forState:(UIControlState)state;

/*
 Set the background gradient for the knob on the slider bar associated with this renderer.
 */
-(void)setKnobBackgroundGradient:(SCGradient*)knobBackgroundGradient forState:(UIControlState)state;

/*
 Set the size of the knob on the slider bar associated with this renderer.
 */
-(void)setKnobSize:(float)knobSize forState:(UIControlState)state;

/*
 Set the inner shadows for the knob on the slider bar associated with this renderer.
 */
-(void)setKnobInnerShadows:(NSArray*)knobInnerShadows forState:(UIControlState)state;

/*
 Set the outer shadows for the knob on the slider bar associated with this renderer.
 */
-(void)setKnobOuterShadows:(NSArray*)knobOuterShadows forState:(UIControlState)state;

@end
