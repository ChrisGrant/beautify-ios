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
#import "UIView+Utilities.h"

@implementation BYBarButtonItemRenderer {
    UILabel *_label;
    BYLabelRenderer *_labelRenderer;
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
    BYBarButtonStyle *barStyle = theme.barButtonItemStyle;
    return barStyle;
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