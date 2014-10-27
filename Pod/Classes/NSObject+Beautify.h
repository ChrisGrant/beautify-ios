//
//  NSObject+Beautify.h
//  Beautify
//
//  Created by Daniel Allsop on 06/09/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (Beautify)

/**
 Whether this view is 'immune' to the globally applied theme, i.e. it will maintain the style defined by the
 developer when the UI was designed, either in the Interface Bulder or in code.
 */
-(BOOL)isImmuneToBeautify;

/**
 Set whether this view is 'immune' to the globally appled theme.
 */
-(void)setImmuneToBeautify:(BOOL)immuneToBeautify;

@end
