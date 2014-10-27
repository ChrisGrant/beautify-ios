//
//  BYTextFieldRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 29/05/2013.
//  Copyright (c) Beautify. All rights reserved.
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

-(instancetype)initWithView:(id)view theme:(BYTheme*)theme{
    UITextField *textField = (UITextField*)view;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    if(self = [super initWithView:view theme:theme]) {
        [self setup:textField theme:theme];
    }
    return self;
}

-(void)setup:(UITextField*)textField theme:(BYTheme*)theme {
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
    
    // Make sure shadow can be drawn outside bounds
    textField.clipsToBounds = NO;
    
    [super configureFromStyle];
}

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.textFieldStyle) {
        return theme.textFieldStyle;
    }
    return [BYTextFieldStyle defaultStyle];
}

-(void)setTitle:(BYText*)title forState:(UIControlState)state {
    [self setPropertyValue:title forName:@"title" forState:state];
}

@end