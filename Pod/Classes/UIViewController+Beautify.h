//
//  UIViewController+Beautify.h
//  Beautify
//
//  Created by Adrian Conlin on 24/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYViewControllerRenderer.h"

@interface UIViewController (Beautify)

/*
 Return the renderer which enchances the UI for this view controller.
 */
@property (readonly) BYViewControllerRenderer *renderer;

/*
 Whether this view controller is 'immune' to the globally applied theme, i.e. it will maintain the style defined by the
 developer when the UI was designed, either in the Interface Bulder or in code.
 
 This value is recursively passed to all of the subviews of this view controlelr. i.e. when setting this value, the same
 value is passed to all of the view controller's subviews, and all of their subviews etc.
 */
@property (nonatomic, getter=isImmuneToBeautify) BOOL immuneToBeautify;

/*
 Called when the theme is updated
 */
-(void)themeUpdated:(NSNotification*)notification;

@end