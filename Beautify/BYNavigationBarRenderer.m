//
//  BYNavigationBarRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYNavigationBarRenderer.h"
#import "BYViewRenderer_Private.h"
#import "BYStyleRenderer_Private.h"
#import "BYTheme.h"
#import "BYNavigationBarStyle.h"
#import "BYTextShadow.h"
#import "BYFont_Private.h"
#import "BYControlRenderingLayer.h"
#import "UINavigationBar+Beautify.h"
#import "UIView+Beautify.h"
#import "BYLabelRenderer.h"

@interface BYNavigationBarRenderer ()
@property BYNavigationBarStyle *style; // Strongly type the style.
@end

@implementation BYNavigationBarRenderer {
    BYControlRenderingLayer *_backgroundLayer;
    UIView *_navBarBackground;
}

-(id)initWithView:(id)view theme:(BYTheme*)theme{
    if(self = [super initWithView:view theme:theme]) {
        UINavigationBar *navBar = (UINavigationBar*)view;
        [self setup:navBar theme:theme];
    }
    return self;
}

-(void)setup:(UINavigationBar*)navBar theme:(BYTheme*)theme {
    for(UIView *view in navBar.subviews) {
        if([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            _navBarBackground = view;
            break;
        }
    }
    if(!_navBarBackground) {
        return NSLog(@"Can't style nav bar! Could not find it's background view!");
    }
    
    _backgroundLayer = [[BYControlRenderingLayer alloc] initWithRenderer:self];
    [_backgroundLayer setFrame:_navBarBackground.bounds];
    [_navBarBackground.layer addSublayer:_backgroundLayer];
    
    [self configureFromStyle];
}

-(void)configureFromStyle {
    BYNavigationBarStyle *style = self.style;
    if(style) {
        UINavigationBar *navBar = self.adaptedView;
        if([navBar respondsToSelector:@selector(setBarTintColor:)]) {
            navBar.barTintColor = style.tintColor;
        }
        
        NSMutableDictionary *attributeDictionary = [NSMutableDictionary new];
        UIFont *currentFont = navBar.titleTextAttributes[NSFontAttributeName];
        UIFont *styledFont = [style.title.font createFont:currentFont];
        
        if(styledFont) {
            attributeDictionary[NSFontAttributeName] = styledFont;
        }
        
        if(style.title.color) {
            attributeDictionary[NSForegroundColorAttributeName] = style.title.color;
        }
        
        if (style.titleShadow) {
            NSShadow *shadow = [[NSShadow alloc] init];
            shadow.shadowOffset = style.titleShadow.offset;
            shadow.shadowColor = style.titleShadow.color;
            attributeDictionary[NSShadowAttributeName] = shadow;
        }
        
        navBar.titleTextAttributes = attributeDictionary;
        
        if((_navBarBackground) && ([style dropShadow])){
            [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            navBar.shadowImage = [self makeImageWithDropShadow:[style dropShadow]];
        }
        
        for (UIView *v in navBar.subviews) {
            if([v class] == NSClassFromString(@"UINavigationItemView")) {
                for(UIView *label in v.subviews) {
                    if([label isKindOfClass:[UILabel class]]) {
                        [[label renderer] setTextStyle:style.title forState:UIControlStateNormal];
                        [[label renderer] setTextShadow:style.titleShadow forState:UIControlStateNormal];
                    }
                }
            }
        }
    }
    
    [_backgroundLayer setFrame:_navBarBackground.bounds];
    [_backgroundLayer setNeedsDisplay];

    [super configureFromStyle];
}

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.navigationBarStyle) {
        return theme.navigationBarStyle;
    }
    return [BYNavigationBarStyle defaultStyle];
}

-(UIImage*)makeImageWithDropShadow:(BYDropShadow*)dropShadow{
    CALayer *myLayer = [CALayer layer];
    myLayer.bounds = CGRectMake(0, 0, ((UINavigationBar*)self.adaptedView).bounds.size.width, dropShadow.height);
    myLayer.backgroundColor = dropShadow.color.CGColor;
    
    UIGraphicsBeginImageContext([myLayer frame].size);
    [myLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end