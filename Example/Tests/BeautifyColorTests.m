//
//  BeautifyColorTests.m
//  Beautify
//
//  Created by Chris Grant on 13/09/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+HexColors.h"
#import "UIColor+Comparison.h"

@interface BeautifyColorTests : XCTestCase
@end

@implementation BeautifyColorTests

-(void)testColors {
    [self color:[UIColor blackColor] isEqualToHexString:@"000000"];
    [self color:[UIColor redColor] isEqualToHexString:@"FF0000"];
    [self color:[UIColor greenColor] isEqualToHexString:@"00FF00"];
    [self color:[UIColor blueColor] isEqualToHexString:@"0000FF"];
    [self color:[UIColor whiteColor] isEqualToHexString:@"FFFFFF"];
}

-(void)testAlpha {
    [self color:[[UIColor whiteColor] colorWithAlphaComponent:0.0] isEqualToHexString:@"FFFFFF00"];
    [self color:[[UIColor blackColor] colorWithAlphaComponent:0.0] isEqualToHexString:@"00000000"];
    [self color:[[UIColor whiteColor] colorWithAlphaComponent:1.0] isEqualToHexString:@"FFFFFFFF"];
    [self color:[[UIColor blackColor] colorWithAlphaComponent:1.0] isEqualToHexString:@"000000FF"];
}

-(void)testInvalidColorsReturnNil {
    [self hexStringReturnsNil:@"#zebraa"];
    [self hexStringReturnsNil:@"-11111"];
    [self hexStringReturnsNil:@"#-1111111"];
    [self hexStringReturnsNil:@"#8889102z"];
    [self hexStringReturnsNil:@"#TESTCO"];
    [self hexStringReturnsNil:@"TESTCOLO"];
}

-(void)testIncorrectLengthReturnsNil {
    [self hexStringReturnsNil:@"#f"];
    [self hexStringReturnsNil:@"#ff"];
    [self hexStringReturnsNil:@"fff"];
    [self hexStringReturnsNil:@"#ffff"];
    [self hexStringReturnsNil:@"fffff"];
    [self hexStringReturnsNil:@"#fffffff"];
    [self hexStringReturnsNil:@"fffffffff"];
    [self hexStringReturnsNil:@"ffffffffffffffff"];
    [self hexStringReturnsNil:@"0"];
    [self hexStringReturnsNil:@"00"];
    [self hexStringReturnsNil:@"#000"];
    [self hexStringReturnsNil:@"#0000"];
    [self hexStringReturnsNil:@"00ff000"];
}

-(void)testHexConversionBothWays {
    [self hexStringConvertsToColorAndBackAgainCorrectly:@"#000000ff"];
    [self hexStringConvertsToColorAndBackAgainCorrectly:@"#ffffffff"];
    [self hexStringConvertsToColorAndBackAgainCorrectly:@"#FF000000"];
    [self hexStringConvertsToColorAndBackAgainCorrectly:@"#FF00FF00"];
    [self hexStringConvertsToColorAndBackAgainCorrectly:@"#FFFF00ff"];
    [self hexStringConvertsToColorAndBackAgainCorrectly:@"#00FFFF33"];
    [self hexStringConvertsToColorAndBackAgainCorrectly:@"#FFFF0000"];
}

-(void)hexStringConvertsToColorAndBackAgainCorrectly:(NSString*)inputString {
    UIColor *color = [UIColor colorWithHexString:inputString];
    NSString *outputString = [UIColor hexValuesFromUIColor:color];
    XCTAssert([[inputString lowercaseString] isEqualToString:[outputString lowercaseString]], @"Hex values should be the same!");
}

-(void)hexStringReturnsNil:(NSString*)hexString {
    XCTAssertNil([UIColor colorWithHexString:hexString], @"An Invalid Color should return nil");
}

-(void)color:(UIColor*)color isEqualToHexString:(NSString*)hexString {
    UIColor *hex = [UIColor colorWithHexString:hexString];
    XCTAssert([hex isEqualToColor:color], @"Colors should be equal");
}

@end