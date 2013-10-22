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
#import "BYJSONVersion.h"

@interface BYSerializationTests : BYTestHelper
@end

@implementation BYSerializationTests

-(void)testSerializeThenDeserializeDefaultTheme {
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

-(void)testThemeWrapping {
    BYTheme *theme = [BYTheme new];
    NSDictionary *json;
    XCTAssertNoThrow(json = [theme toDictionary], @"Yo, this shouldn't throw when exporting the default theme to a dictionary B!");
    XCTAssertNotNil(json, @"Dictionary should not be nil");
    
    XCTAssert([json.allKeys containsObject:@"theme"], @"There should be a \"theme\" key in the dictionary!");
    XCTAssert([json.allKeys containsObject:@"schemaVersion"], @"There should be a \"schemaVersion\" key in the dictionary!");
    
    XCTAssert([json[@"schemaVersion"] isEqualToString:JSON_SCHEMA_VERSION], @"Schema version should be equal");
}

@end