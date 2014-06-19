//
//  BYSearchBarRenderer.m
//  Beautify
//
//  Created by Chris Grant on 06/02/2014.
//  Copyright (c) 2014 Beautify. All rights reserved.
//

#import "BYSearchBarRenderer.h"
#import "BYControlRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYStyleRenderer_Private.h"
#import "BYSearchBarStyle.h"
#import "BYControlRenderingLayer.h"
#import "UIView+Utilities.h"
#import "BYTextFieldRenderer.h"

@interface BYSearchBarRenderer ()

@property BYControlRenderingLayer *backgroundLayer;
@property UITextField *searchTextField;
@property BYTextFieldRenderer *textFieldRenderer;

@end

@implementation BYSearchBarRenderer

-(id)initWithView:(id)view theme:(BYTheme*)theme{
    if(self = [super initWithView:view theme:theme]) {
        [self setup:view theme:theme];
    }
    return self;
}

-(void)setup:(UISearchBar*)searchBar theme:(BYTheme*)theme {
    [searchBar setBackgroundImage:[UIImage new]];
    
    Class searchClass = NSClassFromString(@"UISearchBarTextField");
    UITextField *tf = [self.adaptedView recursivelySearchSubviewsForViewOfType:searchClass];
    self.searchTextField = tf;
    
    self.textFieldRenderer = [[BYTextFieldRenderer alloc] initWithView:tf theme:theme];
    
    [self addRendererLayers];
    [self configureFromStyle];
}

-(void)configureFromStyle {
    [super configureFromStyle];
    [self.textFieldRenderer redraw];
    
    [self.textFieldRenderer setTitle:[self.style textFieldText] forState:UIControlStateNormal];
    
    [self.textFieldRenderer setBackgroundColor:[self.style textFieldBackgroundColor] forState:UIControlStateNormal];
    [self.textFieldRenderer setBackgroundGradient:[self.style textFieldBackgroundGradient] forState:UIControlStateNormal];
    [self.textFieldRenderer setBackgroundImage:[self.style textFieldBackgroundImage] forState:UIControlStateNormal];
    
    [self.textFieldRenderer setBorder:[self.style textFieldBorder] forState:UIControlStateNormal];
    
    [self.textFieldRenderer setInnerShadow:[self.style textFieldInnerShadow] forState:UIControlStateNormal];
    [self.textFieldRenderer setOuterShadow:[self.style textFieldOuterShadow] forState:UIControlStateNormal];
}

-(BYSearchBarStyle*)styleFromTheme:(BYTheme*)theme {
    if(theme.searchBarStyle) {
        return theme.searchBarStyle;
    }
    return [BYSearchBarStyle defaultStyle];
}

-(void)setTextFieldTitle:(BYText*)title
                forState:(UIControlState)state {
    [self setPropertyValue:title forName:@"textFieldTitle" forState:state];
}

-(void)setTextFieldBackgroundColor:(UIColor*)backgroundColor
                          forState:(UIControlState)state {
    [self setPropertyValue:backgroundColor forName:@"textFieldBackgroundColor" forState:state];
}

-(void)setTextFieldBackgroundGradient:(BYGradient*)backgroundGradient
                             forState:(UIControlState)state {
    [self setPropertyValue:backgroundGradient forName:@"textFieldBackgroundGradient" forState:state];
}

-(void)setTextFieldBackgroundImage:(BYBackgroundImage*)backgroundImage
                          forState:(UIControlState)state {
    [self setPropertyValue:backgroundImage forName:@"textFieldBackgroundImage" forState:state];
}

-(void)setTextFieldBorder:(BYBorder*)border
                 forState:(UIControlState)state {
    [self setPropertyValue:border forName:@"textFieldBorder" forState:state];
}

-(void)setTextFieldInnerShadow:(BYShadow*)innerShadow
                      forState:(UIControlState)state {
    [self setPropertyValue:innerShadow forName:@"textFieldInnerShadow" forState:UIControlStateNormal];
}

-(void)setTextFieldOuterShadow:(BYShadow*)outerShadow
                      forState:(UIControlState)state {
    [self setPropertyValue:outerShadow forName:@"textFieldOuterShadow" forState:state];
}

@end