//
//  BYSerializationTests.m
//  Beautify
//
//  Created by Chris Grant on 03/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BYTheme.h"

@interface BYSerializationTests : XCTestCase

@end

@implementation BYSerializationTests

-(void)testExample {
    BYTheme *theme = [BYTheme new];
    NSString *json;
    XCTAssertNoThrow(json = [theme toJSONString], @"Shouldn't throw when exporting default theme to JSON");
    XCTAssertNotNil(json, @"JSON should not be nil");
}

@end