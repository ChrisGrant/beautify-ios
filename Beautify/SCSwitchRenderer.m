//
//  SwitchRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIView+Utilities.h"
#import "SCStyleRenderer_Private.h"
#import "SCViewRenderer_Private.h"
#import "SCSwitchRenderer.h"
#import "SCSwitchBorderLayer.h"
#import "SCKnobLayer.h"
#import "SCSwitchToggleLayer.h"
#import "SCRenderUtils.h"
#import "SCSwitchShadowLayer.h"
#import "SCTheme.h"
#import "SCControlRenderingLayer.h"
#import "UISwitch+Beautify.h"
#import "SCSwitchGestureView.h"
#import "SCSwitchBorderLayer.h"

@implementation SCSwitchRenderer {
    CAShapeLayer* _clipLayerShape;
    CALayer* _clipLayer;
    SCKnobLayer* _knobLayer;
    SCSwitchBorderLayer* _borderLayer;
    SCSwitchShadowLayer* _shadowLayer;
    SCSwitchToggleLayer* _toggleLayer;
    
    // the end-to-end lanegth of the track (includes the 'ON' and the 'OFF' rendering
    CGFloat _trackLength;
    
    CGFloat _thumbWidth;
    
    // the offset that is applied to the track in order to toggle state
    CGFloat _toggleOffset;
    
    // User interaction flags
    BOOL _tapped;
    BOOL _panning;
    BOOL _panEnding;
    CGPoint _panLocation;
    
    BOOL _highlighted;
    
    SCSwitchGestureView *_gestureView;
}

-(id)initWithView:(id)view theme:(SCTheme*)theme {
    if (self = [super initWithView:view theme:theme]) {
        // hijack the switch rendering
        UISwitch* swtch = (UISwitch*)view;
        [self setup:swtch];
        [self updateLayerLocations];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"] || [keyPath isEqualToString:@"bounds"]) {
        [self redraw];
    }
    
    if ([keyPath isEqualToString:@"isOn"]) {
        [self updateLayerLocations];
    }
}

-(UISwitch*)adaptedSwitch {
    return (UISwitch*)[self adaptedView];
}

-(CGRect)adaptedBounds {
    CGSize size = [[self adaptedSwitch] desiredSwitchSize];
    return CGRectMake(0, 0, size.width, size.height);
}

-(void)setup:(UISwitch*)swtch {
    // hide existing
    [swtch hideAllSubViews];

    swtch.clipsToBounds = NO;
    
    CGRect bounds = [self adaptedBounds];
    CGSize size = bounds.size;
    _thumbWidth = size.height;
    _trackLength = (size.width - size.height/2)*2;
    _toggleOffset = size.width - size.height;
    
    // create the knob layer
    _knobLayer = [[SCKnobLayer alloc] initWithRenderer:self];
    _knobLayer.masksToBounds = NO;
    _knobLayer.frame = [self knobFrame];
    [_knobLayer setNeedsDisplay];
    
    // create the border layer
    _borderLayer = [[SCSwitchBorderLayer alloc] initWithRenderer:self];
    // the frame is inset to accomodate the shadow
    _borderLayer.frame = bounds;
    [_borderLayer setNeedsDisplay];
       
    // create the toggle layer
    _toggleLayer = [[SCSwitchToggleLayer alloc] initWithRenderer:self];
    // the frame is computed based on the current toggle state
    _toggleLayer.frame = [self toggleLayerFrame];
    [_toggleLayer setNeedsDisplay];
    
    // create the shadow layer
    _shadowLayer = [[SCSwitchShadowLayer alloc] initWithRenderer:self];
    // the shadow occupies the entire
    [_shadowLayer setFrame:swtch.bounds];
    _shadowLayer.masksToBounds = NO;
    [_shadowLayer setNeedsDisplay];
    
    // create a layer clipped to the border path of the switch
    _clipLayerShape = [CAShapeLayer layer];
    _clipLayerShape.path = [SCSwitchBorderLayer borderPathForBounds:_borderLayer.bounds andBorder:[self propertyValueForNameWithCurrentState:@"border"]].CGPath;
    _clipLayerShape.frame = bounds;
    
    _clipLayer = [CALayer layer];
    _clipLayer.frame = bounds;
    _clipLayer.backgroundColor = [UIColor clearColor].CGColor;
    _clipLayer.mask = _clipLayerShape;
    
    // add the shadow layer
    [swtch.layer addSublayer:_shadowLayer];
    swtch.layer.masksToBounds = NO;
    
    // add the toggle layer within the clipped layer
    [swtch.layer addSublayer:_clipLayer];
    [_clipLayer addSublayer:_toggleLayer];
    
    // add the border layer
    [swtch.layer addSublayer:_borderLayer];
    
    // add the knob layer
    [swtch.layer addSublayer:_knobLayer];
    
    // Put a view on top for the gestures - otherwise it will be the wrong size!
    _gestureView = [SCSwitchGestureView new];
    [_gestureView setAdaptedSwitch:[self adaptedSwitch]];
    [_gestureView setAlpha:0.0];
    [self.adaptedSwitch.window addSubview:_gestureView];
    
    // tap gesture for toggling the switch
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																						   action:@selector(tapped:)];
	[tapGestureRecognizer setDelegate:self];
	[_gestureView addGestureRecognizer:tapGestureRecognizer];
    
    // tap gesture for toggling the switch
	UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                action:@selector(swiped:)];
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
	[swipeGestureRecognizer setDelegate:self];
	[_gestureView addGestureRecognizer:swipeGestureRecognizer];
    
    // pan gesture for toggling the switch
	UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(panning:)];
	[panGestureRecognizer setDelegate:self];
	[_gestureView addGestureRecognizer:panGestureRecognizer];
    
    // For the initial press if it isn't a tap.
    UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    pressRecognizer.minimumPressDuration = 0.2;
    [_gestureView addGestureRecognizer:pressRecognizer];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer {
    return YES;
}

-(void)longPress:(UILongPressGestureRecognizer*)gesture {
    if(gesture.state == UIGestureRecognizerStateEnded) {
        _highlighted = NO;
        [self redraw];
    }
    else {
        _highlighted = YES;
        [self redraw];
    }
}

-(void)viewDidMoveToWindow {
    [self checkGestureViewSetup];
}

-(void)updateLayerLocations {
    _knobLayer.frame = [self knobFrame];
    _toggleLayer.frame = [self toggleLayerFrame];
}

-(CGRect)knobFrame {
    CGRect bounds = [self adaptedBounds];
    float xOrigin = bounds.origin.x + bounds.size.height / 2;
    float yOrigin = bounds.origin.y + bounds.size.height / 2;
    float halfWidth = bounds.size.height / 2;
    
    // compute the centre point of the knob
    CGPoint knobCentrePoint = CGPointMake(xOrigin, yOrigin);
    
    // adjust for whether the switch is currently on or off
    knobCentrePoint.x += ([self adaptedSwitch].isOn) ? _toggleOffset : 0;
    
    if (_panning) {
        // offset based on current panning state
        knobCentrePoint.x += _panLocation.x;
        
        // limit the x range
        if (knobCentrePoint.x + halfWidth > bounds.size.width) {
            knobCentrePoint.x = xOrigin + _toggleOffset;
        }
        else if (knobCentrePoint.x - halfWidth < 0) {
            knobCentrePoint.x = xOrigin;
        }
    }
    
    // compute the overall frame
    return CGRectMake(knobCentrePoint.x - halfWidth, knobCentrePoint.y - halfWidth,
                      bounds.size.height, bounds.size.height);
}

-(CGRect)toggleLayerFrame {
    CGRect bounds = [self adaptedBounds];
    float toggleX = [self adaptedSwitch].isOn ? 0 : -_toggleOffset;
    
    if (_panning) {
        // offset based on current panning state
        toggleX += _panLocation.x;
        
        // limit the x range
        if (toggleX > 0) {
            toggleX = 0;
        } else if (toggleX < -_toggleOffset) {
            toggleX = -_toggleOffset;
        }
    }
    return CGRectMake(toggleX, 0, _trackLength, bounds.size.height);
}

#pragma mark - superclass overrides

// updates the bounds of the various layers in response to the overall switch frame being changed
-(void)redraw {
    [self checkGestureViewSetup];
    
    [CATransaction begin];
    CGRect bounds = [self adaptedBounds];
    if (_tapped) {
        _tapped = NO;
    }
    else if (_panEnding) {
        _panEnding = NO;
    }
    else {
        [CATransaction setDisableActions:YES];
    }
    
    // update the frames
    _clipLayer.frame = bounds;
    _borderLayer.frame = bounds;
    _shadowLayer.frame = [self adaptedBounds];
    _toggleLayer.frame = [self toggleLayerFrame];
    _knobLayer.frame = [self knobFrame];
    
    // border radius affects the clip of the toggle layer
    _clipLayerShape.path = [SCSwitchBorderLayer borderPathForBounds:_borderLayer.bounds andBorder:[self propertyValueForNameWithCurrentState:@"border"]].CGPath;
    
    [_clipLayerShape setNeedsDisplay];
    [_clipLayer setNeedsDisplay];
    [_borderLayer setNeedsDisplay];
    [_shadowLayer setNeedsDisplay];
    [_toggleLayer setNeedsDisplay];
    [_knobLayer setNeedsDisplay];
    
    [super configureFromStyle];
    
    [CATransaction commit];
}

-(void)checkGestureViewSetup {
    if(_gestureView.superview == nil) {
        [[self adaptedSwitch].window addSubview:_gestureView];
    }
}

-(id)styleFromTheme:(SCTheme*)theme {
    if(theme.switchStyle) {
        return theme.switchStyle;
    }
    return [SCSwitchStyle defaultStyle];
}

-(UIControlState)currentControlState {
    return _highlighted ? UIControlStateHighlighted : UIControlStateNormal;
}

#pragma mark - User interaction handling

-(void)tapped:(UITapGestureRecognizer*)gesture {
    _tapped = YES;
    [[self adaptedSwitch] setOn:![self adaptedSwitch].isOn];
    [[self adaptedSwitch] sendActionsForControlEvents:UIControlEventValueChanged];
    [self updateLayerLocations];
}

-(void)swiped:(UISwipeGestureRecognizer*)gesture {
    [[self adaptedSwitch] setOn:![self adaptedSwitch].isOn];
    [[self adaptedSwitch] sendActionsForControlEvents:UIControlEventValueChanged];
    [self updateLayerLocations];
}

-(void)panning:(UIPanGestureRecognizer*)gesture {
    CGRect bounds = [self adaptedBounds];
    
    // get the current location
    _panLocation = [gesture translationInView:self.adaptedView];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _panning = YES;
        _highlighted = YES;
        [self redraw];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateFailed) {
        _panning = NO;
        _panEnding = YES;
        _highlighted = NO;
        [self redraw];
        
        // check which state the switch should be left in
        float currentX = bounds.origin.x + bounds.size.height / 2;
        // adjust for whether the switch is currently on or off
        currentX += [self adaptedSwitch].isOn ? _toggleOffset : 0;
        // offset based on current panning state
        currentX += _panLocation.x;
        
        float midPoint = [self adaptedBounds].size.width / 2;
        [self adaptedSwitch].on = (currentX > midPoint);
        
        [[self adaptedSwitch] sendActionsForControlEvents:UIControlEventValueChanged];
    }
    [self updateLayerLocations];
}

#pragma mark - Style property setters

// track layer
-(void)setOnState:(SCSwitchState *)switchState forState:(UIControlState)state {
    [self setPropertyValue:switchState forName:@"onState" forState:state];
}

-(void)setOffState:(SCSwitchState *)switchState forState:(UIControlState)state {
    [self setPropertyValue:switchState forName:@"offState" forState:state];
}

-(void)setTrackLayerImage:(UIImage*)trackLayerImage forState:(UIControlState)state {
    [self setPropertyValue:trackLayerImage forName:@"trackLayerImage" forState:state];
}

// background

-(void)setHighlightColor:(UIColor*)highlightColor forState:(UIControlState)state {
    [self setPropertyValue:highlightColor forName:@"highlightColor" forState:state];
}

// border
-(void)setBorder:(SCBorder*)border forState:(UIControlState)state {
    [self setPropertyValue:border forName:@"border" forState:state];
}

-(void)setInnerShadows:(NSArray*)innerShadows forState:(UIControlState)state {
    [self setPropertyValue:innerShadows forName:@"innerShadows" forState:state];
}

-(void)setOuterShadows:(NSArray*)outerShadows forState:(UIControlState)state {
    [self setPropertyValue:outerShadows forName:@"outerShadows" forState:state];
}

-(void)setBorderLayerImage:(UIImage*)borderLayerImage forState:(UIControlState)state {
    [self setPropertyValue:borderLayerImage forName:@"borderLayerImage" forState:state];
}

// knob
- (void)setKnobBorder:(SCBorder *)border forState:(UIControlState)state {
    [self setPropertyValue:border forName:@"knobBorder" forState:state];
}

-(void)setKnobBackgroundColor:(UIColor*)knobBackgroundColor forState:(UIControlState)state {
    [self setPropertyValue:knobBackgroundColor forName:@"knobBackgroundColor" forState:state];
}

-(void)setKnobHighlightColor:(UIColor*)knobHighlightColor forState:(UIControlState)state {
    [self setPropertyValue:knobHighlightColor forName:@"knobHighlightColor" forState:state];
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

-(void)setKnobImage:(UIImage*)knobImage forState:(UIControlState)state {
    [self setPropertyValue:knobImage forName:@"knobImage" forState:state];
}


@end