//
//  SCThemeManager.h
//  Beautify
//
//  Created by Adrian Conlin on 21/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCTheme.h"

static NSString *const CSThemeUpdatedNotification = @"CSThemeUpdatedNotification";

@class SCStyleRenderer;

/*
 Theme manager is manages the current theme and related data.
 */
@interface SCThemeManager : NSObject

/*
 Accesses the theme manager singleton instance.
 */
+(SCThemeManager*)instance;

// The current theme
@property (nonatomic) SCTheme* currentTheme;

-(void)applyTheme:(SCTheme*)theme;

@end