//
//  SCBarButtonItemRenderer.m
//  Beautify
//
//  Created by Daniel Allsop on 06/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCBarButtonItemRenderer.h"
#import "UIView+Utilities.h"
#import "SCStyleRenderer_Private.h"
#import "SCViewRenderer_Private.h"
#import "SCLabelRenderer.h"
#import "SCTheme.h"
#import "SCControlRenderer_Private.h"

#import "SCStyleRenderer_Private.h"
#import "SCViewRenderer_Private.h"
#import "SCSwitchRenderer.h"
#import "SCSwitchBorderLayer.h"
#import "SCRenderUtils.h"
#import "SCControlRenderingLayer.h"

#import "SCVersionUtils.h"

#import "SCBarButtonStyle.h"

@implementation SCBarButtonItemRenderer{
    SCLabelRenderer *_labelRenderer;
    SCControlRenderingLayer* _buttonStyleLayer;
    __weak UIBarButtonItem *_barButtonItem;
}

-(id)initWithView:(id)barButtonItem theme:(SCTheme*)theme {
    UIButton *button = (UIButton*)[barButtonItem valueForKey:@"view"];
    
    if(button) {
        if(self = [super initWithView:button theme:theme]) {
            // Hijack the button rendering
            [self setup:barButtonItem theme:theme];
        }
    }
    return self;
}

-(void)setup:(UIBarButtonItem*)barButtonItem theme:(SCTheme*)theme {
    
    _barButtonItem = barButtonItem;
    
    // Remove bezel from UIBarButtonItem
    [barButtonItem setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIButton *button = (UIButton*)[barButtonItem valueForKey:@"view"];
    
    if(button) {
        [self addNineBoxAndRendererLayers];
        _labelRenderer = [[SCLabelRenderer alloc] initWithView:button.titleLabel theme:theme];
        
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
}

-(id)styleFromTheme:(SCTheme*)theme {
    if(theme.barButtonItemStyle) {
        return theme.barButtonItemStyle;
    }
    SCBarButtonStyle *barStyle =  [SCBarButtonStyle defaultStyle];
    barStyle.backgroundColor = _barButtonItem.tintColor;
    return barStyle;
}

#pragma mark - Style property setters

-(void)setTitleStyle:(SCText *)titleStyle forState:(UIControlState)state {
    [self storePropertyValue:titleStyle forName:@"title" forState:state];
}

-(void)setBackgroundColor:(UIColor*)backgroundColor forState:(UIControlState)state {
    [self storePropertyValue:backgroundColor forName:@"backgroundColor" forState:state];
}

-(void)setBackgroundGradient:(SCGradient*)backgroundGradient forState:(UIControlState)state {
    [self storePropertyValue:backgroundGradient forName:@"backgroundGradient" forState:state];
}

-(void)setBackgroundImage:(SCNineBoxedImage*)backgroundImage forState:(UIControlState)state {
    [self storePropertyValue:backgroundImage forName:@"backgroundImage" forState:state];
}

// border
-(void)setBorder:(SCBorder*)border forState:(UIControlState)state {
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