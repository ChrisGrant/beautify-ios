//
//  SwitchRenderer.h
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYViewRenderer.h"

@class BYFont, BYGradient, BYBorder, BYSwitchState;

/*
 A renderer responsible for enhancing a UISwitch.
 
 The style properties for a UISwitch can be customized using methods defined in this class.
 */
@interface BYSwitchRenderer : BYViewRenderer <UIGestureRecognizerDelegate>

#pragma mark - ON / OFF state customizers

/*
 Set the style of slider in the 'ON' position for the switch associated with this renderer.
 */
-(void)setOnState:(BYSwitchState*)switchState forState:(UIControlState)state;

/*
 Set the style of slider in the 'OFF' position for the switch associated with this renderer.
 */
-(void)setOffState:(BYSwitchState*)switchState forState:(UIControlState)state;

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
-(void)setBorder:(BYBorder*)border forState:(UIControlState)state;

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

#pragma mark - Thumb customizers

/*
 Set the border for the thumb on the switch associated with this renderer.
 */
-(void)setThumbBorder:(BYBorder*)border forState:(UIControlState)state;

/*
 Set the background color for the thumb on the switch associated with this renderer.
 */
-(void)setThumbBackgroundColor:(UIColor*)thumbBackgroundColor forState:(UIControlState)state;

/*
 Set the highlight color for the thumb on the switch associated with this renderer.
 */
-(void)setThumbHighlightColor:(UIColor*)thumbHighlightColor forState:(UIControlState)state;

/*
 Set the background gradient for the thumb on the switch associated with this renderer.
 */
-(void)setThumbBackgroundGradient:(BYGradient*)thumbBackgroundGradient forState:(UIControlState)state;

/*
 Set the inner shadows for the thumb on the switch associated with this renderer.
 */
-(void)setThumbInnerShadows:(NSArray*)thumbInnerShadows forState:(UIControlState)state;

/*
 Set the outer shadows for the thumb on the switch associated with this renderer.
 */
-(void)setThumbOuterShadows:(NSArray*)thumbOuterShadows forState:(UIControlState)state;

/*
 Set the image for the thumb on the switch associated with this renderer.
 */
-(void)setThumbImage:(UIImage*)thumbImage forState:(UIControlState)state;

@end