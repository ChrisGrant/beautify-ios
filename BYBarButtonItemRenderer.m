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
    }
    else {
        self.style = _normalStyle;
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

@end