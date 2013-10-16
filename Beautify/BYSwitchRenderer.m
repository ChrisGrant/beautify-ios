//
//  SwitchRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIView+Utilities.h"
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYSwitchRenderer.h"
#import "BYSwitchBorderLayer.h"
#import "BYThumbLayer.h"
#import "BYSwitchToggleLayer.h"
#import "BYRenderUtils.h"
#import "BYSwitchShadowLayer.h"
#import "BYTheme.h"
#import "BYControlRenderingLayer.h"
#import "UISwitch+Beautify.h"
#import "BYSwitchGestureView.h"
#import "BYSwitchBorderLayer.h"
#import "BYVersionUtils.h"

@implementation BYSwitchRenderer {
    CAShapeLayer* _clipLayerShape;
    CALayer* _clipLayer;
    BYThumbLayer* _thumbLayer;
    BYSwitchBorderLayer* _borderLayer;
    BYSwitchShadowLayer* _shadowLayer;
    BYSwitchToggleLayer* _toggleLayer;
    
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
    
    BYSwitchGestureView *_gestureView;
}

-(id)initWithView:(id)view theme:(BYTheme*)theme {
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
    
    // create the thumb layer
    _thumbLayer = [[BYThumbLayer alloc] initWithRenderer:self];
    _thumbLayer.masksToBounds = NO;
    _thumbLayer.frame = [self thumbFrame];
    [_thumbLayer setNeedsDisplay];
    
    // create the border layer
    _borderLayer = [[BYSwitchBorderLayer alloc] initWithRenderer:self];
    _borderLayer.frame = bounds;
    [_borderLayer setNeedsDisplay];
       
    // create the toggle layer
    _toggleLayer = [[BYSwitchToggleLayer alloc] initWithRenderer:self];
    // the frame is computed based on the current toggle state
    _toggleLayer.frame = [self toggleLayerFrame];
    [_toggleLayer setNeedsDisplay];
    
    // create the shadow layer
    _shadowLayer = [[BYSwitchShadowLayer alloc] initWithRenderer:self];
    // the shadow occupies the entire
    [_shadowLayer setFrame:swtch.bounds];
    _shadowLayer.masksToBounds = NO;
    [_shadowLayer setNeedsDisplay];
    
    // create a layer clipped to the border path of the switch
    _clipLayerShape = [CAShapeLayer layer];
    _clipLayerShape.path = [BYSwitchBorderLayer borderPathForBounds:_borderLayer.bounds andBorder:[self propertyValueForNameWithCurrentState:@"border"]].CGPath;
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
    
    // add the thumb layer
    [swtch.layer addSublayer:_thumbLayer];
    
    // Put a view on top for the gestures - otherwise it will be the wrong size!
    _gestureView = [BYSwitchGestureView new];
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
    _thumbLayer.frame = [self thumbFrame];
    _toggleLayer.frame = [self toggleLayerFrame];
}

-(CGRect)thumbFrame {
    CGRect bounds = [self adaptedBounds];
    float xOrigin = bounds.origin.x + bounds.size.height / 2;
    float yOrigin = bounds.origin.y + bounds.size.height / 2;
    float halfWidth = bounds.size.height / 2;
    
    // compute the centre point of the thumb
    CGPoint thumbCentrePoint = CGPointMake(xOrigin, yOrigin);
    
    // adjust for whether the switch is currently on or off
    thumbCentrePoint.x += ([self adaptedSwitch].isOn) ? _toggleOffset : 0;
    
    if (_panning) {
        // offset based on current panning state
        thumbCentrePoint.x += _panLocation.x;
        
        // limit the x range
        if (thumbCentrePoint.x + halfWidth > bounds.size.width) {
            thumbCentrePoint.x = xOrigin + _toggleOffset;
        }
        else if (thumbCentrePoint.x - halfWidth < 0) {
            thumbCentrePoint.x = xOrigin;
        }
    }
    
    CGRect thumbFrame = CGRectMake(thumbCentrePoint.x - halfWidth, thumbCentrePoint.y - halfWidth,
                                   bounds.size.height, bounds.size.height);
    
    NSNumber *inset = [self propertyValueForNameWithCurrentState:@"thumbInset"];
    
    // compute the overall frame
    return CGRectInset(thumbFrame, inset.floatValue, inset.floatValue);
}

-(CGRect)toggleLayerFrame {
    CGRect bounds = [self adaptedBounds];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        return bounds;
    }
    
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
    _thumbLayer.frame = [self thumbFrame];
    
    // border radius affects the clip of the toggle layer
    _clipLayerShape.path = [BYSwitchBorderLayer borderPathForBounds:_borderLayer.bounds andBorder:[self propertyValueForNameWithCurrentState:@"border"]].CGPath;
    
    [_clipLayerShape setNeedsDisplay];
    [_clipLayer setNeedsDisplay];
    [_borderLayer setNeedsDisplay];
    [_shadowLayer setNeedsDisplay];
    [_toggleLayer setNeedsDisplay];
    [_thumbLayer setNeedsDisplay];
    
    [super configureFromStyle];
    
    [CATransaction commit];
}

-(void)checkGestureViewSetup {
    if(_gestureView.superview == nil) {
        [[self adaptedSwitch].window addSubview:_gestureView];
    }
}

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.switchStyle) {
        return theme.switchStyle;
    }
    return [BYSwitchStyle defaultStyle];
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
    [self redraw];
}

-(void)swiped:(UISwipeGestureRecognizer*)gesture {
    [[self adaptedSwitch] setOn:![self adaptedSwitch].isOn];
    [[self adaptedSwitch] sendActionsForControlEvents:UIControlEventValueChanged];
    [self updateLayerLocations];
    [self redraw];
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
-(void)setOnState:(BYSwitchState *)switchState forState:(UIControlState)state {
    [self setPropertyValue:switchState forName:@"onState" forState:state];
}

-(void)setOffState:(BYSwitchState *)switchState forState:(UIControlState)state {
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
-(void)setBorder:(BYBorder*)border forState:(UIControlState)state {
    [self setPropertyValue:border forName:@"border" forState:state];
}

-(void)setInnerShadow:(BYShadow*)innerShadow forState:(UIControlState)state {
    [self setPropertyValue:innerShadow forName:@"innerShadow" forState:state];
}

-(void)setouterShadow:(BYShadow*)outerShadow forState:(UIControlState)state {
    [self setPropertyValue:outerShadow forName:@"outerShadow" forState:state];
}

-(void)setBorderLayerImage:(UIImage*)borderLayerImage forState:(UIControlState)state {
    [self setPropertyValue:borderLayerImage forName:@"borderLayerImage" forState:state];
}

// thumb
- (void)setThumbBorder:(BYBorder *)border forState:(UIControlState)state {
    [self setPropertyValue:border forName:@"thumbBorder" forState:state];
}

-(void)setThumbBackgroundColor:(UIColor*)thumbBackgroundColor forState:(UIControlState)state {
    [self setPropertyValue:thumbBackgroundColor forName:@"thumbBackgroundColor" forState:state];
}

-(void)setThumbHighlightColor:(UIColor*)thumbHighlightColor forState:(UIControlState)state {
    [self setPropertyValue:thumbHighlightColor forName:@"thumbHighlightColor" forState:state];
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

-(void)setThumbouterShadow:(BYShadow*)thumbOuterShadow forState:(UIControlState)state {
    [self setPropertyValue:thumbOuterShadow forName:@"thumbOuterShadow" forState:state];
}

-(void)setThumbImage:(UIImage*)thumbImage forState:(UIControlState)state {
    [self setPropertyValue:thumbImage forName:@"thumbImage" forState:state];
}


@end