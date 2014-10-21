//
//  ConfigParserPropertyParsingTests.m
//  Beautify
//
//  Created by Chris Grant on 13/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BYTextShadow.h"
#import "UIColor+Comparison.h"
#import "BYStateSetter.h"
#import "BYShadow.h"
#import "BYGradientStop.h"
#import "BYBackgroundImage.h"
#import "BYSwitchState.h"
#import "BYSwitchStyle.h"
#import "BYFont.h"
#import "BYGradient.h"

@interface ConfigParserPropertyParsingTests : XCTestCase
@end

@implementation ConfigParserPropertyParsingTests

#pragma mark - Text Shadows

-(void)testTextShadowFromDictWithValidDict {
    BYTextShadow *shadow = [[BYTextShadow alloc] initWithDictionary:@{@"color":@"ffffff", @"offset":@{@"x":@12, @"y":@2}} error:nil];
    XCTAssert([shadow.color isEqualToColor:[UIColor whiteColor]], @"Color should be white!");
    XCTAssertTrue(CGSizeEqualToSize(shadow.offset, CGSizeMake(12, 2)));
}

-(void)testTextShadowFromDictWithNilDict {
    BYTextShadow *shadow = [[BYTextShadow alloc] initWithDictionary:nil error:nil];
    XCTAssertNil(shadow, @"Shadow should be nil with a nil dictionary");
}

-(void)testTextShadowFromDictWithNoOffsetDict {
    BYTextShadow *shadow = [[BYTextShadow alloc] initWithDictionary:@{@"color":@"ffffff"} error:nil];
    XCTAssertNil(shadow, @"Shadow should be nil without an offset");
}

-(void)testTextShadowFromDictWithOnlyOffsetDict {
    BYTextShadow *shadow = [[BYTextShadow alloc] initWithDictionary:@{@"offset":@{@"x":@3, @"y":@9}} error:nil];
    XCTAssertNotNil(shadow, @"Shadow should not be nil");
    XCTAssertNil(shadow.color, @"We did not specify a color so there shouldn't be one");
    XCTAssertTrue(CGSizeEqualToSize(shadow.offset, CGSizeMake(3, 9)), @"Shadow should have an offset of 3,9");
}

#pragma mark - State Setters

-(void)testStateSetterFromDictWithValidDict {
    BYStateSetter *stateSetter = [[BYStateSetter alloc] initWithDictionary:@{@"propertyName" : @"titleShadow",
                                                                             @"state" : @"highlighted",
                                                                             @"value" : @{@"color" : @"FF0000",
                                                                                          @"offset" : @{@"x": @9,
                                                                                                        @"y": @2}
                                                                                          }
                                                                             } error:nil];
    XCTAssert(stateSetter.state == UIControlStateHighlighted, @"Should be for the highlighted state");
    XCTAssertEqual(stateSetter.propertyName, @"titleShadow", @"Should be for the title shadow property");
    XCTAssert([(NSObject*)stateSetter.value isKindOfClass:[BYTextShadow class]], @"Value should be a text shadow!");
    
    BYTextShadow *shadow = (BYTextShadow*)stateSetter.value;
    XCTAssertNotNil(shadow, @"Shadow should not be nil");
    XCTAssert([shadow.color isEqualToColor:[UIColor redColor]], @"Color should be red!");
    XCTAssertTrue(CGSizeEqualToSize(shadow.offset, CGSizeMake(9, 2)), @"Shadow should have an offset of 9,2");
}

-(void)testStateSetterFromDictWithoutState {
    BYStateSetter *stateSetter = [[BYStateSetter alloc] initWithDictionary:@{@"propertyName" : @"titleShadow",
                                                                             @"value" : @{@"color" : @"FF0000",
                                                                                          @"offset" : @{@"x": @9,
                                                                                                        @"y": @2}}} error:nil];
    XCTAssertNil(stateSetter, @"Should be nil if we don't specify a state");
}

-(void)testStateSetterFromDictWithoutPropertyName {
    BYStateSetter *stateSetter = [[BYStateSetter alloc] initWithDictionary:@{@"state" : @"highlighted",
                                                                             @"value" : @{@"color" : @"FF0000",
                                                                                          @"offset" : @{@"x": @9,
                                                                                                        @"y": @2}}} error:nil];
    XCTAssertNil(stateSetter, @"Should be nil if we don't specify a state");
}

#pragma mark - Switch State

-(void)testSwitchStateWithValidDict {
    BYSwitchState *switchState = [[BYSwitchState alloc] initWithDictionary:@{@"text" : @"ON",
                                                                             @"textStyle" : @{@"font" : @{@"name" : @"Helvetica-Neue",
                                                                                                          @"size" : @12},
                                                                                              @"color" : @"000000"},
                                                                             @"backgroundColor" : @"0000FF",
                                                                             @"textShadow" : @{@"color" : @"00FF00",
                                                                                               @"offset" : @{@"x": @1,
                                                                                                             @"y": @2}}} error:nil];
    XCTAssertNotNil(switchState, @"Switch State should not be nil with this valid dictionary");
    XCTAssertEqual(switchState.text, @"ON", @"Switch state should have text ON");
    
    XCTAssert([switchState.textStyle.color isEqualToColor:[UIColor blackColor]], @"Should be black");
    XCTAssertEqual(switchState.textStyle.font.name, @"Helvetica-Neue", @"Should be helvetica-neue");
    XCTAssertEqual(switchState.textStyle.font.size, 12.0f, @"Should be size 12");
    
    XCTAssert([switchState.backgroundColor isEqualToColor:[UIColor blueColor]], @"Should be blue");
    
    XCTAssert([switchState.textShadow.color isEqualToColor:[UIColor greenColor]], @"Should be green");
    
    XCTAssertTrue(CGSizeEqualToSize(switchState.textShadow.offset, CGSizeMake(1, 2)), @"Should have offset, 1,2");
}

-(void)testSwitchStateWithoutText {
    BYSwitchState *switchState = [[BYSwitchState alloc] initWithDictionary:@{@"textStyle" : @{@"font" : @{@"name" : @"Helvetica-Neue",
                                                                                                          @"size" : @12},
                                                                                              @"color" : @"000000"},
                                                                             @"backgroundColor" : @"0000FF",
                                                                             @"textShadow" : @{@"color" : @"00FF00",
                                                                                               @"offset" : @{@"x": @1,
                                                                                                             @"y": @2}}} error:nil];
    XCTAssertNotNil(switchState, @"Switch State should not be nil with this valid dictionary");
    
    XCTAssert([switchState.textStyle.color isEqualToColor:[UIColor blackColor]], @"Should be black");
    XCTAssertEqual(switchState.textStyle.font.name, @"Helvetica-Neue", @"Should be helvetica-neue");
    XCTAssertEqual(switchState.textStyle.font.size, 12.0f, @"Should be size 12");
    
    XCTAssert([switchState.backgroundColor isEqualToColor:[UIColor blueColor]], @"Should be blue");
    
    XCTAssert([switchState.textShadow.color isEqualToColor:[UIColor greenColor]], @"Should be green");
    
    XCTAssertTrue(CGSizeEqualToSize(switchState.textShadow.offset, CGSizeMake(1, 2)), @"Should have offset, 1,2");
}

-(void)testSwitchStateWithoutTextStyle {
    BYSwitchState *switchState = [[BYSwitchState alloc] initWithDictionary:@{@"backgroundColor" : @"0000FF",
                                                                             @"textShadow" : @{@"color" : @"00FF00",
                                                                                               @"offset" : @{@"x": @1,
                                                                                                             @"y": @2}}} error:nil];
    XCTAssertNotNil(switchState, @"Switch State should not be nil with this valid dictionary");
    
    XCTAssert([switchState.backgroundColor isEqualToColor:[UIColor blueColor]], @"Should be blue");
    
    XCTAssert([switchState.textShadow.color isEqualToColor:[UIColor greenColor]], @"Should be green");
    XCTAssertTrue(CGSizeEqualToSize(switchState.textShadow.offset, CGSizeMake(1, 2)), @"Should have offset, 1,2");
}

-(void)testSwitchStateWithNoDictionary {
    BYSwitchState *state = [[BYSwitchState alloc] initWithDictionary:nil error:nil];
    XCTAssertNil(state, @"State should be nil if the dictionary is nil");
}

#pragma mark - Shadows

-(void)testShadowsFromDictWithValidDict {
    BYShadow *shadow = [[BYShadow alloc] initWithDictionary:@{@"radius": @2,
                                                              @"offset": @{@"x": @3, @"y": @2},
                                                              @"color": @"#0000FF"} error:nil];
    XCTAssertEqual(2.0f, shadow.radius, @"Shadow radius should be 2");
    XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(3, 2), shadow.offset), @"Offset should be 3, 2");
    XCTAssert([shadow.color isEqualToColor:[UIColor blueColor]], @"Color should be blue");
}

-(void)testShadowsFromDictWithPartialDict {
    BYShadow *shadow = [[BYShadow alloc] initWithDictionary:@{@"radius": @2,
                                                              @"color": @"#0000FF"} error:nil];
    XCTAssertEqual(2.0f, shadow.radius, @"Shadow radius should be 2");
    XCTAssertTrue(CGSizeEqualToSize(CGSizeZero, shadow.offset), @"Should be a zero shadow offset if we don't specify one.");
    XCTAssert([shadow.color isEqualToColor:[UIColor blueColor]], @"Color should be blue");
    
    shadow = [[BYShadow alloc] initWithDictionary:@{@"radius": @2} error:nil];
    XCTAssertEqual(2.0f, shadow.radius, @"Shadow radius should be 2");
    XCTAssertTrue(CGSizeEqualToSize(CGSizeZero, shadow.offset), @"Should be a zero shadow offset if we don't specify one.");
    XCTAssertNil(shadow.color, @"Color should be nil if we don't specify one");
    
    shadow = [[BYShadow alloc] initWithDictionary:@{@"color": @"00FF00"} error:nil];
    XCTAssertEqual(0.0f, shadow.radius, @"Shadow radius should be 0");
    XCTAssertTrue(CGSizeEqualToSize(CGSizeZero, shadow.offset), @"Should be a zero shadow offset if we don't specify one.");
    XCTAssert([shadow.color isEqual:[UIColor greenColor]], @"Color should be green.");
}

-(void)testShadowsFromDictWithInvalidDict {
    BYShadow *shadow = [[BYShadow alloc] initWithDictionary:nil error:nil];
    XCTAssertNil(shadow, @"Shadow should be nil if the dictionary is nil");
}

#pragma mark - Gradients

-(void)testValidGradientFromDict {
    BYGradient *gradient = [[BYGradient alloc] initWithDictionary:@{@"radial": @YES,
                                                                    @"radialOffset": @{@"x": @20, @"y":@30},
                                                                    @"stops":@[@{@"position":@0.1, @"color": @"FF0000"},
                                                                               @{@"position":@0.5, @"color": @"00FF00"},
                                                                               @{@"position":@0.8, @"color": @"0000FF"}]
                                                                    } error:nil];
    
    XCTAssertEqual(gradient.radial, YES, @"Gradient should be radial");
    XCTAssertTrue(CGSizeEqualToSize(gradient.radialOffset, CGSizeMake(20, 30)), @"Radial offset should be 20, 30");
    XCTAssertEqual((NSUInteger)3, gradient.stops.count, @"Should be 3 stops");
    
    BYGradientStop *stop1 = gradient.stops[0];
    BYGradientStop *stop2 = gradient.stops[1];
    BYGradientStop *stop3 = gradient.stops[2];
    
    XCTAssertEqual(stop1.position, 0.1f, @"Should have a position of 0.1");
    XCTAssert([stop1.color isEqualToColor:[UIColor redColor]], @"Should be a red stop");
    XCTAssertEqual(stop2.position, 0.5f, @"Should have a position of 0.5");
    XCTAssert([stop2.color isEqualToColor:[UIColor greenColor]], @"Should be a green stop");
    XCTAssertEqual(stop3.position, 0.8f, @"Should have a position of 0.8");
    XCTAssert([stop3.color isEqualToColor:[UIColor blueColor]], @"Should be a blue stop");
    
    gradient = [[BYGradient alloc] initWithDictionary:@{@"radial": @NO,
                                                        @"stops":@[@{@"position":@0.0, @"color": @"000000"},
                                                                   @{@"position":@1.0, @"color": @"FF0000"}]
                                                        } error:nil];
    
    XCTAssertEqual(gradient.radial, NO, @"Gradient shouldn't be radial");
    XCTAssertTrue(CGSizeEqualToSize(gradient.radialOffset, CGSizeZero), @"Radial offset should 0,0");
    XCTAssertEqual((NSUInteger)2, gradient.stops.count, @"Should be 2 stops");
    
    stop1 = gradient.stops[0];
    stop2 = gradient.stops[1];
    
    XCTAssertEqual(stop1.position, 0.0f, @"Should have a position of 0.0");
    XCTAssert([stop1.color isEqualToColor:[UIColor blackColor]], @"Should be a black stop");
    XCTAssertEqual(stop2.position, 1.0f, @"Should have a position of 1.0");
    XCTAssert([stop2.color isEqualToColor:[UIColor redColor]], @"Should be a red stop");
}

-(void)testGradientFromDictWithPartialDict {
    BYGradient *gradient = [[BYGradient alloc] initWithDictionary:@{@"radialOffset": @{@"x": @20, @"y":@30},
                                                              @"stops":@[@{@"position":@0.1, @"color": @"FF0000"},
                                                                         @{@"position":@0.5, @"color": @"00FF00"},
                                                                         @{@"position":@0.8, @"color": @"0000FF"}]
                                                              } error:nil];
    XCTAssertNotNil(gradient, @"If we don't specify radial, gradient should still not be nil");
    
    gradient = [[BYGradient alloc] initWithDictionary:@{@"radialOffset": @{@"x": @20, @"y":@30},
                                                  @"radial": @NO} error:nil];
    XCTAssertNil(gradient, @"If we don't specify stops, gradient should always be nil");
}

-(void)testGradientFromDictWithInvalidDict {
    BYGradient *gradient = [[BYGradient alloc] initWithDictionary:nil error:nil];
    XCTAssertNil(gradient, @"Gradient should be nil if the dictionary is nil");
    
    gradient = [[BYGradient alloc] initWithDictionary:@{} error:nil];
    XCTAssertNil(gradient, @"Gradient should be nil if the dictionary doesn't have the neccesary data");
    
    gradient = [[BYGradient alloc] initWithDictionary:@{@"This is not a gradient" : @"Shouldnt be able to parse it!"} error:nil];
    XCTAssertNil(gradient, @"Gradient should be nil if the dictionary doesn't have the neccesary data");
}

#pragma mark - Background Images

-(void)testValidBackgroundImageFromDict {
    NSString *base64ImageString = @"data:image/gif;base64,R0lGODlhDwAPAKECAAAAzMzM/////wAAACwAAAAADwAPAAACIISPeQHsrZ5ModrLlN48CXF8m2iQ3YmmKqVlRtW4MLwWACH+H09wdGltaXplZCBieSBVbGVhZCBTbWFydFNhdmVyIQAAOw==";
    BYBackgroundImage *bgIm = [[BYBackgroundImage alloc] initWithDictionary:@{@"data":base64ImageString,
                                                                        @"contentMode":@"fill"} error:nil];
    XCTAssertNotNil(bgIm, @"Image shouldn't be nil");
    XCTAssertNotNil(bgIm.data, @"Image's image shouldn't be nil");
    XCTAssertTrue(CGSizeEqualToSize(bgIm.data.size, CGSizeMake(15, 15)), @"Image should be 15x15");
    
    XCTAssertEqual(bgIm.contentMode, BYImageContentModeFill, @"Should be fill");
    
    bgIm = [[BYBackgroundImage alloc] initWithDictionary:@{@"data":base64ImageString,
                                                     @"contentMode":@"aspectFill"} error:nil];
    XCTAssertEqual(bgIm.contentMode, BYImageContentModeAspectFill, @"Should be aspect fill");
    
    bgIm = [[BYBackgroundImage alloc] initWithDictionary:@{@"data":base64ImageString,
                                                     @"contentMode":@"tile"} error:nil];
    XCTAssertEqual(bgIm.contentMode, BYImageContentModeTile, @"Should be tile");
    
    bgIm = [[BYBackgroundImage alloc] initWithDictionary:@{@"data":base64ImageString,
                                                     @"contentMode":@"ASPECTFILl"} error:nil];
    XCTAssertEqual(bgIm.contentMode, BYImageContentModeAspectFill, @"Should be aspect fill");
    
    bgIm = [[BYBackgroundImage alloc] initWithDictionary:@{@"data":base64ImageString,
                                                     @"contentMode":@"Tile"} error:nil];
    XCTAssertEqual(bgIm.contentMode, BYImageContentModeTile, @"Should be tile");
}

@end