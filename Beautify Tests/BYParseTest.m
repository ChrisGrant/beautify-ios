//
//  BYParseTest.m
//  Beautify
//
//  Created by Chris Grant on 25/09/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Beautify.h"

@interface BYParseTest : XCTestCase

@end

@implementation BYParseTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    NSError *error;
    NSDictionary *dict = [BYParseTest dictionaryFromJSONFile:@"dark"];
    BYTheme *theme = [[BYTheme alloc] initWithDictionary:dict[@"theme"] error:&error];
    
    NSLog(@"%@", error.debugDescription);
}

+(NSDictionary*)dictionaryFromJSONFile:(NSString*)fileName {
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