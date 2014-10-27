//
//  BYSwitchGestureView.m
//  Beautify
//
//  Created by Chris Grant on 05/09/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYSwitchGestureView.h"
#import "UISwitch+Beautify.h"

@implementation BYSwitchGestureView

-(id)init {
    if(self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(statusBarFrameOrOrientationChanged:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(statusBarFrameOrOrientationChanged:)
                                                     name:UIApplicationDidChangeStatusBarFrameNotification
                                                   object:nil];
        [self statusBarFrameOrOrientationChanged:nil];
    }
    return self;
}

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    
    // Don't do anything if it's disabled or hidden.
    if(!_adaptedSwitch.enabled || !_adaptedSwitch.userInteractionEnabled || _adaptedSwitch.isHidden) {
        return nil;
    }
    
    // Check if the switch is on the screen
    UIView *v = _adaptedSwitch;
    BOOL inWindow = NO; // Is switch view in the window?
    while (v != nil) {
        if([v isKindOfClass:[UIWindow class]]) {
            inWindow = YES;
            break;
        }
        v = v.superview;
    }
    
    // If the switch isn't in the window, don't send the gesture.
    if(!inWindow) {
        return nil;
    }
    
    CGPoint windowOrigin = [_adaptedSwitch convertPoint:CGPointZero toView:self];
    if(!CGPointEqualToPoint(CGPointZero, windowOrigin)) {
        CGSize size = _adaptedSwitch.desiredSwitchSize;
        CGRect f = CGRectMake(windowOrigin.x, windowOrigin.y, size.width, size.height);
        if(CGRectContainsPoint(f, point)) {
            return self;
        }
    }
    return nil;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 This notification is most likely triggered inside an animation block,
 therefore no animation is needed to perform this nice transition.
 */
-(void)statusBarFrameOrOrientationChanged:(NSNotification *)notification {
    [self rotateAccordingToStatusBarOrientationAndSupportedOrientations];
}

-(void)rotateAccordingToStatusBarOrientationAndSupportedOrientations {
    UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat angle = UIInterfaceOrientationAngleOfOrientation(statusBarOrientation);
    CGFloat statusBarHeight = [[self class] getStatusBarHeight];
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    CGRect frame = [[self class] rectInWindowBounds:self.window.bounds statusBarOrientation:statusBarOrientation statusBarHeight:statusBarHeight];
    [self setIfNotEqualTransform:transform frame:frame];
}

-(void)setIfNotEqualTransform:(CGAffineTransform)transform frame:(CGRect)frame {
    if(!CGAffineTransformEqualToTransform(self.transform, transform)) {
        self.transform = transform;
    }
}

+(CGFloat)getStatusBarHeight{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if(UIInterfaceOrientationIsLandscape(orientation)) {
        return [UIApplication sharedApplication].statusBarFrame.size.width;
    }
    else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}

+(CGRect)rectInWindowBounds:(CGRect)windowBounds statusBarOrientation:(UIInterfaceOrientation)statusBarOrientation statusBarHeight:(CGFloat)statusBarHeight {
    CGRect frame = windowBounds;
    frame.origin.x += statusBarOrientation == UIInterfaceOrientationLandscapeLeft ? statusBarHeight : 0;
    frame.origin.y += statusBarOrientation == UIInterfaceOrientationPortrait ? statusBarHeight : 0;
    frame.size.width -= UIInterfaceOrientationIsLandscape(statusBarOrientation) ? statusBarHeight : 0;
    frame.size.height -= UIInterfaceOrientationIsPortrait(statusBarOrientation) ? statusBarHeight : 0;
    return frame;
}

CGFloat UIInterfaceOrientationAngleOfOrientation(UIInterfaceOrientation orientation) {
    CGFloat angle;
    
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            angle = -M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle = M_PI_2;
            break;
        default:
            angle = 0.0;
            break;
    }
    return angle;
}

UIInterfaceOrientationMask UIInterfaceOrientationMaskFromOrientation(UIInterfaceOrientation orientation) {
    return 1 << orientation;
}

@end