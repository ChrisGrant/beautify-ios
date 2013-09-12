//
//  ButtonRenderer.m
//  Beautify
//
//  Created by Chris Grant on 20/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCButtonRenderer.h"
#import "UIView+Utilities.h"
#import "SCStyleRenderer_Private.h"
#import "SCViewRenderer_Private.h"
#import "SCLabelRenderer.h"
#import "SCTheme.h"
#import "SCControlRenderer_Private.h"
#import "SCButtonStyle.h"
#import "SCFont.h"

@implementation SCButtonRenderer {
    SCLabelRenderer *_labelRenderer;
}

-(id)initWithView:(id)view theme:(SCTheme*)theme {
    UIButton *button = (UIButton*)view;
    // Only create a renderer if the button is custom!
    if(button.buttonType != UIButtonTypeCustom) {
        return nil;
    }
    
    if(self = [super initWithView:view theme:theme]) {
        // Hijack the button rendering
        [self setup:button theme:theme];
    }
    return self;
}

-(void)setup:(UIButton*)button theme:(SCTheme*)theme {
    if(button.buttonType == UIButtonTypeCustom) {
        [button hideAllSubViews];
        
        _labelRenderer = [[SCLabelRenderer alloc] initWithView:button.titleLabel theme:theme];
        [self addNineBoxAndRendererLayers];
        [self configureFromStyle];
    }
    
    [button addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
}

-(void)touchDown {
    self.highlighted = YES;
    [self redraw];
}

-(void)touchUp {
    self.highlighted = NO;
    [self redraw];
}

-(void)configureFromStyle {
    SCText *text = [self propertyValueForNameWithCurrentState:@"title"];
    SCTextShadow *textShadow = [self propertyValueForNameWithCurrentState:@"titleShadow"];

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

-(id)styleFromTheme:(SCTheme*)theme {
    UIButton *button = (UIButton*)self.adaptedView;

    if(button.buttonType == UIButtonTypeCustom) {
        if(theme.buttonStyle) {
            return theme.buttonStyle;
        }
        return [SCButtonStyle defaultStyle];
    }
    
    NSLog(@"Could not find an appropriate style for this type of button!");
    return nil;
}

#pragma mark - Style property setters

-(void)setTitleStyle:(SCText *)titleStyle forState:(UIControlState)state {
    [self setPropertyValue:titleStyle forName:@"title" forState:state];
}

-(void)setTitleShadowStyle:(SCTextShadow *)titleShadowStyle forState:(UIControlState)state {
    [self setPropertyValue:titleShadowStyle forName:@"titleShadow" forState:state];
}

@end