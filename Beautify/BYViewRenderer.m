//
//  ViewRenderer.m
//  Beautify
//
//  Created by Adrian Conlin on 07/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer.h"
#import "BYViewRenderer_Private.h"
#import "BYViewStyle.h"

@implementation BYViewRenderer

-(id)initWithView:(id)view theme:(BYTheme*)theme{
    if (self = [super initWithView:view theme:theme]) {
        [self.adaptedView addObserver:self forKeyPath:@"frame"
                  options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                  context:nil];
        [self.adaptedView addObserver:self forKeyPath:@"bounds"
                  options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                  context:nil];
    }
    return self;
}

-(void)dealloc {
    [self.adaptedView removeObserver:self forKeyPath:@"frame"];
    [self.adaptedView removeObserver:self forKeyPath:@"bounds"];
}

-(void)configureFromStyle {
    float alpha = 1;
    [[self propertyValueForNameWithCurrentState:@"alpha"] getValue:&alpha];
    ((UIView*)self.adaptedView).alpha = alpha;
}

-(void)setAlpha:(float)alpha forState:(UIControlState)state {
    [self setPropertyValue:[NSValue value:&alpha
                             withObjCType:@encode(float)] forName:@"alpha" forState:state];
}

@end