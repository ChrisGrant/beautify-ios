//
//  BYBarButtonItemRenderer.m
//  Beautify
//
//  Created by Chris Grant on 27/09/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "BYBarButtonItemRenderer.h"
#import "BYControlRenderer_Private.h"
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYLabelRenderer.h"
#import "BYTheme.h"
#import "BYBarButtonStyle.h"
#import "BYControlRenderingLayer.h"

@implementation BYBarButtonItemRenderer {
    UILabel *_label;
    BYLabelRenderer *_labelRenderer;
    BOOL _isBackButtonRenderer;
    BYBarButtonStyle *_normalStyle;
    BYBarButtonStyle *_backStyle;
}

-(id)initWithView:(id)view theme:(BYTheme*)theme {
    if (self = [super initWithView:view theme:theme]) {
        [self addRendererLayers];
        
        UIView *v = view;
        for(UIView *subview in v.subviews) {
            if([subview isKindOfClass:[UILabel class]]) {
                _label = (UILabel*)subview;
            }
        }
        
        if(_label) {
            _labelRenderer = [[BYLabelRenderer alloc] initWithView:_label theme:theme];
        }
        
        [self configureFromStyle];
    }
    return self;
}

-(BYBarButtonStyle*)styleFromTheme:(BYTheme*)theme {
    // Store both the back button and the normal button style for future use.
    _normalStyle = theme.barButtonItemStyle;
    _backStyle = theme.backBarButtonItemStyle;
    
    if(self.isBackButtonRenderer) {
        return theme.backBarButtonItemStyle;
    }
    return theme.barButtonItemStyle;
}

-(void)setIsBackButtonRenderer:(BOOL)isBackButtonRenderer {
    _isBackButtonRenderer = isBackButtonRenderer;
    if(_isBackButtonRenderer) {
        self.style = _backStyle;
        self.controlLayer.customPath = [self generateBackButtonPath];
    }
    else {
        self.style = _normalStyle;
        self.controlLayer.customPath = nil;
    }
    [self setUpStyleCustomizersForControlStates];
    [self redraw];
}

-(BOOL)isBackButtonRenderer {
    return _isBackButtonRenderer;
}

-(void)configureFromStyle {
    if(self.adaptedView != nil){
        BYText *text = [self propertyValueForNameWithCurrentState:@"title"];
        BYTextShadow *textShadow = [self propertyValueForNameWithCurrentState:@"titleShadow"];
        
        // label alpha should always be 1 because the button alpha will affect label as well
        [_labelRenderer setAlpha:1 forState:UIControlStateNormal];
        
        // update the label renderer with button specific properties
        if (text) {
            [_labelRenderer setTextStyle:text forState:UIControlStateNormal];
        }
        [_labelRenderer setTextShadow:textShadow forState:UIControlStateNormal];
        [_labelRenderer redraw];
        
        [super configureFromStyle];
    }
}

// This is the amount that the back button's "<" protrudes out of the left of the button.
#define BACK_BUTTON_OFFSET 12

-(UIBezierPath*)generateBackButtonPath {
    BYBorder *border = [self propertyValueForName:@"border" forState:UIControlStateNormal];
    
    CGFloat height = ((UIView*)self.adaptedView).bounds.size.height;
    CGFloat width = ((UIView*)self.adaptedView).bounds.size.width;
    CGFloat radius = border.cornerRadius;
    
    CGFloat backOffset = MIN(BACK_BUTTON_OFFSET, MAX(0, width - radius));
    
    UIBezierPath *path = [UIBezierPath new];
    
    // We need a separate radius for the corners. The radius for these has to be limited to be half the height/width
    CGFloat cornerRadius = MIN(MIN(height / 2, width / 2), radius);
    
    // Calculate where to start. This is the first position on the x-axis when the y axis is 0. We need to ensure it
    // works when the frame is small, so check that the start is not bigger than the width - the corner radius we just
    // calculated above. If it is, set it to that.
    CGFloat start = MIN(backOffset + radius, width - cornerRadius);
    
    // Start at the top, inset from the left by the back indicator offset.
    [path moveToPoint:CGPointMake(start, 0)];
    
    // Move along to prepare to draw the top right corner.
    [path addLineToPoint:CGPointMake(width - cornerRadius, 0)];
    
    // Draw the top right corner
    [path addCurveToPoint:CGPointMake(width, cornerRadius)
            controlPoint1:CGPointMake(width, 0)
            controlPoint2:CGPointMake(width, cornerRadius)];
    
    // Move down to prepare to draw the bottom right corner.
    [path addLineToPoint:CGPointMake(width, height - cornerRadius)];
    
    // Draw the bottom right corner
    [path addCurveToPoint:CGPointMake(width - cornerRadius, height)
            controlPoint1:CGPointMake(width, height)
            controlPoint2:CGPointMake(width - cornerRadius, height)];
    
    // Now move back to the left and prepare to draw the "<" part of the shape.
    [path addLineToPoint:CGPointMake(start, height)];
    
    // Draw a curve to the center point of the "<" shape.
    [path addCurveToPoint:CGPointMake(0, height / 2)
            controlPoint1:CGPointMake(backOffset, height)
            controlPoint2:CGPointMake(0, height / 2)];
    
    // Draw a curve from the center point of the "<" shape to the start position.
    [path addCurveToPoint:CGPointMake(start, 0)
            controlPoint1:CGPointMake(backOffset, 0)
            controlPoint2:CGPointMake(start, 0)];
    
    // Ensure that we close the path.
    [path closePath];
    
    return path;
}

@end