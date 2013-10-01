//
//  ConfigParserUtilitiesTests.m
//  Beautify
//
//  Created by Chris Grant on 13/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+Comparison.h"
#import "BYGradientStop.h"
#import "JSONValueTransformer.h"
#import "JSONValueTransformer+BeautifyExtension.h"

@interface ConfigParserUtilitiesTests : XCTestCase
@end

@implementation ConfigParserUtilitiesTests {
    JSONValueTransformer *_valueTransformer;
}

-(void)setUp {
    _valueTransformer = [JSONValueTransformer new];
}

#pragma mark - Size from dictionary

-(void)testSizeFromDictionaryWithValidSizes {
    NSDictionary *validDict = [NSDictionary new];
    
    validDict = @{@"x": @"", @"y": @""};
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:validDict], CGSizeZero, @"Empty values dictionary - size should be zero");
    
    validDict = @{@"x": @"10", @"y": @"10"};
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:validDict], CGSizeMake(10, 10), @"This should be a valid dictionary");
    
    validDict = @{@"y": @"120", @"x": @"5"};
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:validDict], CGSizeMake(5, 120), @"This should be a valid dictionary");
    
    validDict = @{@"x": @"2"};
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:validDict], CGSizeMake(2, 0), @"This should be a valid dictionary");
    
    validDict = @{@"y": @"9"};
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:validDict], CGSizeMake(0, 9), @"This should be a valid dictionary");
}

-(void)testSizeFromDictionaryWithInvalidSizes {
    NSDictionary *invalidDict = [NSDictionary new];
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:invalidDict], CGSizeZero, @"Empty dictionary - size should be zero");
    
    invalidDict = @{@"x": @"", @"y": @""};
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:invalidDict], CGSizeZero, @"Empty values dictionary - size should be zero");
    
    invalidDict = @{@"x": @"", @"y": @""};
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:invalidDict], CGSizeZero, @"Empty values dictionary - size should be zero");
    
    invalidDict = @{@"x": @"a", @"y": @"a"};
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:invalidDict], CGSizeZero, @"Invalid values in dictionary - size should be zero");
    
    invalidDict = @{@"x": @"a1a", @"y": @"a2"};
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:invalidDict], CGSizeZero, @"Invalid values in dictionary - size should be zero");
    
    invalidDict = @{@"y": @"-"};
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:invalidDict], CGSizeZero, @"Invalid values in dictionary - size should be zero");
}

-(void)testSizeFromDictionaryWithNoDictionary {
    XCTAssertEqual([_valueTransformer CGSizeFromNSDictionary:nil], CGSizeZero, @"Without a dictionary, size should be CGSizeZero");
}

#pragma mark - State From String

-(void)testStateFromStringWithNormalValues {
    XCTAssert(UIControlStateHighlighted == [_valueTransformer stateFromString:@"highlighted"],
              @"highlighted should return UIControlStateHighlighted");
    XCTAssert(UIControlStateDisabled == [_valueTransformer stateFromString:@"disabled"],
              @"disabled should return UIControlStateHighlighted");
    XCTAssert(UIControlStateSelected == [_valueTransformer stateFromString:@"selected"],
              @"selected should return UIControlStateHighlighted");
    XCTAssert(UIControlStateNormal == [_valueTransformer stateFromString:@"normal"],
              @"normal should return UIControlStateHighlighted");
}

-(void)testStateFromStringWithAllCapsValue {
    XCTAssert(UIControlStateHighlighted == [_valueTransformer stateFromString:@"HIGHLIGHTED"],
              @"highlighted should return UIControlStateHighlighted");
    XCTAssert(UIControlStateDisabled == [_valueTransformer stateFromString:@"DISABLED"],
              @"disabled should return UIControlStateHighlighted");
    XCTAssert(UIControlStateSelected == [_valueTransformer stateFromString:@"SELECTED"],
              @"selected should return UIControlStateHighlighted");
    XCTAssert(UIControlStateNormal == [_valueTransformer stateFromString:@"NORMAL"],
              @"normal should return UIControlStateHighlighted");
}

-(void)testStateFromStringWithMixedCaseValues {
    XCTAssert(UIControlStateHighlighted == [_valueTransformer stateFromString:@"highLIghteD"],
              @"highlighted should return UIControlStateHighlighted");
    XCTAssert(UIControlStateDisabled == [_valueTransformer stateFromString:@"disABLED"],
              @"disabled should return UIControlStateHighlighted");
    XCTAssert(UIControlStateSelected == [_valueTransformer stateFromString:@"SELected"],
              @"selected should return UIControlStateHighlighted");
    XCTAssert(UIControlStateNormal == [_valueTransformer stateFromString:@"norMAL"],
              @"normal should return UIControlStateHighlighted");
}

-(void)testStateFromStringWithInvalidValue {
    XCTAssert(UIControlStateNormal == [_valueTransformer stateFromString:@"invalid"],
              @"Invalid values should default to UIControlStateNormal");
    XCTAssert(UIControlStateNormal == [_valueTransformer stateFromString:nil],
              @"nil values should default to UIControlStateNormal");
}

#pragma mark - Image Parsing

-(void)testValidImageStringReturnsUIImage {
    NSString *base64ImageString = @"data:image/gif;base64,R0lGODlhDwAPAKECAAAAzMzM/////wAAACwAAAAADwAPAAACIISPeQHsrZ5ModrLlN48CXF8m2iQ3YmmKqVlRtW4MLwWACH+H09wdGltaXplZCBieSBVbGVhZCBTbWFydFNhdmVyIQAAOw==";
    
    UIImage *image = [_valueTransformer UIImageFromNSString:base64ImageString];
    
    XCTAssertNotNil(image, @"Image should not be nil. This is valid base-64 image data.");
    XCTAssertEqual(image.size, CGSizeMake(15, 15), @"Image should be 15x15");
}

-(void)testInvalidImageStringReturnsNil {
    NSString *base64ImageString = @"data:image/jpeg;base64";
    UIImage *image = [_valueTransformer UIImageFromNSString:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
    
    base64ImageString = @"dyb";
    image = [_valueTransformer UIImageFromNSString:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
    
    base64ImageString = nil;
    image = [_valueTransformer UIImageFromNSString:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
    
    // Test a string with a length of 22 - base 64 images have a minimum length of 22.
    base64ImageString = @"1234567891123456789212";
    image = [_valueTransformer UIImageFromNSString:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
    
    base64ImageString = @"12345678911234567892123";
    image = [_valueTransformer UIImageFromNSString:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
    
    base64ImageString = @"123456789112345678921";
    image = [_valueTransformer UIImageFromNSString:base64ImageString];
    XCTAssertNil(image, @"Image should be nil. Invalid base-64 image data.");
}

@end