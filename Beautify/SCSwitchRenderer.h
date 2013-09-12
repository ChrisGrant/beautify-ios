//
//  SwitchRenderer.h
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCViewRenderer.h"

@class SCFont, SCGradient, SCBorder, SCSwitchState;

/*
 A renderer responsible for enhancing a UISwitch.
 
 The style properties for a UISwitch can be customized using methods defined in this class.
 */
@interface SCSwitchRenderer : SCViewRenderer <UIGestureRecognizerDelegate>

#pragma mark - ON / OFF state customizers

/*
 Set the style of slider in the 'ON' position for the switch associated with this renderer.
 */
-(void)setOnState:(SCSwitchState*)switchState forState:(UIControlState)state;

/*
 Set the style of slider in the 'OFF' position for the switch associated with this renderer.
 */
-(void)setOffState:(SCSwitchState*)switchState forState:(UIControlState)state;

/*
 Set the image for the track layer on the switch associated with this renderer.
 */
-(void)setTrackLayerImage:(UIImage*)trackLayerImage forState:(UIControlState)state;


#pragma mark - Background customizers

/*
 Set the background highlight color for the labels on the switch associated with this renderer.
 */
-(void)setHighlightColor:(UIColor*)highlightColor forState:(UIControlState)state;

#pragma mark - Border customizers

/*
 Set the border for the switch associated with this renderer.
 */
-(void)setBorder:(SCBorder*)border forState:(UIControlState)state;

/*
 Set the inner shadows for the switch associated with this renderer.
 */
-(void)setInnerShadows:(NSArray*)innerShadows forState:(UIControlState)state;

/*
 Set the outer shadows for the switch associated with this renderer.
 */
-(void)setOuterShadows:(NSArray*)outerShadows forState:(UIControlState)state;

/*
 Set the image for the border layer on the switch associated with this renderer.
 */
-(void)setBorderLayerImage:(UIImage*)borderLayerImage forState:(UIControlState)state;

#pragma mark - Knob customizers

/*
 Set the border for the knob on the switch associated with this renderer.
 */
-(void)setKnobBorder:(SCBorder*)border forState:(UIControlState)state;

/*
 Set the background color for the knob on the switch associated with this renderer.
 */
-(void)setKnobBackgroundColor:(UIColor*)knobBackgroundColor forState:(UIControlState)state;

/*
 Set the highlight color for the knob on the switch associated with this renderer.
 */
-(void)setKnobHighlightColor:(UIColor*)knobHighlightColor forState:(UIControlState)state;

/*
 Set the background gradient for the knob on the switch associated with this renderer.
 */
-(void)setKnobBackgroundGradient:(SCGradient*)knobBackgroundGradient forState:(UIControlState)state;

/*
 Set the inner shadows for the knob on the switch associated with this renderer.
 */
-(void)setKnobInnerShadows:(NSArray*)knobInnerShadows forState:(UIControlState)state;

/*
 Set the outer shadows for the knob on the switch associated with this renderer.
 */
-(void)setKnobOuterShadows:(NSArray*)knobOuterShadows forState:(UIControlState)state;

/*
 Set the image for the knob on the switch associated with this renderer.
 */
-(void)setKnobImage:(UIImage*)knobImage forState:(UIControlState)state;

@end