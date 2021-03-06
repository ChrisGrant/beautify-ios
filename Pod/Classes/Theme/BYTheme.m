//
//  Theme.m
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYTheme.h"
#import "BYSwitchStyle.h"
#import "BYLabelStyle.h"
#import "BYViewControllerStyle.h"
#import "BYNavigationBarStyle.h"
#import "BYButtonStyle.h"
#import "BYTextFieldStyle.h"
#import "BYSliderStyle.h"
#import "BYBarButtonStyle.h"
#import "BYTableViewCellStyle.h"
#import "BYImageViewStyle.h"
#import "BYJSONVersion.h"
#import "BYTabBarStyle.h"

#define SCHEMA_VERSION_KEY @"schemaVersion"
#define THEME_KEY @"theme"

@implementation BYTheme

+(BYTheme *)fromDictionary:(NSDictionary *)dict {
    BYTheme* theme = [self validateAndReturnThemeFromDictionary:dict];
    return theme;
}

+(BYTheme*)fromFile:(NSString *)file {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:file ofType:@"json"];
    NSData *json = [NSData dataWithContentsOfFile:filePath];
    
    BYTheme *theme;
    if (json) {
        NSError *jsonError;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments
                                                               error:&jsonError];
        if (jsonError) {
            NSLog(@"Error: Could not parse JSON! %@", jsonError.debugDescription);
        }
        else {
            theme = [self validateAndReturnThemeFromDictionary:dict];
        }
    }
    else {
        NSLog(@"[BYTheme fromFile] failed - Unable to load file");
    }
    return theme;
}

-(BOOL)__isJSONModelSubClass:(Class)class {
    if([NSStringFromClass(class) isEqualToString:NSStringFromClass([BYSwitchStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYButtonStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYSliderStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYLabelStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYViewControllerStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYTextFieldStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYNavigationBarStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYTableViewCellStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYImageViewStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYBarButtonStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYTabBarStyle class])] ||
       [NSStringFromClass(class) isEqualToString:NSStringFromClass([BYSearchBarStyle class])]) {
        return YES;
    }
    return NO;
}

+(BYTheme*)validateAndReturnThemeFromDictionary:(NSDictionary*)dict {
    // Find the version of the JSON file being passed in.
    BYTheme *theme;
    NSString *fileVersion = dict[SCHEMA_VERSION_KEY];
    
    // Compare it to the current version. If they aren't equal, we can't continue and should log an error.
    if(![fileVersion isEqualToString:JSON_SCHEMA_VERSION]) {
        NSLog(@"[BYTheme fromFile] failed - The version of the file (%@) was invalid. Expecting %@", fileVersion, JSON_SCHEMA_VERSION);
        return nil;
    }
    
    NSError *parseError;
    theme = [[BYTheme alloc] initWithDictionary:dict[THEME_KEY] error:&parseError];
    if(parseError) {
        NSLog(@"Parse error when reading the JSON - %@", parseError.debugDescription);
        return nil;
    }
    else {
        return theme;
    }
    return theme;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    if(!dict) {
        return nil;
    }
    
    if(dict.allKeys.count == 0) {
        return [BYTheme new];
    }
    
    BYTheme *theme = [super initWithDictionary:dict error:err];
    if(theme == nil) {
        theme = [BYTheme new];
    }
    return theme;
}

-(instancetype)init {
    if (self = [super init]) {
        self.buttonStyle = [BYButtonStyle defaultSystemStyle];
        self.switchStyle = [BYSwitchStyle defaultStyle];
        self.labelStyle = [BYLabelStyle defaultStyle];
        self.viewControllerStyle = [BYViewControllerStyle defaultStyle];
        self.textFieldStyle = [BYTextFieldStyle defaultStyle];
        self.navigationBarStyle = [BYNavigationBarStyle defaultStyle];
        self.tableViewCellStyle = [BYTableViewCellStyle defaultStyle];
        self.imageViewStyle = [BYImageViewStyle defaultStyle];
        self.barButtonItemStyle = [BYBarButtonStyle defaultStyle];
        self.backButtonItemStyle = [BYBarButtonStyle defaultBackButtonStyle];
        self.sliderStyle = [BYSliderStyle defaultStyle];
        self.tabBarStyle = [BYTabBarStyle defaultStyle];
        self.searchBarStyle = [BYSearchBarStyle defaultStyle];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    BYTheme *theme = [[[self class] allocWithZone:zone] init];
    theme.buttonStyle = self.buttonStyle.copy;
    theme.switchStyle = self.switchStyle.copy;
    theme.labelStyle = self.labelStyle.copy;
    theme.viewControllerStyle = self.viewControllerStyle.copy;
    theme.textFieldStyle = self.textFieldStyle.copy;
    theme.navigationBarStyle = self.navigationBarStyle.copy;
    theme.tableViewCellStyle = self.tableViewCellStyle.copy;
    theme.imageViewStyle = self.imageViewStyle.copy;
    theme.barButtonItemStyle = self.barButtonItemStyle.copy;
    theme.backButtonItemStyle = self.backButtonItemStyle.copy;
    theme.sliderStyle = self.sliderStyle.copy;
    theme.tabBarStyle = self.tabBarStyle.copy;
    return theme;
}

-(NSDictionary*)toDictionary {
    // Get the dictionary that we need to wrap in the version number.
    NSDictionary *dict = [super toDictionary];
    
    // Wrap the dictionary in "theme" property as well as adding the current schema version.
    NSMutableDictionary *wrapperDict = [NSMutableDictionary new];
    wrapperDict[SCHEMA_VERSION_KEY] = JSON_SCHEMA_VERSION;
    wrapperDict[THEME_KEY] = dict;
    return wrapperDict;
}

@end