//
//  SCImageViewRenderer.m
//  Beautify
//
//  Created by Chris Grant on 18/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCImageViewRenderer.h"
#import "SCStyleRenderer_Private.h"
#import "SCImageViewStyle.h"
#import "SCTheme.h"
#import "SCControlRenderer_Private.h"
#import "SCViewRenderer_Private.h"
#import "UIView+Utilities.h"
#import "UIImageView+Beautify.h"
#import "SCControlRenderingLayer.h"
#import "SCTopShadowRenderingLayer.h"
#import "SCBorder.h"

#import "SCRenderUtils.h"

@implementation SCImageViewRenderer {
    UIImageView *_replacementImageView;
    SCControlRenderingLayer *_backgroundLayer;
    
    SCTopShadowRenderingLayer *_topLayer;
}

-(id)initWithView:(id)view theme:(SCTheme*)theme {
    if(self = [super initWithView:view theme:theme]) {
        UIImageView *imageView = (UIImageView*)view;
        [imageView setClipsToBounds:NO];
        [self setup:imageView theme:theme];
    }
    return self;
}

-(void)setup:(UIImageView*)imageView theme:(SCTheme*)theme {
    _backgroundLayer = [[SCControlRenderingLayer alloc] initWithRenderer:self];
    [imageView.layer insertSublayer:_backgroundLayer atIndex:0];
    
    _replacementImageView = [[UIImageView alloc] initWithFrame:imageView.bounds];
    [_replacementImageView setImage:imageView.image];
    [_replacementImageView setContentMode:imageView.contentMode];
    [_replacementImageView setClipsToBounds:YES];
    [_backgroundLayer addSublayer:_replacementImageView.layer];
    
    _topLayer = [[SCTopShadowRenderingLayer alloc] initWithRenderer:self];
    [_backgroundLayer addSublayer:_topLayer];
    
    [self configureFromStyle];
}

-(id)styleFromTheme:(SCTheme*)theme {
    if(theme.imageViewStyle) {
        return theme.imageViewStyle;
    }
    
    SCImageViewStyle *ivs = [SCImageViewStyle defaultStyle];
    return ivs;
}

-(void)configureFromStyle {
    UIImageView *imageView = (UIImageView*)self.adaptedView;
    
    NSArray *outerShadows = [self propertyValueForNameWithCurrentState:@"outerShadows"];
    SCBorder *border = [self propertyValueForNameWithCurrentState:@"border"];
    
    CGRect replacementImageViewFrame = imageView.bounds;
    UIEdgeInsets insets = ComputeInsetsForShadows(outerShadows);
    replacementImageViewFrame.origin.x = replacementImageViewFrame.origin.x + (insets.left * 2);
    replacementImageViewFrame.origin.y = replacementImageViewFrame.origin.y + (insets.top * 2);
    [_replacementImageView setFrame:replacementImageViewFrame];
    
    _replacementImageView.layer.borderColor = border.color.CGColor;
    _replacementImageView.layer.borderWidth = border.width;
    _replacementImageView.layer.cornerRadius = border.cornerRadius;

    [_backgroundLayer setFrame:imageView.bounds];
    [_backgroundLayer setNeedsDisplay];
    
    _topLayer.borderColor = border.color.CGColor;
    _topLayer.cornerRadius = border.cornerRadius;
    
    [_topLayer setFrame:replacementImageViewFrame];
    [_topLayer setNeedsDisplay];
}

@end