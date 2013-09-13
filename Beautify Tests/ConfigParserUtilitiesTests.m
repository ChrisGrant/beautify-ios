//
//  ConfigParserUtilitiesTests.m
//  Beautify
//
//  Created by Chris Grant on 13/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCConfigParser_Private.h"
#import "UIColor+Comparison.h"
#import "SCGradientStop.h"

@interface ConfigParserUtilitiesTests : XCTestCase
@end

@implementation ConfigParserUtilitiesTests

#pragma mark - Size from dictionary

-(void)testSizeFromDictionaryWithValidSizes {
    NSDictionary *validDict = [NSDictionary new];
    
    validDict = @{@"x": @"", @"y": @""};
    XCTAssertEqual([SCConfigParser sizeFromDict:validDict], CGSizeZero, @"Empty values dictionary - size should be zero");
    
    validDict = @{@"x": @"10", @"y": @"10"};
    XCTAssertEqual([SCConfigParser sizeFromDict:validDict], CGSizeMake(10, 10), @"This should be a valid dictionary");
    
    validDict = @{@"y": @"120", @"x": @"5"};
    XCTAssertEqual([SCConfigParser sizeFromDict:validDict], CGSizeMake(5, 120), @"This should be a valid dictionary");
    
    validDict = @{@"x": @"2"};
    XCTAssertEqual([SCConfigParser sizeFromDict:validDict], CGSizeMake(2, 0), @"This should be a valid dictionary");
    
    validDict = @{@"y": @"9"};
    XCTAssertEqual([SCConfigParser sizeFromDict:validDict], CGSizeMake(0, 9), @"This should be a valid dictionary");
}

-(void)testSizeFromDictionaryWithInvalidSizes {
    NSDictionary *invalidDict = [NSDictionary new];
    XCTAssertEqual([SCConfigParser sizeFromDict:invalidDict], CGSizeZero, @"Empty dictionary - size should be zero");
    
    invalidDict = @{@"x": @"", @"y": @""};
    XCTAssertEqual([SCConfigParser sizeFromDict:invalidDict], CGSizeZero, @"Empty values dictionary - size should be zero");
    
    invalidDict = @{@"x": @"", @"y": @""};
    XCTAssertEqual([SCConfigParser sizeFromDict:invalidDict], CGSizeZero, @"Empty values dictionary - size should be zero");
    
    invalidDict = @{@"x": @"a", @"y": @"a"};
    XCTAssertEqual([SCConfigParser sizeFromDict:invalidDict], CGSizeZero, @"Invalid values in dictionary - size should be zero");
    
    invalidDict = @{@"x": @"a1a", @"y": @"a2"};
    XCTAssertEqual([SCConfigParser sizeFromDict:invalidDict], CGSizeZero, @"Invalid values in dictionary - size should be zero");
    
    invalidDict = @{@"y": @"-"};
    XCTAssertEqual([SCConfigParser sizeFromDict:invalidDict], CGSizeZero, @"Invalid values in dictionary - size should be zero");
}

-(void)testSizeFromDictionaryWithNoDictionary {
    XCTAssertEqual([SCConfigParser sizeFromDict:nil], CGSizeZero, @"Without a dictionary, size should be CGSizeZero");
}

#pragma mark - State From String

-(void)testStateFromStringWithNormalValues {
    XCTAssert(UIControlStateHighlighted == [SCConfigParser stateFromString:@"highlighted"],
              @"highlighted should return UIControlStateHighlighted");
    XCTAssert(UIControlStateDisabled == [SCConfigParser stateFromString:@"disabled"],
              @"disabled should return UIControlStateHighlighted");
    XCTAssert(UIControlStateSelected == [SCConfigParser stateFromString:@"selected"],
              @"selected should return UIControlStateHighlighted");
    XCTAssert(UIControlStateNormal == [SCConfigParser stateFromString:@"normal"],
              @"normal should return UIControlStateHighlighted");
}

-(void)testStateFromStringWithAllCapsValue {
    XCTAssert(UIControlStateHighlighted == [SCConfigParser stateFromString:@"HIGHLIGHTED"],
              @"highlighted should return UIControlStateHighlighted");
    XCTAssert(UIControlStateDisabled == [SCConfigParser stateFromString:@"DISABLED"],
              @"disabled should return UIControlStateHighlighted");
    XCTAssert(UIControlStateSelected == [SCConfigParser stateFromString:@"SELECTED"],
              @"selected should return UIControlStateHighlighted");
    XCTAssert(UIControlStateNormal == [SCConfigParser stateFromString:@"NORMAL"],
              @"normal should return UIControlStateHighlighted");
}

-(void)testStateFromStringWithMixedCaseValues {
    XCTAssert(UIControlStateHighlighted == [SCConfigParser stateFromString:@"highLIghteD"],
              @"highlighted should return UIControlStateHighlighted");
    XCTAssert(UIControlStateDisabled == [SCConfigParser stateFromString:@"disABLED"],
              @"disabled should return UIControlStateHighlighted");
    XCTAssert(UIControlStateSelected == [SCConfigParser stateFromString:@"SELected"],
              @"selected should return UIControlStateHighlighted");
    XCTAssert(UIControlStateNormal == [SCConfigParser stateFromString:@"norMAL"],
              @"normal should return UIControlStateHighlighted");
}

-(void)testStateFromStringWithInvalidValue {
    XCTAssert(UIControlStateNormal == [SCConfigParser stateFromString:@"invalid"],
              @"Invalid values should default to UIControlStateNormal");
    XCTAssert(UIControlStateNormal == [SCConfigParser stateFromString:nil],
              @"nil values should default to UIControlStateNormal");
}

#pragma mark - Color From Dict

-(void)testColorFromDictWithNormalDict {
    NSDictionary *colorDict = @{@"test" : @"not_a_color", @"color" : @"0000FF", @"test2" : @"not_a_color"};
    UIColor *color = [SCConfigParser colorFromDict:colorDict key:@"color"];
    XCTAssert([color isEqualToColor:[UIColor blueColor]], @"Color should be blue");
    
    colorDict = @{@"test" : @"00FF00", @"color" : @"0000FF", @"test2" : @"not_a_color"};
    color = [SCConfigParser colorFromDict:colorDict key:@"test"];
    XCTAssert([color isEqualToColor:[UIColor greenColor]], @"Color should be green");
}

-(void)testWithoutColor {
    NSDictionary *colorDict = @{};
    UIColor *color = [SCConfigParser colorFromDict:colorDict key:@"color"];
    XCTAssertNil(color, @"Color should be nil, we didn't specify one in the dictionary");
    
    colorDict = @{@"color" : @"FFFFFF", @"notAColor" : @"notone"};
    color = [SCConfigParser colorFromDict:colorDict key:@"notAColor"];
    XCTAssertNil(color, @"Color should be nil, there wasn't one for the specified key");
}

-(void)testColorFromDictWithNilDict {
    UIColor *color = [SCConfigParser colorFromDict:nil key:@"notAColor"];
    XCTAssertNil(color, @"Color should be nil, the dictionary was nil");
}

#pragma mark - Color Gradient From Array

-(void)testColorGradientFromArray {
    NSArray *colorGradientArray = @[@{@"position" : @1.0f, @"color" : @"000000"},
                                    @{@"position" : @0.0f, @"color" : @"FFFFFF"},
                                    @{@"position" : @0.5f, @"color" : @"FF0000"}];
    NSArray *result = [SCConfigParser colorGradientFromArray:colorGradientArray];
    
    [self checkGradientStop:result[0] IsAtPosition:1.0 withColor:[UIColor blackColor]];
    [self checkGradientStop:result[1] IsAtPosition:0.0 withColor:[UIColor whiteColor]];
    [self checkGradientStop:result[2] IsAtPosition:0.5 withColor:[UIColor redColor]];
}

-(void)testInvalidColorGradientFromArray {
    NSArray *colorGradientArray = @[@{@"b" : @1.0f, @"r" : @"000000"},
                                    @{@"p" : @0.0f, @"color" : @"FFFFFF"},
                                    @{@"r" : @0.5f}];
    NSArray *result = [SCConfigParser colorGradientFromArray:colorGradientArray];
    XCTAssert(0 == result.count, @"Shouldn't be any items in the array - none of them are valid");
}

-(void)testPartiallyInvalidColorGradientFromArray {
    NSArray *colorGradientArray = @[@{@"b" : @1.0f, @"r" : @"000000"},
                                    @{@"position" : @0.5f, @"color" : @"FFFFFF"},
                                    @{@"r" : @0.5f}];
    NSArray *result = [SCConfigParser colorGradientFromArray:colorGradientArray];
    XCTAssert(1 == result.count, @"Should be a single item in the array - one of them is valid");
    [self checkGradientStop:result[0] IsAtPosition:0.5 withColor:[UIColor whiteColor]];
}

-(void)checkGradientStop:(SCGradientStop*)stop IsAtPosition:(float)position withColor:(UIColor*)color {
    XCTAssertEqual(stop.stop, position, @"The stop's position is incorrect");
    XCTAssert([stop.color isEqualToColor:color], @"The stop's color is incorrect");
}

#pragma mark - Image Parsing

-(void)testValidImageStringReturnsUIImage {
    NSString *base64ImageString = @"data:image/gif;base64,R0lGODlhDwAPAKECAAAAzMzM/////wAAACwAAAAADwAPAAACIISPeQHsrZ5ModrLlN48CXF8m2iQ3YmmKqVlRtW4MLwWACH+H09wdGltaXplZCBieSBVbGVhZCBTbWFydFNhdmVyIQAAOw==";
    
    UIImage *image = [SCConfigParser imageFromBase64String:base64ImageString];
    
    XCTAssertNotNil(image, @"Image should not be nil. This is valid base-64 image data.");
    XCTAssertEqual(image.size, CGSizeMake(15, 15), @"Image should be 15x15");
}

-(void)testInvalidImageStringReturnsNil {
    NSString *base64ImageString = @"data:image/jpeg;base64";
    UIImage *image = [SCConfigParser imageFromBase64String:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
    
    base64ImageString = @"dyb";
    image = [SCConfigParser imageFromBase64String:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
    
    base64ImageString = nil;
    image = [SCConfigParser imageFromBase64String:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
    
    // Test a string with a length of 22 - base 64 images have a minimum length of 22.
    base64ImageString = @"1234567891123456789212";
    image = [SCConfigParser imageFromBase64String:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
    
    base64ImageString = @"12345678911234567892123";
    image = [SCConfigParser imageFromBase64String:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
    
    base64ImageString = @"123456789112345678921";
    image = [SCConfigParser imageFromBase64String:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
}

@end