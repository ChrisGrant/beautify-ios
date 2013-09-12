//
//  ConfigParser.h
//  Property Finder
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SCSwitchStyle.h"
#import "SCTheme.h"

/**
 * Utility class for parsing themes, configs, styles and properties.
 */
@interface SCConfigParser : NSObject

+(id)parseStyleObjectPropertiesOnClass:(Class)theClass fromDict:(NSDictionary*)dict;

@end