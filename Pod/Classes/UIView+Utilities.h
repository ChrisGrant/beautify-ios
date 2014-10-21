//
//  UIView+Utilities.h
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utilities)

-(void)hideAllSubViews;
-(void)dumpViewHierarchy;
-(void)dumpParentViewHierarchy;
-(void)recursivelySetSubViewImmunity:(BOOL)immunity;
-(UITextField*)recursivelySearchSubviewsForViewOfType:(Class)classType;

@property UIFont* previousFont;

@end