//
//  NSObject+Beautify.h
//  Beautify
//
//  Created by Daniel Allsop on 06/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (Beautify)

/*
 + Whether this UIView is 'immune' to the streamed style, i.e. it will maintain the style defined by the
 developer when the UI was designed, either in the Interface Bulder or in code.
 */
-(BOOL)isImmuneToBeautify;

/*
 Set whether this UIView is 'immune' to streamed styles.
 */
-(void)setImmuneToBeautify:(BOOL)immuneToBeautify;

@end
