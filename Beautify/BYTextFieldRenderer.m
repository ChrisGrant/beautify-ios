//
//  BYTextFieldRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 29/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYTextFieldRenderer.h"
#import "BYTheme.h"
#import "BYViewRenderer_Private.h"
#import "BYStyleRenderer_Private.h"
#import "UIView+Utilities.h"
#import "BYBackgroundImage.h"
#import "BYControlRenderer_Private.h"
#import "BYTextFieldStyle.h"
#import "BYFont_Private.h"
#import "BYRenderUtils.h"
#import "BYTextFieldStyle.h"
#import "UITextField+Beautify.h"

@interface BYTextFieldRenderer ()
@property BYTextFieldStyle *style; // Strongly type the style.
@end

@implementation BYTextFieldRenderer

-(id)initWithView:(id)view theme:(BYTheme*)theme{
    UITextField *textField = (UITextField*)view;
    
    // Only create a renderer for the rounded rect type for now.
    if(textField.borderStyle != UITextBorderStyleRoundedRect) {
        return nil;
    }
    
    if(self = [super initWithView:view theme:theme]) {
        [self setup:textField theme:theme];
    }
    return self;
}

-(void)setup:(UITextField*)textField theme:(BYTheme*)theme {
    if(textField.borderStyle == UITextBorderStyleRoundedRect) {
        [textField hideAllSubViews];
        for(UIView *subview in textField.subviews) {
            // Don't hide the text field label, otherwise no text will be visible!
            if([subview isKindOfClass:NSClassFromString(@"UITextFieldLabel")]) {
                [subview setHidden:NO];
            }
        }
        [textField getDelegateProxy].proxiedDelegate = self;
        
        [self addRendererLayers];
        [self configureFromStyle];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.highlighted = YES;
    [self redraw];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    self.highlighted = NO;
    [self redraw];
}

-(void)configureFromStyle {
    UITextField *textField = (UITextField*)self.adaptedView;
    
    // apply the text styles
    textField.textColor = self.style.title.color;
    textField.font = [self.style.title.font createFont:textField.font];
    
    // Make sure shadows can be drawn outside bounds
    textField.clipsToBounds = NO;
    
    [super configureFromStyle];
}

-(id)styleFromTheme:(BYTheme*)theme {
    UITextField *textField = (UITextField*)self.adaptedView;
    
    if(textField.borderStyle == UITextBorderStyleRoundedRect) {
        if(theme.textFieldStyle) {
            return theme.textFieldStyle;
        }

        return [BYTextFieldStyle defaultStyle];
    }
    
    NSLog(@"Could not find an appropriate style for text field based on it's border style.");
    return nil;
}

@end