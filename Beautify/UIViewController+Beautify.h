//
//  UIViewController+Beautify.h
//  Beautify
//
//  Created by Adrian Conlin on 24/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYViewControllerRenderer.h"

@interface UIViewController (Beautify)

/*
 Return the renderer which enchances the UI for this view controller.
 */
@property (readonly) BYViewControllerRenderer *renderer;

/*
 Whether this UIView is 'immune' to the streamed style, i.e. it will maintain the style defined by the
 developer when the UI was designed, either in the Interface Bulder or in code.
 */
-(BOOL)isImmuneToBeautify;

/*
 Set whether this UIView is 'immune' to streamed styles.
 */
-(void)setImmuneToBeautify:(BOOL)immuneToBeautify;

/*
 Called when the theme is updated
 */
-(void)themeUpdated:(NSNotification*)notification;

@end