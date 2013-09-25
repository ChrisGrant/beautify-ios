//
//  BYBarButtonItemRenderer.m
//  Beautify
//
//  Created by Daniel Allsop on 06/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYBarButtonItemRenderer_Private.h"
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
#import "BYThemeManager.h"

#define BACK_BUTTON_ARROW_BASE_START_POSITION 12.0
#define BACK_BUTTON_CORNER_PADDING 5.0

@implementation BYBarButtonItemRenderer{
    BYLabelRenderer *_labelRenderer;
    BYControlRenderingLayer* _buttonStyleLayer;
    __weak UIBarButtonItem *_barButtonItem;
}

-(id)initWithView:(id)barButtonItem theme:(BYTheme*)theme {
    UIButton *button = (UIButton*)[barButtonItem valueForKey:@"view"];
    if(self = [super initWithView:button theme:theme]) {
        // Hijack the button rendering
        [self setup:barButtonItem theme:theme];
    }
    return self;
}

-(void)setup:(UIBarButtonItem*)barButtonItem theme:(BYTheme*)theme {
    _barButtonItem = barButtonItem;
    
    // Remove bezel from UIBarButtonItem
    [barButtonItem setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIButton *button = (UIButton*)[barButtonItem valueForKey:@"view"];
    
    if(button) {
        [self addRendererLayers];
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

-(void)applyBackButtonStyleForState:(UIControlState)state {
    BYText *textStyle = [self propertyValueForName:@"title" forState:state];;
    BYTextShadow* textShadow = [self propertyValueForName:@"titleShadow" forState:state];
    BYGradient *gradient = [self propertyValueForName:@"backgroundGradient" forState:state];
    BYBackgroundImage *backgroundImage = [self propertyValueForName:@"backgroundImage" forState:state];
    BYBorder *border = [self propertyValueForName:@"border" forState:state];
    NSArray *innerShadows = [self propertyValueForName:@"innerShadows" forState:state];
    NSArray *outerShadows = [self propertyValueForName:@"outerShadows" forState:state];
    
    // background image or shaodows, gradiant and border
    CGSize newSize = CGSizeMake(48, 31);
    UIImage *newImage;
    
    if(backgroundImage) {
        UIGraphicsBeginImageContext(newSize);
        [backgroundImage.image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else {
        CGRect rect = CGRectMake(0, 0, newSize.width, newSize.height);
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
        
        // draw back button shaped bezier path
        UIBezierPath *aPath = [UIBezierPath bezierPath];
        [aPath moveToPoint:CGPointMake(BACK_BUTTON_ARROW_BASE_START_POSITION, 0.0)];
        [aPath addArcWithCenter:CGPointMake((newSize.width - BACK_BUTTON_CORNER_PADDING), BACK_BUTTON_CORNER_PADDING)
                         radius:border.cornerRadius startAngle:((3 * M_PI) / 2) endAngle:0 clockwise:YES];
        [aPath addArcWithCenter:CGPointMake((newSize.width - BACK_BUTTON_CORNER_PADDING), (newSize.height - BACK_BUTTON_CORNER_PADDING))
                         radius:border.cornerRadius startAngle:0 endAngle:(M_PI / 2) clockwise:YES];
        [aPath addLineToPoint:CGPointMake(BACK_BUTTON_ARROW_BASE_START_POSITION, newSize.height)];
        [aPath addLineToPoint:CGPointMake(1.0, (newSize.height / 2))];
        [aPath closePath];
        [border.color setStroke];
        [aPath setLineWidth:border.width];
        [aPath stroke];
        [aPath addClip];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // render outer shadows
        RenderOuterShadows(context, border, outerShadows, rect);
        
        // render gradient
        RenderGradient(gradient, context, rect);
        
        // Render Inner Shadows
        for (BYShadow *shadow in innerShadows) {
            // Create a larger rectangle, which we're going to subtract the visible path from and apply a shadow
            CGMutablePathRef path = CGPathCreateMutable();
            
            //(when drawing the shadow for a path whichs bounding box is not known pass "CGPathGetPathBoundingBox(visiblePath)" instead of "bounds" in the following line:)
            //-42 cuould just be any offset > 0
            CGPathAddRect(path, NULL, CGRectInset(aPath.bounds, -42, -42));
            
            // Add the visible path (so that it gets subtracted for the shadow)
            CGPathAddPath(path, NULL, aPath.CGPath);
            CGPathCloseSubpath(path);
            
            // Add the visible paths as the clipping path to the context
            CGContextAddPath(context, aPath.CGPath);
            CGContextClip(context);
            
            // Now setup the shadow properties on the context
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, shadow.offset, shadow.radius, [shadow.color CGColor]);
            
            // Now fill the rectangle, so the shadow gets drawn
            [shadow.color setFill];
            CGContextSaveGState(context);
            CGContextAddPath(context, path);
            CGContextEOFillPath(context);
        }
        
        // render border
        CGContextAddPath(context, aPath.CGPath);
        CGContextSetStrokeColorWithColor(context, border.color.CGColor);
        CGContextSetLineWidth(context, border.width);
        CGContextStrokePath(context);
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        CGColorSpaceRelease(colorspace);
    }
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:newImage forState:state barMetrics:UIBarMetricsDefault];
    
    // Set the text attributes
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    if(textStyle.font) {
        [dictionary setObject:[UIFont fontWithName:textStyle.font.name size:textStyle.font.size] forKey:UITextAttributeFont];
    }
    
    if(textStyle.color) {
        [dictionary setObject:textStyle.color forKey:UITextAttributeTextColor];
    }
    
    if(textShadow.color) {
        [dictionary setObject:textShadow.color forKey:UITextAttributeTextShadowColor];
    }
    
    [dictionary setObject:[NSValue valueWithUIOffset: UIOffsetMake(textShadow.offset.width, textShadow.offset.height)]
                   forKey:UITextAttributeTextShadowOffset];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:dictionary forState:state];
}

-(void)applyBackButtonStyles {
    [self applyBackButtonStyleForState:UIControlStateNormal];
    [self applyBackButtonStyleForState:UIControlStateHighlighted];
}

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.barButtonItemStyle) {
        return theme.barButtonItemStyle;
    }
    BYBarButtonStyle *barStyle =  [BYBarButtonStyle defaultCustomStyle];
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

-(void)setBackgroundImage:(BYBackgroundImage*)backgroundImage forState:(UIControlState)state {
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