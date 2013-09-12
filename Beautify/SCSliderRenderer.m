//
//  SCSliderRenderer.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCVersionUtils.h"
#import "UIView+Utilities.h"
#import "SCStyleRenderer_Private.h"
#import "SCViewRenderer_Private.h"
#import "SCSliderRenderer.h"
#import "SCSliderBarBorderLayer.h"
#import "SCKnobLayer.h"
#import "SCSliderMinimumTrackLayer.h"
#import "SCSliderMaximumTrackLayer.h"
#import "SCRenderUtils.h"
#import "SCSliderBarShadowLayer.h"
#import "SCTheme.h"
#import "SCControlRenderingLayer.h"
#import "SCSliderBackgroundLayer.h"
#import "SCSwitchBorderLayer.h"

@implementation SCSliderRenderer {
    CAShapeLayer* _clipLayerShape;
    CALayer* _clipLayer;
    SCSliderBackgroundLayer *_backgroundLayer;
    SCSliderBarShadowLayer *_barShadowLayer;
    SCSliderBarBorderLayer *_barBorderLayer;
    SCSliderMinimumTrackLayer *_minimumTrackLayer;
    SCSliderMaximumTrackLayer *_maximumTrackLayer;
    SCKnobLayer *_knobLayer;
        
    // User interaction flags
    BOOL _tapped;
    BOOL _panning;
    BOOL _panEnding;
    CGPoint _panLocation;
    
    BOOL _highlighted;
    
    float _sliderThickness;
    float _knobSize;
}

#define WIDTH_PADDING 3

-(id)initWithView:(id)view theme:(SCTheme*)theme {
    if (self = [super initWithView:view theme:theme]) {
        // hijack the slider rendering
        UISlider* slider = (UISlider*)view;
        
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            _sliderThickness = 3;
            _knobSize = 30;
        }
        else{
            _sliderThickness = 10;
            _knobSize = 24;
        }
        
        [self setup:slider];
        [self updateLayerLocations];
        [self redraw];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"frame"] || [keyPath isEqualToString:@"bounds"]) {
        [self redraw];
    }
    
    if ([keyPath isEqualToString:@"value"]) {
        [self updateLayerLocations];
    }
}

-(UISlider*)adaptedSlider {
    return (UISlider*)[self adaptedView];
}

-(void)setup:(UISlider*)slider {
    // hide existing
    [slider setThumbImage:[UIImage new] forState:UIControlStateNormal];
    [slider setMinimumTrackImage:[UIImage new] forState:UIControlStateNormal];
    [slider setMaximumTrackImage:[UIImage new] forState:UIControlStateNormal];
    
    slider.clipsToBounds = NO;
    
    CGRect bounds  = [self sliderBarSizeWithBounds:[self adaptedSlider].bounds andThickness:_sliderThickness];
        
    // create the background layer
    _backgroundLayer = [[SCSliderBackgroundLayer alloc] initWithRenderer:self];
    _backgroundLayer.masksToBounds = NO;
    _backgroundLayer.frame = [self adaptedSlider].bounds;
    [_backgroundLayer  setNeedsDisplay];
    
    // add the backgroundLayer
    [slider.layer addSublayer:_backgroundLayer];
    slider.layer.masksToBounds = NO;
    
    // create the shadow layer
    _barShadowLayer = [[SCSliderBarShadowLayer alloc] initWithRenderer:self];
    [_barShadowLayer setFrame:bounds withWidthPadding:0];
    _barShadowLayer.masksToBounds = NO;
    [_barShadowLayer setNeedsDisplay];
    
    // add the shadow layer
    [slider.layer addSublayer:_barShadowLayer];
    slider.layer.masksToBounds = NO;
    
    _clipLayerShape = [CAShapeLayer layer];
    _clipLayerShape.path = [SCSwitchBorderLayer borderPathForBounds:_barBorderLayer.bounds andBorder:[self propertyValueForNameWithCurrentState:@"barBorder"]].CGPath;
    _clipLayerShape.frame = [self adaptedSlider].bounds;
    
    _clipLayer = [CALayer layer];
    _clipLayer.frame = bounds;
    _clipLayer.backgroundColor = [UIColor clearColor].CGColor;
    _clipLayer.mask = _clipLayerShape;
    
    // create the minimum track layer
    _minimumTrackLayer = [[SCSliderMinimumTrackLayer alloc] initWithRenderer:self];
    _minimumTrackLayer.frame = [self minimumTrackLayerFrame];
    [_minimumTrackLayer setNeedsDisplay];
    
    // create the maximum track layer
    _maximumTrackLayer = [[SCSliderMaximumTrackLayer alloc] initWithRenderer:self];
    _maximumTrackLayer.frame = [self maximumTrackLayerFrame];
    [_maximumTrackLayer setNeedsDisplay];   
            
    [_clipLayer addSublayer:_minimumTrackLayer];
    [_clipLayer addSublayer:_maximumTrackLayer];
    [slider.layer addSublayer:_clipLayer];
    
    // create the bar border layer
    _barBorderLayer = [[SCSliderBarBorderLayer alloc] initWithRenderer:self];
    _barBorderLayer.frame = bounds;
    [_barBorderLayer setNeedsDisplay];
    
    // add the bar border layer
    [slider.layer addSublayer:_barBorderLayer];
    
    // create the knob layer
    _knobLayer = [[SCKnobLayer alloc] initWithRenderer:self];
    _knobLayer.masksToBounds = NO;
    _knobLayer.frame = [self knobFrame];
    [_knobLayer setNeedsDisplay];
    
    // add the knob layer
    [slider.layer addSublayer:_knobLayer];
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

-(CGRect)sliderBarSizeWithBounds:(CGRect)bounds andThickness:(float)size{
    return CGRectInset(CGRectMake(bounds.origin.x, (bounds.size.height / 2) - (size / 2), bounds.size.width, size), WIDTH_PADDING, 0);
}

-(void)updateLayerLocations {
    _knobLayer.frame = [self knobFrame];
    _minimumTrackLayer.frame = [self minimumTrackLayerFrame];
    _maximumTrackLayer.frame = [self maximumTrackLayerFrame];
}

-(CGRect)knobFrame{
    CGRect bounds = [self adaptedSlider].bounds;
    float xOrigin = bounds.origin.x + bounds.size.height / 2;
    float yOrigin = bounds.origin.y + bounds.size.height / 2;
    
    // compute the centre point of the knob
    CGPoint knobCentrePoint = CGPointMake(xOrigin, yOrigin);
            
    knobCentrePoint.x += _panLocation.x;
    
    // limit the x range
    if (knobCentrePoint.x <= [self adaptedSlider].bounds.origin.x + _knobSize) {
        knobCentrePoint.x = [self adaptedSlider].bounds.origin.x + _knobSize;
    } else if (knobCentrePoint.x >= [self adaptedSlider].bounds.size.width) {
        knobCentrePoint.x = [self adaptedSlider].bounds.size.width;
    }
    
    [[self adaptedSlider] setValue: [(UISlider*)[self adaptedSlider] maximumValue] * ((knobCentrePoint.x - _knobSize) / ([self adaptedSlider].bounds.size.width - _knobSize))];
    
     // compute the overall frame
    return CGRectMake(knobCentrePoint.x - _knobSize, knobCentrePoint.y - (_knobSize / 2), _knobSize, _knobSize);
}

-(CGRect)minimumTrackLayerFrame {
    CGRect bounds = [self adaptedSlider].bounds;
    CGRect knobLocation = [self knobFrame];
    
    bounds.size.height = _sliderThickness;
    bounds.size.width = (knobLocation.origin.x + (knobLocation.size.width / 2));
    
    return bounds;
}

-(CGRect)maximumTrackLayerFrame {
    CGRect bounds = [self adaptedSlider].bounds;
    CGRect knobLocation = [self knobFrame];
    
    bounds.size.height = _sliderThickness;
    bounds.origin.x = (knobLocation.origin.x + (knobLocation.size.width / 2));
    bounds.size.width = bounds.size.width - _minimumTrackLayer.bounds.size.width;
    
    return bounds;
}

#pragma mark - superclass overrides

// updates the bounds of the various layers in response to the overall slider frame being changed
-(void)redraw {
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
    
    CGRect bounds = [self sliderBarSizeWithBounds:[self adaptedSlider].bounds andThickness:_sliderThickness];
    
    // update the frames
    _backgroundLayer.frame = [self adaptedSlider].bounds;
    [_barShadowLayer setFrame:bounds withWidthPadding:WIDTH_PADDING];
    _clipLayer.frame = bounds;
    _minimumTrackLayer.frame = [self  minimumTrackLayerFrame];
    _maximumTrackLayer.frame = [self maximumTrackLayerFrame];
    _barBorderLayer.frame = bounds;
    _knobLayer.frame = [self knobFrame];
    
    _clipLayerShape.path = [SCSwitchBorderLayer borderPathForBounds:_barBorderLayer.bounds andBorder:[self propertyValueForNameWithCurrentState:@"barBorder"]].CGPath;
    [_backgroundLayer setNeedsDisplay];
    [_barShadowLayer setNeedsDisplay];    
    [_minimumTrackLayer setNeedsDisplay];
    [_maximumTrackLayer setNeedsDisplay];
    [_clipLayerShape setNeedsDisplay];
    [_clipLayer setNeedsDisplay];
    [_barBorderLayer setNeedsDisplay];
    [_knobLayer setNeedsDisplay];
    
    [super configureFromStyle];
    
    [CATransaction commit];
}

-(id)styleFromTheme:(SCTheme*)theme {
    if(theme.sliderStyle) {
        return theme.sliderStyle;
    }
    return [SCSliderStyle defaultStyle];
}

-(UIControlState)currentControlState {
    return _highlighted ? UIControlStateHighlighted : UIControlStateNormal;
}

#pragma mark - User interaction handling

-(void)panning:(UIPanGestureRecognizer*)gesture {
    
    // get the current location
    _panLocation = [gesture locationInView:self.adaptedSlider];
    
//    if (gesture.state == UIGestureRecognizerStateBegan) {
        _panning = YES;
//    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        _panning = NO;
        _panEnding = YES;
    
        _knobLayer.frame = [self knobFrame];
           
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

// border
-(void)setBorder:(SCBorder*)border forState:(UIControlState)state {
    [self setPropertyValue:border forName:@"border" forState:state];
}

-(void)setBackgroundColor:(UIColor*)backgroundColor forState:(UIControlState)state {
    [self setPropertyValue:backgroundColor forName:@"backgroundColor" forState:state];
}

// slider bar
-(void)setBarBorder:(SCBorder*)barBorder forState:(UIControlState)state {
    [self setPropertyValue:barBorder forName:@"barBorder" forState:state];
}

-(void)setBarInnerShadows:(NSArray*)barInnerShadows forState:(UIControlState)state {
    [self setPropertyValue:barInnerShadows forName:@"barInnerShadows" forState:state];
}

-(void)setBarOuterShadows:(NSArray*)barOuterShadows forState:(UIControlState)state {
    [self setPropertyValue:barOuterShadows forName:@"barOuterShadows" forState:state];
}

// minimum track
-(void)setMinimumTrackColor:(UIColor*)minimumTrackColor forState:(UIControlState)state {
    [self setPropertyValue:minimumTrackColor forName:@"minimumTrackColor" forState:state];
}

-(void)setMinimumTrackImage:(UIImage*)minimumTrackImage forState:(UIControlState)state {
    [self setPropertyValue:minimumTrackImage forName:@"minimumTrackImage" forState:state];
}

-(void)setMinimumTrackBackgroundGradient:(SCGradient*)minimumTrackBackgroundGradient forState:(UIControlState)state {
    [self setPropertyValue:minimumTrackBackgroundGradient forName:@"minimumTrackBackgroundGradient" forState:state];
}

// maximum track
-(void)setMaximumTrackColor:(UIColor*)maxiumuTrackColor forState:(UIControlState)state {
    [self setPropertyValue:maxiumuTrackColor forName:@"maximumTrackColor" forState:state];
}

-(void)setMaximumTrackImage:(UIImage*)maximumTrackImage forState:(UIControlState)state {
    [self setPropertyValue:maximumTrackImage forName:@"maximumTrackImage" forState:state];
}

-(void)setMaximumTrackBackgroundGradient:(SCGradient*)maximumTrackBackgroundGradient forState:(UIControlState)state {
    [self setPropertyValue:maximumTrackBackgroundGradient forName:@"maximumTrackBackgroundGradient" forState:state];
}

// knob
- (void)setKnobBorder:(SCBorder *)knobBorder forState:(UIControlState)state {
    [self setPropertyValue:knobBorder forName:@"knobBorder" forState:state];
}

-(void)setKnobBackgroundColor:(UIColor*)knobBackgroundColor forState:(UIControlState)state {
    [self setPropertyValue:knobBackgroundColor forName:@"knobBackgroundColor" forState:state];
}

-(void)setKnobImage:(UIImage*)knobImage forState:(UIControlState)state {
    [self setPropertyValue:knobImage forName:@"knobImage" forState:state];
}

-(void)setKnobBackgroundGradient:(SCGradient*)knobBackgroundGradient forState:(UIControlState)state {
    [self setPropertyValue:knobBackgroundGradient forName:@"knobBackgroundGradient" forState:state];
}

-(void)setKnobSize:(float)knobSize forState:(UIControlState)state {
    [self setPropertyValue:[NSValue value:&knobSize
                             withObjCType:@encode(float)] forName:@"knobSize" forState:state];
}

-(void)setKnobInnerShadows:(NSArray*)knobInnerShadows forState:(UIControlState)state {
    [self setPropertyValue:knobInnerShadows forName:@"knobInnerShadows" forState:state];
}

-(void)setKnobOuterShadows:(NSArray*)knobOuterShadows forState:(UIControlState)state {
    [self setPropertyValue:knobOuterShadows forName:@"knobOuterShadows" forState:state];
}

@end
