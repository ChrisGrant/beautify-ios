//
//  StyleRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "SCStyleRenderer.h"
#import "SCStyleRenderer_Private.h"
#import "SCViewStyle.h"
#import "SCRenderUtils.h"
#import "SCStyleSetterCustomizer.h"
#import "SCStyleCustomizer.h"

@implementation SCStyleRenderer {
    // a map of style customisers based on control state
    NSMutableDictionary* _customizersForStateMap;
    UIView *_viewToObserve;
}

-(id)initWithView:(id)view theme:(SCTheme*)theme {
    if (self = [super init]) {
        _adaptedView = view;
        _style = [self styleFromTheme:theme];
        _customizersForStateMap = [NSMutableDictionary new];
        
        [self setUpStyleCustomizersForControlStates];

        if([_adaptedView isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController*)_adaptedView;
            _viewToObserve = vc.view;
        }
        else if([_adaptedView isKindOfClass:[UIView class]]) {
            _viewToObserve = _adaptedView;
        }
        
        [_viewToObserve addObserver:self
                        forKeyPath:@"frame"
                           options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                           context:nil];
        
        [_viewToObserve addObserver:self
                        forKeyPath:@"bounds"
                           options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                           context:nil];
    }
    return self;
}

-(void)dealloc {
    [_viewToObserve removeObserver:self forKeyPath:@"frame"];
    [_viewToObserve removeObserver:self forKeyPath:@"bounds"];
}

-(void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object
                       change:(NSDictionary*)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"] || [keyPath isEqualToString:@"bounds"]) {
        [self redraw];
    }
}

#pragma mark - Theme and style customization

-(void)setTheme:(SCTheme*)theme {
    _style = [self styleFromTheme:theme];
    
    [self setUpStyleCustomizersForControlStates];
    [self redraw];
}

-(void)setUpStyleCustomizersForControlStates {
    SCStyleCustomizer *highlightedCustomizer = [self createCustomizersForState:UIControlStateHighlighted];
    _customizersForStateMap[DescriptionForState(UIControlStateHighlighted)] = highlightedCustomizer;
    SCStyleCustomizer *normalCustomizer = [self createCustomizersForState:UIControlStateNormal];
    _customizersForStateMap[DescriptionForState(UIControlStateNormal)] = normalCustomizer;
}

-(SCStyleCustomizer*)createCustomizersForState:(UIControlState)state {
    // customize the style based on the 'style setters' that are part of the style itself
    id<SCStyleProtocol> styleCustomizer = [[SCStyleSetterCustomizer alloc] initWithStyle:self.style forState:state];
    
    // customize the style based on the user specified configuration that relates to this specific control instance
    SCStyleCustomizer* userValueCustomizer = _customizersForStateMap[DescriptionForState(state)];
    if (userValueCustomizer == nil) {
        userValueCustomizer = [[SCStyleCustomizer alloc] initWithStyle:styleCustomizer];
    } else {
        [userValueCustomizer updateWithStyle:styleCustomizer];
    }
    
    return userValueCustomizer;
}

#pragma mark - Abstract methods

-(void)redraw {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self configureFromStyle];
    [CATransaction commit];
}

-(void)configureFromStyle {
}

// extracts the style that applies to this renderer from the theme
-(id)styleFromTheme:(SCTheme*)theme {
    [NSException raise:@"Implement style from theme in subclass. This is an abstract class" format:nil];
    return nil;
}

#pragma mark - Style customization

-(void)setPropertyValue:(id)value forName:(NSString*)name forState:(UIControlState)state {
    NSString *stateKey = DescriptionForState(state);
    SCStyleCustomizer *styleCustomizer = _customizersForStateMap[stateKey];
    
    if (styleCustomizer != nil) {
        if (value != nil) {
            [styleCustomizer setPropertyValue:value forName:name];
        }
        else {
            [styleCustomizer removePropertyValueForName:name];
        }
    }
    else {
         NSLog(@"UIControlState '%@' not currently stylable", stateKey);
    }
    
    if (state == self.currentControlState) {
        [self redraw];
    }
}

-(id)propertyValueForName:(NSString *)name forState:(UIControlState)state {
    NSString *stateKey = DescriptionForState(state);
    SCStyleCustomizer *styleCustomizer = _customizersForStateMap[stateKey];
    if (styleCustomizer == nil) {
        NSLog(@"UIControlState '%@' not currently stylable, returning style for UIControlStateNormal", stateKey);
        stateKey = DescriptionForState(UIControlStateNormal);
        styleCustomizer = _customizersForStateMap[stateKey];
    }
    return [styleCustomizer propertyValueForName:name];
}

-(id)propertyValueForNameWithCurrentState:(NSString*)name {
    return [self propertyValueForName:name forState:[self currentControlState]];
}

#pragma mark - Generic

// override if a UI element supports more than UIControlStateNormal
-(UIControlState)currentControlState {
    return UIControlStateNormal;
}

-(void)viewDidMoveToWindow {
    // Override this if you need to do something additional when the view moves to the window. Empty otherwise.
}

@end