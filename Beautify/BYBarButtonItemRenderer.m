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
#import "BYRenderUtils.h"

@implementation BYBarButtonItemRenderer {
    UILabel *_label;
    BYLabelRenderer *_labelRenderer;
    BOOL _isBackButtonRenderer;
    BYBarButtonStyle *_normalStyle;
    BYBarButtonStyle *_backStyle;
}

-(instancetype)initWithView:(id)view theme:(BYTheme*)theme {
    if (self = [super initWithView:view theme:theme]) {
        [self addRendererLayers];
        
        [self setIsBackButtonRenderer:YES];

        UIView *v = view;
        for(UIView *subview in v.subviews) {
            if([subview isKindOfClass:[UILabel class]]) {
                _label = (UILabel*)subview;
            }
        }
        
        if(_label) {
            _labelRenderer = [[BYLabelRenderer alloc] initWithView:_label theme:theme];
            [_labelRenderer setIgnoreThemeUpdates:YES];
        }
        
        [self configureFromStyle];
    }
    return self;
}

-(BYBarButtonStyle*)styleFromTheme:(BYTheme*)theme {
    // Store both the back button and the normal button style for future use.
    _normalStyle = theme.barButtonItemStyle;
    _backStyle = theme.backButtonItemStyle;
    
    if(self.isBackButtonRenderer) {
        return _backStyle;
    }
    return _normalStyle;
}

-(void)setIsBackButtonRenderer:(BOOL)isBackButtonRenderer {
    _isBackButtonRenderer = isBackButtonRenderer;
    if(_isBackButtonRenderer) {
        self.style = _backStyle;
        self.controlLayer.customPath = [self backButtonPath];
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

-(UIBezierPath*)backButtonPath {
    BYBorder *border = [self propertyValueForNameWithCurrentState:@"border"];
    BYShadow *shadow = [self propertyValueForNameWithCurrentState:@"outerShadow"];
    
    UIEdgeInsets insets = ComputeExpandingInsetsForShadowAndBorder(shadow, nil, YES);
    
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
    
    CGFloat xOffset = -insets.left;
    CGFloat yOffset = -insets.top;
    
    // Start at the top, inset from the left by the back indicator offset.
    [path moveToPoint:CGPointMake(xOffset + start, yOffset)];
    
    // Move along to prepare to draw the top right corner.
    [path addLineToPoint:CGPointMake(xOffset + width - cornerRadius, yOffset)];
    
    // Draw the top right corner
    [path addCurveToPoint:CGPointMake(xOffset + width, yOffset + cornerRadius)
            controlPoint1:CGPointMake(xOffset + width, yOffset)
            controlPoint2:CGPointMake(xOffset + width, yOffset + cornerRadius)];
    
    // Move down to prepare to draw the bottom right corner.
    [path addLineToPoint:CGPointMake(xOffset + width, yOffset + height - cornerRadius)];
    
    // Draw the bottom right corner
    [path addCurveToPoint:CGPointMake(xOffset + width - cornerRadius, yOffset + height)
            controlPoint1:CGPointMake(xOffset + width, yOffset + height)
            controlPoint2:CGPointMake(xOffset + width - cornerRadius, yOffset + height)];
    
    // Now move back to the left and prepare to draw the "<" part of the shape.
    [path addLineToPoint:CGPointMake(xOffset + start, yOffset + height)];
    
    // Draw a curve to the center point of the "<" shape.
    [path addCurveToPoint:CGPointMake(xOffset, yOffset + (height / 2))
            controlPoint1:CGPointMake(xOffset + backOffset, yOffset + height)
            controlPoint2:CGPointMake(xOffset, yOffset + (height / 2))];
    
    // Draw a curve from the center point of the "<" shape to the start position.
    [path addCurveToPoint:CGPointMake(xOffset + start, yOffset)
            controlPoint1:CGPointMake(xOffset + backOffset, yOffset)
            controlPoint2:CGPointMake(xOffset + start, yOffset)];
    
    // Ensure that we close the path.
    [path closePath];
    
    return path;
}

@end