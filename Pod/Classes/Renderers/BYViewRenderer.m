//
//  ViewRenderer.m
//  Beautify
//
//  Created by Adrian Conlin on 07/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer.h"
#import "BYViewRenderer_Private.h"
#import "BYViewStyle.h"

@implementation BYViewRenderer

-(void)configureFromStyle {
    float alpha = 1;
    [[self propertyValueForNameWithCurrentState:@"alpha"] getValue:&alpha];
    ((UIView*)self.adaptedView).alpha = alpha;
    
    UIColor *tintColor = [self propertyValueForName:@"tintColor" forState:UIControlStateNormal];
    if(tintColor) {
        [self.adaptedView setTintColor:tintColor];
    }
}

-(void)setAlpha:(float)alpha forState:(UIControlState)state {
    [self setPropertyValue:[NSValue value:&alpha
                             withObjCType:@encode(float)] forName:@"alpha" forState:state];
}

-(void)setTintColor:(UIColor*)color {
    [self setPropertyValue:color forName:@"tintColor" forState:UIControlStateNormal];
}

@end