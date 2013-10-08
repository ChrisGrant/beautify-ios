//
//  BYSerializationTests.m
//  Beautify
//
//  Created by Chris Grant on 03/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "BYTheme.h"
#import "NSObject+Properties.h"
#import "UIColor+Comparison.h"
#import "Beautify.h"
#import "BYTestHelper.h"

@interface BYSerializationTests : BYTestHelper
@end

@implementation BYSerializationTests

-(void)testDefaultTheme {
    BYTheme *theme = [BYTheme new];
    NSString *json;
    XCTAssertNoThrow(json = [theme toJSONString], @"Shouldn't throw when exporting default theme to JSON");
    XCTAssertNotNil(json, @"JSON should not be nil");
    
    NSError *jsonSerializationError;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingAllowFragments
                                                           error:&jsonSerializationError];
    XCTAssertNil(jsonSerializationError, @"Shouldn't be an error converting the JSON to a dictionary");
    
    NSError *themeCreationError;
    BYTheme *theme2 = [[BYTheme alloc] initWithDictionary:dict error:&themeCreationError];
    XCTAssertNil(themeCreationError, @"Shouldn't be an error creating a theme from the dictionary");
    XCTAssertNotNil(theme2, @"Theme should not be nil!");
    
    [self assertObjectOne:theme2 isEqualToObjectTwo:theme];
}

@end