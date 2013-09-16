//
//  Theme.m
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYTheme.h"
#import "BYConfigParser.h"
#import "BYSwitchStyle.h"
#import "BYLabelStyle.h"
#import "BYViewControllerStyle.h"
#import "BYNavigationBarStyle.h"
#import "BYButtonStyle.h"
#import "BYTextFieldStyle.h"
#import "BYSliderStyle.h"
#import "BYBarButtonStyle.h"

@implementation BYTheme

+(BYTheme *)defaultTheme {
    BYTheme* theme = [BYTheme new];
    return theme;
}

+(BYTheme *)fromDictionary:(NSDictionary *)dict {
    NSDictionary *themeDict = dict[@"theme"];
    BYTheme* theme = [BYConfigParser parseStyleObjectPropertiesOnClass:[BYTheme class]
                                                              fromDict:themeDict];
    return theme;
}

+(BYTheme *)fromFile:(NSString *)file {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:file ofType:@"json"];
    NSData* json = [NSData dataWithContentsOfFile:filePath];
    
    BYTheme* theme = nil;
    if (json) {
        NSError* jsonError;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json
                                                             options:NSJSONReadingAllowFragments
                                                               error:&jsonError];
        if (jsonError) {
            NSLog(@"Error: Could not parse JSON! %@", jsonError.debugDescription);
        } else {
            theme = [self fromDictionary:dict];
        }
    } else {
        NSLog(@"[BYTheme fromFile] failed - unable to load file");
    }
    return theme;
}

-(id)init {
    if (self = [super init]) {
        _name = @"DEFAULT";
    }
    return self;
}

-(NSString*)description {
    return self.name;
}

@end