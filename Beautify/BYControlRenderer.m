//
//  BYControlRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYControlRenderer.h"
#import "BYControlRenderingLayer.h"
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYBackgroundImage.h"
#import "BYControlRenderer_Private.h"
#import "BYShadow.h"

@implementation BYControlRenderer

-(void)addRendererLayers {
    [self addRendererLayers:(UIView*)self.adaptedView];
}

-(void)addRendererLayers:(UIView*)view {
    // The control layer that renders the background and border
    _controlLayer = [[BYControlRenderingLayer alloc] initWithRenderer:self];
    [_controlLayer setFrame:view.bounds];
    [view.layer insertSublayer:_controlLayer atIndex:0];
}

-(void)configureFromStyle {
    UIView *adaptedView = (UIView*)self.adaptedView;
    _controlLayer.hidden = NO;
    [_controlLayer setFrame:adaptedView.bounds];
    [_controlLayer setNeedsDisplay];
}

// override if a UI element supports more than UIControlStateNormal
-(UIControlState)currentControlState {
    return self.highlighted ? UIControlStateHighlighted : UIControlStateNormal;
}

-(void)setBackgroundColor:(UIColor*)backgroundColor forState:(UIControlState)state {
    [self setPropertyValue:backgroundColor forName:@"backgroundColor" forState:state];
}

-(void)setBackgroundGradient:(BYGradient*)backgroundGradient forState:(UIControlState)state {
    [self setPropertyValue:backgroundGradient forName:@"backgroundGradient" forState:state];
}

-(void)setBackgroundImage:(BYBackgroundImage*)backgroundImage forState:(UIControlState)state {
    [self setPropertyValue:backgroundImage forName:@"backgroundImage" forState:state];
}

// border
-(void)setBorder:(BYBorder*)border forState:(UIControlState)state {
    [self setPropertyValue:border forName:@"border" forState:state];
}

-(void)setInnerShadow:(BYShadow*)innerShadow forState:(UIControlState)state {
    [self setPropertyValue:innerShadow forName:@"innerShadow" forState:state];
}

-(void)setOuterShadow:(BYShadow*)outerShadow forState:(UIControlState)state {
    [self setPropertyValue:outerShadow forName:@"outerShadow" forState:state];
}

@end