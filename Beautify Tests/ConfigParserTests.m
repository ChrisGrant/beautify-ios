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
#import "SCSwitchState.h"

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
    
    [self assertText:buttonStyle.title hasName:@"HelveticaNeue-Bold" size:10.0f andColor:[UIColor blackColor]];

    [self assertTextShadow:buttonStyle.titleShadow hasColor:[UIColor blueColor] andOffset:CGSizeMake(2, 5)];
    
    XCTAssert([buttonStyle.backgroundColor isEqualToColor:[UIColor blackColor]], @"Background should be black");
    
    [self assertGradient:buttonStyle.backgroundGradient hasStopOneColor:[UIColor redColor] atPosition:0.1 andStopTwoColor:[UIColor blueColor] atPosition:0.9f andIsRadial:NO withRadialOffset:CGSizeZero];
    
    [self assertBorder:buttonStyle.border hasWidth:1.0f color:[UIColor redColor] andCornerRadius:8.0f];
    
    [self assertShadows:buttonStyle.outerShadows hasOneShadowWithColor:[UIColor greenColor] radius:2.0f andOffset:CGSizeMake(2, 3)];
    
    SCStateSetter *setter = buttonStyle.stateSetters[0];
    XCTAssertEqual(setter.state, UIControlStateHighlighted, @"Should be for the highlighted state");
    XCTAssert([setter.propertyName isEqualToString:@"title"], @"Should be for the title");
    
    XCTAssertEqual([setter.value class], [SCText class], @"Should be of type SCText");
    SCText *text = setter.value;
    [self assertText:text hasName:@"HelveticaNeue-Bold" size:14.0f andColor:[UIColor whiteColor]];
}

-(void)testButtonStyleWithPartialDict {
    NSDictionary *dictionary = [self dictionaryFromJSONFile:@"PartialButtonStyle"];
    SCButtonStyle *buttonStyle;
    XCTAssertNoThrow(buttonStyle = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCButtonStyle class]
                                                                            fromDict:dictionary],
                     @"Shouldn't throw with partial JSON"); 
    XCTAssertNotNil(buttonStyle, @"Shouldn't be nil with valid JSON");
    
    [self assertText:buttonStyle.title hasName:@"HelveticaNeue" size:11 andColor:[UIColor blackColor]];
    
    XCTAssert([buttonStyle.backgroundColor isEqualToColor:[UIColor whiteColor]], @"Background should be black");
    
    [self assertBorder:buttonStyle.border hasWidth:2 color:[UIColor blackColor] andCornerRadius:9];
}

#pragma mark - Switch Style Testing

-(void)testSwitchStyleWithNilDict {
    SCSwitchStyle *switchStyle;
    XCTAssertNoThrow(switchStyle = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCSwitchStyle class]
                                                                            fromDict:nil]);
    XCTAssertNil(switchStyle, @"Switch style should be nil");
}

-(void)testSwitchStyleWithEmptyDict {
    SCSwitchStyle *switchStyle;
    XCTAssertNoThrow(switchStyle = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCSwitchStyle class]
                                                                            fromDict:@{}]);
    XCTAssertNotNil(switchStyle, @"Switch style should not be nil");
}

-(void)testSwitchStyleWithValidDict {
    NSDictionary *dictionary = [self dictionaryFromJSONFile:@"ValidSwitchStyle"];
    SCSwitchStyle *switchStyle;
    XCTAssertNoThrow(switchStyle = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCSwitchStyle class]
                                                                            fromDict:dictionary],
                     @"Shouldn't throw with valid JSON");
    XCTAssertNotNil(switchStyle, @"Shouldn't be nil with valid JSON");
    
    SCSwitchState *onState = switchStyle.onState;
    SCSwitchState *offState = switchStyle.offState;
    
    [self assertSwitchState:onState
               hasTextColor:[UIColor whiteColor] font:@"Helvetica-Bold" size:0
                    andText:@"ON" backgroundColor:[UIColor blackColor]
            textShadowColor:[UIColor blueColor] andTextShadowOffset:CGSizeMake(0, 2)];
    [self assertSwitchState:offState
               hasTextColor:[UIColor redColor] font:@"Helvetica-Neue" size:16
                    andText:@"OFF" backgroundColor:[UIColor whiteColor]
            textShadowColor:[UIColor blackColor] andTextShadowOffset:CGSizeMake(2, 0)];
    
    [self assertBorder:switchStyle.knobBorder hasWidth:1 color:[UIColor greenColor] andCornerRadius:15.0f];
    
    XCTAssert([switchStyle.highlightColor isEqualToColor:[UIColor whiteColor]], @"Highlight color should be white");
    XCTAssert([switchStyle.knobBackgroundColor isEqualToColor:[UIColor whiteColor]], @"Background color should be white");
    
    [self assertGradient:switchStyle.knobBackgroundGradient
         hasStopOneColor:[UIColor whiteColor] atPosition:1.0f
         andStopTwoColor:[UIColor blueColor] atPosition:0.0f andIsRadial:NO withRadialOffset:CGSizeZero];
    
    [self assertShadows:switchStyle.knobInnerShadows hasOneShadowWithColor:[UIColor whiteColor]
                 radius:2 andOffset:CGSizeMake(2, 2)];
    XCTAssertEqual(switchStyle.knobOuterShadows.count, (NSUInteger)0, @"Should be no outer shadows");
    
    [self assertShadows:switchStyle.innerShadows hasOneShadowWithColor:[UIColor blackColor]
                 radius:4 andOffset:CGSizeZero];
    [self assertShadows:switchStyle.outerShadows hasOneShadowWithColor:[UIColor redColor]
                 radius:0 andOffset:CGSizeMake(0, -2)];
    
    [self assertBorder:switchStyle.border hasWidth:1 color:[UIColor redColor] andCornerRadius:15];
}

-(void)testSwitchStyleWithPartialDict {
    NSDictionary *dictionary = [self dictionaryFromJSONFile:@"PartialSwitchStyle"];
    SCSwitchStyle *switchStyle;
    XCTAssertNoThrow(switchStyle = [SCConfigParser parseStyleObjectPropertiesOnClass:[SCSwitchStyle class]
                                                                            fromDict:dictionary],
                     @"Shouldn't throw with valid JSON");
    XCTAssertNotNil(switchStyle, @"Shouldn't be nil with valid JSON");
    
    SCSwitchState *onState = switchStyle.onState;
    SCSwitchState *offState = switchStyle.offState;
    
    [self assertSwitchState:onState
               hasTextColor:nil font:nil size:0
                    andText:@"YES" backgroundColor:[UIColor blackColor]
            textShadowColor:nil andTextShadowOffset:CGSizeZero];
    [self assertSwitchState:offState
               hasTextColor:[UIColor redColor] font:@"Helvetica-Neue" size:16
                    andText:@"NO" backgroundColor:[UIColor whiteColor]
            textShadowColor:[UIColor blackColor] andTextShadowOffset:CGSizeMake(2, 0)];

    [self assertBorder:switchStyle.border hasWidth:2 color:[UIColor redColor] andCornerRadius:5.0f];
}

-(void)assertSwitchState:(SCSwitchState*)state
            hasTextColor:(UIColor*)textColor font:(NSString*)font size:(float)textSize
                 andText:(NSString*)text
         backgroundColor:(UIColor*)bgColor
         textShadowColor:(UIColor*)textShadowColor andTextShadowOffset:(CGSize)offset {
    
    XCTAssert([state.text isEqualToString:text], @"Text should be equal");
    XCTAssert([state.backgroundColor isEqualToColor:bgColor], @"Background should be equal");
    
    [self assertText:state.textStyle hasName:font size:textSize andColor:textColor];
    [self assertTextShadow:state.textShadow hasColor:textShadowColor andOffset:offset];
}

#pragma mark - Helper Methods

-(void)assertShadows:(NSArray*)array hasOneShadowWithColor:(UIColor*)color radius:(float)radius andOffset:(CGSize)offset {
    XCTAssertEqual(array.count, (NSUInteger)1, @"Should only be 1 shadow");
    SCShadow *shadow = array[0];
    
    XCTAssert([shadow.color isEqualToColor:color], @"Colors should be equal");
    XCTAssertEqual(shadow.radius, radius, @"Radii should be equal");
    XCTAssertEqual(shadow.offset, offset, @"Offset should be equal");
}

-(void)assertGradient:(SCGradient*)gradient hasStopOneColor:(UIColor*)color1 atPosition:(float)position1
      andStopTwoColor:(UIColor*)color2 atPosition:(float)position2
          andIsRadial:(BOOL)radial withRadialOffset:(CGSize)offset {
                 
    XCTAssertEqual(gradient.stops.count, (NSUInteger)2, @"Should only be 2 stops");
    
    XCTAssertEqual(gradient.radial, radial, @"Radial should be equal");
    if(gradient.radial) {
        XCTAssertEqual(gradient.radialOffset, offset, @"Offsets should be equal");
    }
    
    SCGradientStop *stop1 = gradient.stops[0];
    XCTAssert([stop1.color isEqualToColor:color1], @"Stop 1 color should be equal");
    XCTAssertEqual(stop1.stop, position1, @"Position 1 should be equal");

    SCGradientStop *stop2 = gradient.stops[1];
    XCTAssert([stop2.color isEqualToColor:color2], @"Stop 2 color should be equal");
    XCTAssertEqual(stop2.stop, position2, @"Position 2 should be equal");
}

-(void)assertBorder:(SCBorder*)border hasWidth:(float)width color:(UIColor*)color andCornerRadius:(float)radius {
    XCTAssertEqual(border.width, width, @"Width should be equal");
    XCTAssert([border.color isEqualToColor:color], @"Colors should be equal");
    XCTAssertEqual(border.cornerRadius, radius, @"Corner Radius should be equal");
}

-(void)assertTextShadow:(SCTextShadow*)textShadow hasColor:(UIColor*)color andOffset:(CGSize)size {
    if(!textShadow) {
        return;
    }
    XCTAssertEqual(textShadow.offset, size, @"Text shadow should be equal");
    XCTAssert([textShadow.color isEqualToColor:color], @"Text shadow should be equal");
}

-(void)assertText:(SCText*)text hasName:(NSString*)name size:(float)size andColor:(UIColor*)color {
    if(!text) {
        return;
    }
    XCTAssert([text.color isEqualToColor:color], @"Colors should be equal");
    [self assertFont:text.font hasName:name andSize:size];
}

-(void)assertFont:(SCFont*)font hasName:(NSString*)name andSize:(float)size {
    if(!font) {
        return;
    }
    XCTAssert([font.name isEqualToString:name], @"Font name should be equal");
    XCTAssertEqual(font.size, size, @"Size should be equal");
}

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