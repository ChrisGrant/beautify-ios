//
//  BYControlRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYControlRenderer.h"
#import "BYControlRenderingLayer.h"
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYNineBoxedImage.h"
#import "BYNineBoxedImage_Private.h"
#import "BYControlRenderer_Private.h"

@implementation BYControlRenderer

-(void)addNineBoxAndRendererLayers {
    [self addNineBoxAndRendererLayers:(UIView*)self.adaptedView];
}

-(void)addNineBoxAndRendererLayers:(UIView*)view {
    _nineBoxImage = [UIImageView new];
    _nineBoxImage.frame = view.bounds;
    [view addSubview:_nineBoxImage];
    [view sendSubviewToBack:_nineBoxImage];
    
    // The control layer that renders the background and border
    _controlLayer = [[BYControlRenderingLayer alloc] initWithRenderer:self];
    [_controlLayer setFrame:view.bounds];
    [view.layer insertSublayer:_controlLayer atIndex:0];
}

-(void)configureFromStyle {
    UIView *adaptedView = (UIView*)self.adaptedView;
    
    BYNineBoxedImage *backgroundImage = [self propertyValueForNameWithCurrentState:@"backgroundImage"];
    if (backgroundImage == nil) {
        _nineBoxImage.hidden = YES;
        _controlLayer.hidden = NO;
        
        [_controlLayer setFrame:adaptedView.bounds];
        [_controlLayer setNeedsDisplay];
    }
    else {
        _controlLayer.hidden = YES;
        _nineBoxImage.hidden = NO;
        _nineBoxImage.image = [backgroundImage createNineBoxedImage];
    }
}

// override if a UI element supports more than UIControlStateNormal
-(UIControlState)currentControlState {
    return self.highlighted ? UIControlStateHighlighted : UIControlStateNormal;
}

-(void)setBackgroundColor:(UIColor*)backgroundColor forState:(UIControlState)state {
    [self setPropertyValue:backgroundColor forName:@"backgroundColor" forState:state];
}

-(void)setBackgroundGradient:(BYGradient*)backgroundGradient forState:(UIControlState)state {
    [self setPropertyValue:backgroundGradient forName:@"backgroundGradient" forState:state];
}

-(void)setBackgroundImage:(BYNineBoxedImage*)backgroundImage forState:(UIControlState)state {
    [self setPropertyValue:backgroundImage forName:@"backgroundImage" forState:state];
}

// border
-(void)setBorder:(BYBorder*)border forState:(UIControlState)state {
    [self setPropertyValue:border forName:@"border" forState:state];
}

-(void)setInnerShadows:(NSArray*)innerShadows forState:(UIControlState)state {
    [self setPropertyValue:innerShadows forName:@"innerShadows" forState:state];
}

-(void)setOuterShadows:(NSArray*)outerShadows forState:(UIControlState)state {
    [self setPropertyValue:outerShadows forName:@"outerShadows" forState:state];
}

@end