//
//  BYLabelRenderer.m
//  Beautify
//
//  Created by Adrian Conlin on 30/04/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIView+Utilities.h"
#import "UIColor+HexColors.h"
#import "BYLabelRenderer.h"
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYTheme.h"
#import "BYLabelStyle.h"
#import "BYFont.h"
#import "BYShadow.h"
#import "BYFont_Private.h"
#import "BYTextShadow.h"

@implementation BYLabelRenderer

-(instancetype)initWithView:(id)view theme:(BYTheme*)theme {
    if (self = [super initWithView:view theme:theme]) {
        // Hijack the label rendering
        [self setup:(UILabel*)view];
    }
    return self;
}

-(void)setup:(UILabel*)label {
    [self configureFromStyle];
}

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.labelStyle) {
        return theme.labelStyle;
    }
    return [BYLabelStyle defaultStyle];
}

-(void)configureFromStyle {
    BYText *textStyle = [self propertyValueForNameWithCurrentState:@"title"];
    BYTextShadow *textShadow = [self propertyValueForNameWithCurrentState:@"titleShadow"];
    
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

-(void)setTheme:(BYTheme*)theme {
    if(!self.ignoreThemeUpdates) {
        [super setTheme:theme];
    }
}

#pragma mark - Style property customization

-(void)setTextStyle:(BYText*)textStyle forState:(UIControlState)state {
    [self setPropertyValue:textStyle forName:@"title" forState:state];
}

-(void)setTextShadow:(BYTextShadow*)textShadow forState:(UIControlState)state {
   [self setPropertyValue:textShadow forName:@"titleShadow" forState:state];
}

@end