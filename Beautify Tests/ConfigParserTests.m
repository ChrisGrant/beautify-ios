//
//  ParserTests.m
//  Beautify
//
//  Created by Chris Grant on 13/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCConfigParser.h"
#import "SCButtonStyle.h"
#import "UIColor+Comparison.h"
#import "SCGradientStop.h"
#import "SCStateSetter.h"

@interface ConfigParserTests : XCTestCase
@end

// These tests test the public API of SCConfigParser
@implementation ConfigParserTests

#pragma mark - Default / Nil Theme Testing

-(void)testConfigParserWithNilDictionary {
    SCTheme *theme;
    XCTAssertNoThrow(theme = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCTheme class] fromDict:nil],
                     @"Shouldn't throw with a nil dictionary");
    XCTAssertNil(theme, @"Theme should be nil");
}

-(void)testConfigParserWithEmptyDictonary {
    SCTheme *theme;
    XCTAssertNoThrow(theme = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCTheme class] fromDict:@{}],
                     @"Shouldn't throw with an empty dictionary");
    [self assertDefaultTheme:theme];
}

-(void)testConfigParserWithInvalidDictionary {
    SCTheme *theme;
    NSDictionary *dict = @{@"invalid": @"dictionary", @"still": @{@"Invalid": @"dict", @"theme": @[]}};
    XCTAssertNoThrow(theme = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCTheme class] fromDict:dict],
                     @"Shouldn't throw with an invalid dictionary");
    [self assertDefaultTheme:theme];
}

-(void)assertDefaultTheme:(SCTheme*)theme {
    XCTAssertNotNil(theme, @"Theme should not be nil");
    XCTAssertEqual(theme.name, @"DEFAULT", @"Theme name should be equal to DEFAULT");
    XCTAssertNil(theme.buttonStyle, @"Should be nil");
    XCTAssertNil(theme.switchStyle, @"Should be nil");
    XCTAssertNil(theme.labelStyle, @"Should be nil");
    XCTAssertNil(theme.viewControllerStyle, @"Should be nil");
    XCTAssertNil(theme.textFieldStyle, @"Should be nil");
    XCTAssertNil(theme.navigationBarStyle, @"Should be nil");
    XCTAssertNil(theme.tableViewCellStyle, @"Should be nil");
    XCTAssertNil(theme.imageViewStyle, @"Should be nil");
    XCTAssertNil(theme.barButtonItemStyle, @"Should be nil");
    XCTAssertNil(theme.sliderStyle, @"Should be nil");
}

#pragma mark - Button Style Testing

-(void)testButtonStyleWithNilDict {
    SCButtonStyle *buttonStyle;
    XCTAssertNoThrow(buttonStyle = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCButtonStyle class]
                                                                            fromDict:nil]);
    XCTAssertNil(buttonStyle, @"Button style should be nil");
}

-(void)testButtonStyleWithEmptyDict {
    SCButtonStyle *buttonStyle;
    XCTAssertNoThrow(buttonStyle = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCButtonStyle class]
                                                                            fromDict:@{}]);
    XCTAssertNotNil(buttonStyle, @"Button style should not be nil");
}

-(void)testButtonStyleWithValidDict {
    NSDictionary *dictionary = [self dictionaryFromJSONFile:@"ValidButtonStyle"];
    SCButtonStyle *buttonStyle;
    XCTAssertNoThrow(buttonStyle = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCButtonStyle class]
                                                                            fromDict:dictionary],
                     @"Shouldn't throw with valid JSON");
    XCTAssertNotNil(buttonStyle, @"Shouldn't be nil with valid JSON");
    
    XCTAssert([buttonStyle.title.color isEqualToColor:[UIColor blackColor]], @"Title color should be black");
    XCTAssert([buttonStyle.title.font.name isEqualToString:@"HelveticaNeue-Bold"], @"Title font should be helvetica neue bold");
    XCTAssertEqual(buttonStyle.title.font.size, 10.0f, @"Title font should be size 10");
    
    XCTAssertEqual(buttonStyle.titleShadow.offset, CGSizeMake(2,5), @"Title shadow should be 2,5");
    XCTAssert([buttonStyle.titleShadow.color isEqualToColor:[UIColor blueColor]], @"Title shadow should be blue");
    
    XCTAssert([buttonStyle.backgroundColor isEqualToColor:[UIColor blackColor]], @"Background should be black");
    
    XCTAssertEqual(buttonStyle.backgroundGradient.radial, NO, @"Should not be radial");
    SCGradientStop *stop1 = buttonStyle.backgroundGradient.stops[0];
    SCGradientStop *stop2 = buttonStyle.backgroundGradient.stops[1];
    XCTAssertEqual(stop1.stop, 0.1f, @"First stop should be at 0.1");
    XCTAssertEqual(stop2.stop, 0.9f, @"Last stop should be at 0.9");
    XCTAssert([stop1.color isEqualToColor:[UIColor redColor]], @"First stop should be red");
    XCTAssert([stop2.color isEqualToColor:[UIColor blueColor]], @"Last stop should be blue");
    
    XCTAssert([buttonStyle.border.color isEqualToColor:[UIColor redColor]], @"Border Width should be 1");
    XCTAssertEqual(buttonStyle.border.width, 1.0f, @"Border Width should be 1");
    XCTAssertEqual(buttonStyle.border.cornerRadius, 8.0f, @"Corner radius should be 8");
    
    SCShadow *shadow = buttonStyle.outerShadows[0];
    XCTAssert([shadow.color isEqualToColor:[UIColor greenColor]], @"Shadow should be green");
    XCTAssertEqual(shadow.radius, 2.0f, @"Shadow should have a radius of 2");
    XCTAssertEqual(shadow.offset, CGSizeMake(2, 3), @"Shadow should have a radius of 2");
    
    SCStateSetter *setter = buttonStyle.stateSetters[0];
    XCTAssertEqual(setter.state, UIControlStateHighlighted, @"Should be for the highlighted state");
    XCTAssert([setter.propertyName isEqualToString:@"title"], @"Should be for the title");
    
    XCTAssertEqual([setter.value class], [SCText class], @"Should be of type SCText");
    SCText *text = setter.value;
    XCTAssert([text.color isEqualToColor:[UIColor whiteColor]], @"Title color should be white");
    XCTAssert([text.font.name isEqualToString:@"HelveticaNeue-Bold"], @"Title font should be helvetica neue bold");
    XCTAssertEqual(text.font.size, 14.0f, @"Title font should be size 14");
}

-(void)testButtonStyleWithPartialDict {
    NSDictionary *dictionary = [self dictionaryFromJSONFile:@"PartialButtonStyle"];
    SCButtonStyle *buttonStyle;
    XCTAssertNoThrow(buttonStyle = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCButtonStyle class]
                                                                            fromDict:dictionary],
                     @"Shouldn't throw with partial JSON"); 
    XCTAssertNotNil(buttonStyle, @"Shouldn't be nil with valid JSON");
    
    XCTAssert([buttonStyle.title.color isEqualToColor:[UIColor blackColor]], @"Title color should be black");
    XCTAssert([buttonStyle.title.font.name isEqualToString:@"HelveticaNeue"], @"Title font should be helvetica neue");
    XCTAssertEqual(buttonStyle.title.font.size, 11.0f, @"Title font should be size 11");
    
    XCTAssert([buttonStyle.backgroundColor isEqualToColor:[UIColor whiteColor]], @"Background should be black");
    
    XCTAssert([buttonStyle.border.color isEqualToColor:[UIColor blackColor]], @"Border color should be black");
    XCTAssertEqual(buttonStyle.border.width, 2.0f, @"Border Width should be 2");
    XCTAssertEqual(buttonStyle.border.cornerRadius, 9.0f, @"Corner radius should be 9");
}

#pragma mark - Helper Methods

-(NSDictionary*)dictionaryFromJSONFile:(NSString*)fileName {
    NSBundle *unitTestBundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [unitTestBundle pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];
    if(error) {
        NSLog(@"Error - %@", error.debugDescription);
        return nil;
    }
    return dictionary;
}

@end