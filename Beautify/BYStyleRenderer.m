//
//  StyleRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "BYStyleRenderer.h"
#import "BYStyleRenderer_Private.h"
#import "BYViewStyle.h"
#import "BYRenderUtils.h"
#import "BYStyleSetterCustomizer.h"
#import "BYStyleCustomizer.h"
#import "UIView+BeautifyPrivate.h"

@implementation BYStyleRenderer {
    // a map of style customisers based on control state
    NSMutableDictionary* _customizersForStateMap;
    __weak UIView *_viewToObserve;
}

-(id)initWithView:(id)view theme:(BYTheme*)theme {
    if (self = [super init]) {

        _adaptedView = view;
        _style = [self styleFromTheme:theme];

        [self setUpStyleCustomizersForControlStates];

        if([_adaptedView isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController*)_adaptedView;
            _viewToObserve = vc.view;
        }
        else if([_adaptedView isKindOfClass:[UIView class]]) {
            _viewToObserve = _adaptedView;
            [view associateRenderer:self];
        }
    }
    return self;
}

#pragma mark - Theme and style customization

-(void)setTheme:(BYTheme*)theme {
    _style = [self styleFromTheme:theme];
    [self setUpStyleCustomizersForControlStates];
    [self redraw];
}

-(void)setUpStyleCustomizersForControlStates {
    if(!_customizersForStateMap) {
        _customizersForStateMap = [NSMutableDictionary new];
    }

    BYStyleCustomizer *highlightedCustomizer = [self createCustomizersForState:UIControlStateHighlighted];
    _customizersForStateMap[DescriptionForState(UIControlStateHighlighted)] = highlightedCustomizer;
    BYStyleCustomizer *normalCustomizer = [self createCustomizersForState:UIControlStateNormal];
    _customizersForStateMap[DescriptionForState(UIControlStateNormal)] = normalCustomizer;
}

-(BYStyleCustomizer*)createCustomizersForState:(UIControlState)state {
    // customize the style based on the 'style setters' that are part of the style itself
    id<BYStyleProtocol> styleCustomizer = [[BYStyleSetterCustomizer alloc] initWithStyle:self.style forState:state];
    
    // customize the style based on the user specified configuration that relates to this specific control instance
    BYStyleCustomizer* userValueCustomizer = _customizersForStateMap[DescriptionForState(state)];
    if (userValueCustomizer == nil) {
        userValueCustomizer = [[BYStyleCustomizer alloc] initWithStyle:styleCustomizer];
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
-(id)styleFromTheme:(BYTheme*)theme {
    [NSException raise:@"Implement styleFromTheme: in subclass. This is an abstract class" format:nil];
    return nil;
}

#pragma mark - Style customization

-(void)setPropertyValue:(id)value forName:(NSString*)name forState:(UIControlState)state {
    NSString *stateKey = DescriptionForState(state);
    BYStyleCustomizer *styleCustomizer = _customizersForStateMap[stateKey];
    
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
    BYStyleCustomizer *styleCustomizer = _customizersForStateMap[stateKey];
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