//
//  LabelRenderer.m
//  Beautify
//
//  Created by Adrian Conlin on 30/04/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIView+Utilities.h"
#import "UIColor+HexColors.h"
#import "SCLabelRenderer.h"
#import "SCStyleRenderer_Private.h"
#import "SCViewRenderer_Private.h"
#import "SCTheme.h"
#import "SCLabelStyle.h"
#import "SCFont.h"
#import "SCShadow.h"
#import "SCFont_Private.h"
#import "SCTextShadow.h"

@implementation SCLabelRenderer

-(id)initWithView:(id)view theme:(SCTheme*)theme {
    if (self = [super initWithView:view theme:theme]) {
        // Hijack the label rendering
        [self setup:(UILabel*)view];
    }
    return self;
}

-(void)setup:(UILabel*)label {
    [self configureFromStyle];
}

-(id)styleFromTheme:(SCTheme*)theme {
    if(theme.labelStyle) {
        return theme.labelStyle;
    }
    return [SCLabelStyle defaultStyle];
}

-(void)configureFromStyle {
    SCText *textStyle = [self propertyValueForNameWithCurrentState:@"title"];
    SCTextShadow *textShadow = [self propertyValueForNameWithCurrentState:@"titleShadow"];
    
    UILabel *label = [self adaptedView];
    
    // store the previous font value, so that we do not loose the size that the developer specified.
    if (label.previousFont == nil) {
        label.previousFont = label.font;
    }
    
    label.textColor = textStyle.color;
    label.font = [textStyle.font createFont:label.previousFont];
    label.shadowColor = textShadow.color;
    label.shadowOffset = textShadow.offset;
    
    [super configureFromStyle];
}

#pragma mark - Style property customization

-(void)setTextStyle:(SCText*)textStyle forState:(UIControlState)state {
    [self setPropertyValue:textStyle forName:@"title" forState:state];
}

-(void)setTextShadow:(SCTextShadow*)textShadow forState:(UIControlState)state {
   [self setPropertyValue:textShadow forName:@"titleShadow" forState:state];
}

@end