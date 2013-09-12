//
//  UIView+Utilities.h
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utilities)

-(void)hideAllSubViews;
-(void)dumpViewHierarchy;
-(void)dumpParentViewHierarchy;

@property UIFont* previousFont;

@end