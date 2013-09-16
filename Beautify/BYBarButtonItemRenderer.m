//
//  BYBarButtonItemRenderer.m
//  Beautify
//
//  Created by Daniel Allsop on 06/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYBarButtonItemRenderer.h"
#import "UIView+Utilities.h"
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYLabelRenderer.h"
#import "BYTheme.h"
#import "BYControlRenderer_Private.h"

#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYSwitchRenderer.h"
#import "BYSwitchBorderLayer.h"
#import "BYRenderUtils.h"
#import "BYControlRenderingLayer.h"

#import "BYVersionUtils.h"

#import "BYBarButtonStyle.h"

@implementation BYBarButtonItemRenderer{
    BYLabelRenderer *_labelRenderer;
    BYControlRenderingLayer* _buttonStyleLayer;
    __weak UIBarButtonItem *_barButtonItem;
}

-(id)initWithView:(id)barButtonItem theme:(BYTheme*)theme {
    UIButton *button = (UIButton*)[barButtonItem valueForKey:@"view"];
    
    if(button) {
        if(self = [super initWithView:button theme:theme]) {
            // Hijack the button rendering
            [self setup:barButtonItem theme:theme];
        }
    }
    return self;
}

-(void)setup:(UIBarButtonItem*)barButtonItem theme:(BYTheme*)theme {
    
    _barButtonItem = barButtonItem;
    
    // Remove bezel from UIBarButtonItem
    [barButtonItem setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIButton *button = (UIButton*)[barButtonItem valueForKey:@"view"];
    
    if(button) {
        [self addNineBoxAndRendererLayers];
        _labelRenderer = [[BYLabelRenderer alloc] initWithView:button.titleLabel theme:theme];
        
        [button addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
        
        [self configureFromStyle];
    }
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

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.barButtonItemStyle) {
        return theme.barButtonItemStyle;
    }
    BYBarButtonStyle *barStyle =  [BYBarButtonStyle defaultStyle];
    barStyle.backgroundColor = _barButtonItem.tintColor;
    return barStyle;
}

#pragma mark - Style property setters

-(void)setTitleStyle:(BYText *)titleStyle forState:(UIControlState)state {
    [self storePropertyValue:titleStyle forName:@"title" forState:state];
}

-(void)setBackgroundColor:(UIColor*)backgroundColor forState:(UIControlState)state {
    [self storePropertyValue:backgroundColor forName:@"backgroundColor" forState:state];
}

-(void)setBackgroundGradient:(BYGradient*)backgroundGradient forState:(UIControlState)state {
    [self storePropertyValue:backgroundGradient forName:@"backgroundGradient" forState:state];
}

-(void)setBackgroundImage:(BYNineBoxedImage*)backgroundImage forState:(UIControlState)state {
    [self storePropertyValue:backgroundImage forName:@"backgroundImage" forState:state];
}

// border
-(void)setBorder:(BYBorder*)border forState:(UIControlState)state {
    [self storePropertyValue:border forName:@"border" forState:state];
}

-(void)setInnerShadows:(NSArray*)innerShadows forState:(UIControlState)state {
    [self storePropertyValue:innerShadows forName:@"innerShadows" forState:state];
}

-(void)setOuterShadows:(NSArray*)outerShadows forState:(UIControlState)state {
    [self storePropertyValue:outerShadows forName:@"outerShadows" forState:state];
}

// In cases where the adapted view is nil (and thus the properties will not have an immediate effect) the propeties are stored for use when they can be applied when the adaptedView isnt nil.
-(void)storePropertyValue:(id)value forName:(NSString*)name forState:(UIControlState)state {
    
    if(_values == nil){
        _values = [NSMutableArray new];
    }
    
    if(_names == nil){
        _names = [NSMutableArray new];
    }
    
    if(_controlStates == nil){
        _controlStates = [NSMutableArray new];
    }
    
    if([self adaptedView] != nil){
        [self setPropertyValue:value forName:name forState:state];
    }
    else{
        [_values addObject:value];
        [_names addObject:name];
        [_controlStates addObject:[NSNumber numberWithInteger:state]];
    }
}


// Applies the stored properties to the control
-(void)styleViaStoredValueNamesAndStates{
    for(int i = 0; i < [_values count]; ++i){
        [self setPropertyValue:_values[i] forName:_names[i] forState:[_controlStates[i] integerValue]];
    }
}

@end