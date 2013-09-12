//
//  Theme.m
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCTheme.h"
#import "SCConfigParser.h"
#import "SCSwitchStyle.h"
#import "SCLabelStyle.h"
#import "SCViewControllerStyle.h"
#import "SCNavigationBarStyle.h"
#import "SCButtonStyle.h"
#import "SCTextFieldStyle.h"
#import "SCSliderStyle.h"
#import "SCBarButtonStyle.h"

@implementation SCTheme

+(SCTheme *)default {
    SCTheme* theme = [SCTheme new];
    return theme;
}

+(SCTheme *)fromDictionary:(NSDictionary *)dict {
    NSDictionary *themeDict = dict[@"theme"];
    SCTheme* theme = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCTheme class]
                                                              fromDict:themeDict];
    return theme;
}

+(SCTheme *)fromFile:(NSString *)file {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:file ofType:@"json"];
    NSData* json = [NSData dataWithContentsOfFile:filePath];
    
    SCTheme* theme = nil;
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
        NSLog(@"[SCTheme fromFile] failed - unable to load file");
    }
    return theme;
}

-(id)init {
    if (self = [super init]) {
        _name = @"DEFAULT";
//        _buttonStyle = [SCButtonStyle new];
//        _switchStyle = [SCSwitchStyle new];
//        _labelStyle = [SCLabelStyle new];
//        _viewControllerStyle = [SCViewControllerStyle new];
//        _textFieldStyle = [SCTextFieldStyle new];
//        _navigationBarStyle = [SCNavigationBarStyle new];
//        _barButtonItemStyle = [SCBarButtonStyle new];
//        _sliderStyle = [SCSliderStyle new];
    }
    return self;
}

-(NSString*)description {
    return self.name;
}

@end