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
        navBar.barTintColor = style.tintColor;
        
        NSMutableDictionary *attributeDictionary = [NSMutableDictionary new];
        UIFont *currentFont = navBar.titleTextAttributes[UITextAttributeFont];
        UIFont *styledFont = [style.title.font createFont:currentFont];
        
        if(styledFont) {
            attributeDictionary[UITextAttributeFont] = styledFont;
        }
        
        if(style.title.color) {
            attributeDictionary[UITextAttributeTextColor] = style.title.color;
        }
        
        if (style.titleShadow) {
            UIOffset offset = UIOffsetMake(style.titleShadow.offset.width, style.titleShadow.offset.height);
            attributeDictionary[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:offset];
            attributeDictionary[UITextAttributeTextShadowColor] = style.titleShadow.color;
        }
        
        navBar.titleTextAttributes = attributeDictionary;
        
        if((_navBarBackground) && ([style dropShadow])){
            [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            navBar.shadowImage = [self makeImageWithDropShadow:[style dropShadow]];
        }
        
        UIViewController *presentingController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        if([presentingController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navController = (UINavigationController*)presentingController;
            // This forces the navigation bar to update it's attributes to those that have been set above with UIAppearance
            [navController pushViewController:[UIViewController new] animated:NO];
            [navController popViewControllerAnimated:NO];
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