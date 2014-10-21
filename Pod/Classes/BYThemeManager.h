//
//  BYThemeManager.h
//  Beautify
//
//  Created by Adrian Conlin on 21/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

static NSString *const CSThemeUpdatedNotification = @"CSThemeUpdatedNotification";

@class BYStyleRenderer, BYTheme;

/*
 Theme manager is manages the current theme and related data.
 */
@interface BYThemeManager : NSObject

/*
 Accesses the theme manager singleton instance.
 */
+(BYThemeManager*)instance;

// The current theme
@property (nonatomic) BYTheme* currentTheme;

-(void)applyTheme:(BYTheme*)theme;

@end