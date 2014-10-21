//
//  BYStyleRenderer_Private.h
//  Beautify
//
//  Created by Adrian Conlin on 16/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYStyleRenderer.h"

/*
 Private API for BYStyleRenderer.
 */
@interface BYStyleRenderer ()

// The view that this renderer is associated with
@property id __weak adaptedView;

// The style that this renderer applies
@property id style;

// Associate this renderer with the given view and theme
-(id)initWithView:(id)view theme:(BYTheme*)theme;

// Updates this renderer with the given theme. This will cause the renderer to redraw itself.
-(void)setTheme:(BYTheme*)theme;

-(void)setUpStyleCustomizersForControlStates;

/*
 Trigger a redraw. If you make changes to the style associated with the renderer,
 then you must invoke this method in order for the changes to take effect.
 */
-(void)redraw;

#pragma mark - Style customization

-(void)setPropertyValue:(id)value forName:(NSString*)name forState:(UIControlState)state;

-(id)propertyValueForNameWithCurrentState:(NSString*)name;

-(id)propertyValueForName:(NSString*)name forState:(UIControlState)state;

#pragma mark - Generic

-(UIControlState)currentControlState;

-(void)viewDidMoveToWindow;

@end