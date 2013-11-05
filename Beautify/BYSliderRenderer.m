//
//  BYSliderRenderer.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYPlatformVersionUtils.h"
#import "UIView+Utilities.h"
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYSliderRenderer.h"
#import "BYSliderBarBorderLayer.h"
#import "BYThumbLayer.h"
#import "BYSliderMinimumTrackLayer.h"
#import "BYSliderMaximumTrackLayer.h"
#import "BYRenderUtils.h"
#import "BYSliderBarShadowLayer.h"
#import "BYTheme.h"
#import "BYControlRenderingLayer.h"
#import "BYSwitchBorderLayer.h"

@implementation BYSliderRenderer {
    CAShapeLayer* _clipLayerShape;
    CALayer* _clipLayer;
    BYSliderBarShadowLayer *_barShadowLayer;
    BYSliderBarBorderLayer *_barBorderLayer;
    BYSliderMinimumTrackLayer *_minimumTrackLayer;
    BYSliderMaximumTrackLayer *_maximumTrackLayer;
    BYThumbLayer *_thumbLayer;
    
    // User interaction flags
    BOOL _tapped;
    BOOL _panning;
    BOOL _panEnding;
    BOOL _highlighted;
    
    float _thumbSize;
}

#define WIDTH_PADDING 3

-(id)initWithView:(id)view theme:(BYTheme*)theme {
    if (self = [super initWithView:view theme:theme]) {
        // hijack the slider rendering
        UISlider* slider = (UISlider*)view;
        
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            _thumbSize = 27;
        }
        else {
            _thumbSize = 24;
        }
        
        [self setup:slider];
        [self updateLayerLocations];
        [self redraw];
    }
    return self;
}

-(UISlider*)adaptedSlider {
    return [self adaptedView];
}

-(void)setup:(UISlider*)slider {
    slider.clipsToBounds = NO;
    
    CGRect bounds  = [self sliderBarSizeWithBounds:[self adaptedSlider].bounds andThickness:[self sliderThickness]];
    
    // create the shadow layer
    _barShadowLayer = [[BYSliderBarShadowLayer alloc] initWithRenderer:self];
    [_barShadowLayer setFrame:bounds withWidthPadding:0];
    _barShadowLayer.masksToBounds = NO;
    [_barShadowLayer setNeedsDisplay];
    
    // add the shadow layer
    [slider.layer addSublayer:_barShadowLayer];
    slider.layer.masksToBounds = NO;
    
    _clipLayerShape = [CAShapeLayer layer];
    _clipLayerShape.path = [BYSwitchBorderLayer borderPathForBounds:_barBorderLayer.bounds
                                                          andBorder:[self propertyValueForNameWithCurrentState:@"barBorder"]].CGPath;
    _clipLayerShape.frame = [self adaptedSlider].bounds;
    
    _clipLayer = [CALayer layer];
    _clipLayer.frame = bounds;
    _clipLayer.backgroundColor = [UIColor clearColor].CGColor;
    _clipLayer.mask = _clipLayerShape;
    
    // create the minimum track layer
    _minimumTrackLayer = [[BYSliderMinimumTrackLayer alloc] initWithRenderer:self];
    _minimumTrackLayer.frame = [self minimumTrackLayerFrame];
    [_minimumTrackLayer setNeedsDisplay];
    
    // create the maximum track layer
    _maximumTrackLayer = [[BYSliderMaximumTrackLayer alloc] initWithRenderer:self];
    _maximumTrackLayer.frame = [self maximumTrackLayerFrame];
    [_maximumTrackLayer setNeedsDisplay];
    
    [_clipLayer addSublayer:_minimumTrackLayer];
    [_clipLayer addSublayer:_maximumTrackLayer];
    [slider.layer addSublayer:_clipLayer];
    
    // create the bar border layer
    _barBorderLayer = [[BYSliderBarBorderLayer alloc] initWithRenderer:self];
    _barBorderLayer.frame = bounds;
    [_barBorderLayer setNeedsDisplay];
    
    // add the bar border layer
    [slider.layer addSublayer:_barBorderLayer];
    
    // create the thumb layer
    _thumbLayer = [[BYThumbLayer alloc] initWithRenderer:self];
    _thumbLayer.masksToBounds = NO;
    _thumbLayer.frame = [self thumbFrame];
    [_thumbLayer setNeedsDisplay];
    
    // add the thumb layer
    [slider.layer addSublayer:_thumbLayer];
    slider.layer.masksToBounds = NO;
    
    // pan gesture for toggling the slider
	UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panning:)];
	[panGestureRecognizer setDelegate:self];
	[slider addGestureRecognizer:panGestureRecognizer];
    
    // handle tap/touch events
    [slider addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [slider addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    [slider addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
    [slider addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventValueChanged];
}

// We should only begin a gesture if the touch started on top of the thumb
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint touchTranslation = [panGestureRecognizer translationInView:self.adaptedView];
        CGPoint currentTouchLoc = [gestureRecognizer locationOfTouch:0 inView:self.adaptedView];
        
        // Calculate the touch's start location based on the translation from the first touch and the current location.
        CGPoint startLocation = CGPointMake(currentTouchLoc.x - touchTranslation.x, currentTouchLoc.y - touchTranslation.y);
        
        CGRect thumbFrame = CGRectInset([self thumbFrame], -15, -15); // Add padding so touch doesn't have to be exact.
        if(!CGRectContainsPoint(thumbFrame, startLocation)) {
            return NO;
        }
    }
    return YES;
}

-(CGRect)sliderBarSizeWithBounds:(CGRect)bounds andThickness:(float)thickness{
    return CGRectInset(CGRectMake(bounds.origin.x, (bounds.size.height / 2) - (thickness / 2), bounds.size.width, thickness), WIDTH_PADDING, 0);
}

-(void)updateLayerLocations {
    _thumbLayer.frame = [self thumbFrame];
    _minimumTrackLayer.frame = [self minimumTrackLayerFrame];
    _maximumTrackLayer.frame = [self maximumTrackLayerFrame];
}

-(CGRect)thumbFrame{
    UISlider *slider = [self adaptedSlider];
    CGRect bounds = slider.bounds;
    float xOrigin = bounds.origin.x + bounds.size.height / 2;
    float yOrigin = bounds.origin.y + bounds.size.height / 2;
    
    // compute the centre point of the thumb
    CGPoint thumbCentrePoint = CGPointMake(xOrigin, yOrigin);
    
    thumbCentrePoint.x += slider.value * slider.bounds.size.width;
    
    // limit the x range
    if (thumbCentrePoint.x <= slider.bounds.origin.x + _thumbSize) {
        thumbCentrePoint.x = slider.bounds.origin.x + _thumbSize;
    }
    else if (thumbCentrePoint.x >= slider.bounds.size.width) {
        thumbCentrePoint.x = slider.bounds.size.width;
    }
    
    // compute the overall frame
    return CGRectMake(thumbCentrePoint.x - _thumbSize, thumbCentrePoint.y - (_thumbSize / 2), _thumbSize, _thumbSize);
}

-(CGRect)minimumTrackLayerFrame {
    CGRect bounds = [self adaptedSlider].bounds;
    CGRect thumbLocation = [self thumbFrame];
    bounds.size.height = [self sliderThickness];
    bounds.size.width = (thumbLocation.origin.x + (thumbLocation.size.width / 2));
    return bounds;
}

-(CGRect)maximumTrackLayerFrame {
    CGRect bounds = [self adaptedSlider].bounds;
    CGRect thumbLocation = [self thumbFrame];
    bounds.size.height = [self sliderThickness];
    bounds.origin.x = (thumbLocation.origin.x + (thumbLocation.size.width / 2));
    bounds.size.width = bounds.size.width - _minimumTrackLayer.bounds.size.width;
    return bounds;
}

#pragma mark - superclass overrides

// updates the bounds of the various layers in response to the overall slider frame being changed
-(void)redraw {
    
    [self.adaptedView hideAllSubViews];
    
    [CATransaction begin];
    
    if (_tapped) {
        _tapped = NO;
    }
    else if (_panEnding) {
        _panEnding = NO;
    }
    else {
        [CATransaction setDisableActions:YES];
    }
    
    CGRect bounds = [self sliderBarSizeWithBounds:[self adaptedSlider].bounds andThickness:[self sliderThickness]];
    
    // update the frames
    [_barShadowLayer setFrame:bounds withWidthPadding:WIDTH_PADDING];
    _clipLayer.frame = bounds;
    _minimumTrackLayer.frame = [self  minimumTrackLayerFrame];
    _maximumTrackLayer.frame = [self maximumTrackLayerFrame];
    _barBorderLayer.frame = bounds;
    _thumbLayer.frame = [self thumbFrame];
    
    _clipLayerShape.path = [BYSwitchBorderLayer borderPathForBounds:_barBorderLayer.bounds
                                                          andBorder:[self propertyValueForNameWithCurrentState:@"barBorder"]].CGPath;
    [_barShadowLayer setNeedsDisplay];
    [_minimumTrackLayer setNeedsDisplay];
    [_maximumTrackLayer setNeedsDisplay];
    [_clipLayerShape setNeedsDisplay];
    [_clipLayer setNeedsDisplay];
    [_barBorderLayer setNeedsDisplay];
    [_thumbLayer setNeedsDisplay];
    
    [super configureFromStyle];
    
    [CATransaction commit];
}

// the slider thickness is a fraction of the control's height
-(float)sliderThickness {
    return [self adaptedSlider].bounds.size.height * [[self propertyValueForNameWithCurrentState:@"barHeightFraction"] floatValue];
}

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.sliderStyle) {
        return theme.sliderStyle;
    }
    return [BYSliderStyle defaultStyle];
}

-(UIControlState)currentControlState {
    return _highlighted ? UIControlStateHighlighted : UIControlStateNormal;
}

#pragma mark - User interaction handling

-(void)panning:(UIPanGestureRecognizer*)gesture {
    CGPoint panLocation = [gesture locationInView:self.adaptedSlider];
    
    ((UISlider*)self.adaptedView).value = panLocation.x / ((UIView*)self.adaptedView).bounds.size.width;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _panning = YES;
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        _panning = NO;
        _panEnding = YES;
    }
    
    [[self adaptedSlider] sendActionsForControlEvents:UIControlEventValueChanged];
    [self updateLayerLocations];
}

-(void)touchDown {
    _highlighted = YES;
    [self redraw];
}

-(void)touchUp {
    _highlighted = NO;
    [self redraw];
}

#pragma mark - Style property setters

// slider bar

- (void)setBarHeightFraction:(float)barHeightFraction forState:(UIControlState)state {
    [self setPropertyValue:@(barHeightFraction) forName:@"barHeightFraction" forState:state];
}

-(void)setBarBorder:(BYBorder*)barBorder forState:(UIControlState)state {
    [self setPropertyValue:barBorder forName:@"barBorder" forState:state];
}

-(void)setBarInnerShadow:(BYShadow*)barInnerShadow forState:(UIControlState)state {
    [self setPropertyValue:barInnerShadow forName:@"barInnerShadow" forState:state];
}

-(void)setBarOuterShadow:(BYShadow*)barouterShadow forState:(UIControlState)state {
    [self setPropertyValue:barouterShadow forName:@"barouterShadow" forState:state];
}

// minimum track
-(void)setMinimumTrackColor:(UIColor*)minimumTrackColor forState:(UIControlState)state {
    [self setPropertyValue:minimumTrackColor forName:@"minimumTrackColor" forState:state];
}

-(void)setMinimumTrackImage:(UIImage*)minimumTrackImage forState:(UIControlState)state {
    [self setPropertyValue:minimumTrackImage forName:@"minimumTrackImage" forState:state];
}

-(void)setMinimumTrackBackgroundGradient:(BYGradient*)minimumTrackBackgroundGradient forState:(UIControlState)state {
    [self setPropertyValue:minimumTrackBackgroundGradient forName:@"minimumTrackBackgroundGradient" forState:state];
}

// maximum track
-(void)setMaximumTrackColor:(UIColor*)maxiumuTrackColor forState:(UIControlState)state {
    [self setPropertyValue:maxiumuTrackColor forName:@"maximumTrackColor" forState:state];
}

-(void)setMaximumTrackImage:(UIImage*)maximumTrackImage forState:(UIControlState)state {
    [self setPropertyValue:maximumTrackImage forName:@"maximumTrackImage" forState:state];
}

-(void)setMaximumTrackBackgroundGradient:(BYGradient*)maximumTrackBackgroundGradient forState:(UIControlState)state {
    [self setPropertyValue:maximumTrackBackgroundGradient forName:@"maximumTrackBackgroundGradient" forState:state];
}

// thumb
- (void)setThumbBorder:(BYBorder *)thumbBorder forState:(UIControlState)state {
    [self setPropertyValue:thumbBorder forName:@"thumbBorder" forState:state];
}

-(void)setThumbBackgroundColor:(UIColor*)thumbBackgroundColor forState:(UIControlState)state {
    [self setPropertyValue:thumbBackgroundColor forName:@"thumbBackgroundColor" forState:state];
}

-(void)setThumbImage:(UIImage*)thumbImage forState:(UIControlState)state {
    [self setPropertyValue:thumbImage forName:@"thumbImage" forState:state];
}

-(void)setThumbBackgroundGradient:(BYGradient*)thumbBackgroundGradient forState:(UIControlState)state {
    [self setPropertyValue:thumbBackgroundGradient forName:@"thumbBackgroundGradient" forState:state];
}

-(void)setThumbSize:(float)thumbSize forState:(UIControlState)state {
    [self setPropertyValue:[NSValue value:&thumbSize
                             withObjCType:@encode(float)] forName:@"thumbSize" forState:state];
}

-(void)setThumbInnerShadow:(BYShadow*)thumbInnerShadow forState:(UIControlState)state {
    [self setPropertyValue:thumbInnerShadow forName:@"thumbInnerShadow" forState:state];
}

-(void)setThumbOuterShadow:(BYShadow*)thumbOuterShadow forState:(UIControlState)state {
    [self setPropertyValue:thumbOuterShadow forName:@"thumbOuterShadow" forState:state];
}

@end