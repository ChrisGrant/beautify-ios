//
//  UIBarButtonItem+Beautify.h
//  Beautify
//
//  Created by Daniel Allsop on 02/08/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYBarButtonItemRenderer.h"

@interface UIBarButtonItem (Beautify)

@property (nonatomic, readonly, strong) BYBarButtonItemRenderer *renderer;

/**
 Whether this view is 'immune' to the globally applied theme, i.e. it will maintain the style defined by the
 developer when the UI was designed, either in the Interface Bulder or in code.
 
 This value is recursively passed to all of the subviews of this view. i.e. when setting this value, the same value is
 passed to all of this view's subviews, and all of their subviews etc.
 */
@property (nonatomic, getter=isImmuneToBeautify) BOOL immuneToBeautify;

@end