//
//  BYImageViewRenderer.m
//  Beautify
//
//  Created by Chris Grant on 18/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYImageViewRenderer.h"
#import "BYStyleRenderer_Private.h"
#import "BYImageViewStyle.h"
#import "BYTheme.h"
#import "UIImageView+Beautify.h"
#import "BYControlRenderingLayer.h"
#import "BYTopShadowRenderingLayer.h"
#import "BYBorder.h"
#import "BYRenderUtils.h"

@implementation BYImageViewRenderer {
    UIImageView *_replacementImageView;
    BYControlRenderingLayer *_backgroundLayer;
    BYTopShadowRenderingLayer *_topLayer;
}

-(id)initWithView:(id)view theme:(BYTheme*)theme {
    if(self = [super initWithView:view theme:theme]) {
        UIImageView *imageView = (UIImageView*)view;
        [imageView setClipsToBounds:NO];
        [self setup:imageView theme:theme];
    }
    return self;
}

-(void)setup:(UIImageView*)imageView theme:(BYTheme*)theme {
    _backgroundLayer = [[BYControlRenderingLayer alloc] initWithRenderer:self];
    [imageView.layer insertSublayer:_backgroundLayer atIndex:0];
    
    _replacementImageView = [[UIImageView alloc] initWithFrame:imageView.bounds];
    [_replacementImageView setImage:imageView.image];
    [_replacementImageView setContentMode:imageView.contentMode];
    [_replacementImageView setClipsToBounds:YES];
    [_backgroundLayer addSublayer:_replacementImageView.layer];
    
    _topLayer = [[BYTopShadowRenderingLayer alloc] initWithRenderer:self];
    [_backgroundLayer addSublayer:_topLayer];
    
    [self configureFromStyle];
}

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.imageViewStyle) {
        return theme.imageViewStyle;
    }
    
    BYImageViewStyle *ivs = [BYImageViewStyle defaultStyle];
    return ivs;
}

-(void)configureFromStyle {
    UIImageView *imageView = (UIImageView*)self.adaptedView;
    
    BYShadow *outerShadow = [self propertyValueForNameWithCurrentState:@"outerShadow"];
    BYBorder *border = [self propertyValueForNameWithCurrentState:@"border"];
    
    CGRect replacementImageViewFrame = imageView.bounds;
    UIEdgeInsets insets = ComputeInsetsForShadows(outerShadow);
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