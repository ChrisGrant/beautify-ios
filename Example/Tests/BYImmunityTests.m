//
//  BYImmunityTests.m
//  Beautify
//
//  Created by Chris Grant on 10/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Beautify.h"

@interface BYImmunityTests : XCTestCase
@end

@implementation BYImmunityTests

-(void)testDefault {
    UIView *view = [UIView new];
    XCTAssertFalse([view isImmuneToBeautify], @"Should not be immune by default!");
}

-(void)testImmune {
    UIView *view = [UIView new];
    [view setImmuneToBeautify:YES];
    XCTAssertTrue([view isImmuneToBeautify], @"Should be immune after being set to YES!");
}

-(void)testImmuneThenNotImmune {
    UIView *view = [UIView new];
    [view setImmuneToBeautify:YES];
    XCTAssertTrue([view isImmuneToBeautify], @"Should be immune after being set to YES!");
    
    [view setImmuneToBeautify:NO];
    XCTAssertFalse([view isImmuneToBeautify], @"Should no longer be immune!");
}

-(void)testImmuneThenNotImmuneThenImmnue {
    UIView *view = [UIView new];
    [view setImmuneToBeautify:YES];
    XCTAssertTrue([view isImmuneToBeautify], @"Should be immune after being set to YES!");
    
    [view setImmuneToBeautify:NO];
    XCTAssertFalse([view isImmuneToBeautify], @"Should no longer be immune!");
    
    [view setImmuneToBeautify:YES];
    XCTAssertTrue([view isImmuneToBeautify], @"Should be immune after being set to YES!");
}

-(void)testDefaultImageViewImmunity {
    UIImageView *iv = [UIImageView new];
    XCTAssertTrue([iv isImmuneToBeautify], @"Should be immune by default!");
}

-(void)testNonImmuneImageView {
    UIImageView *iv = [UIImageView new];
    [iv setImmuneToBeautify:NO];
    XCTAssertFalse([iv isImmuneToBeautify], @"Should not be immune any longer!");
}

-(void)testNonImmuneThenImmuneImageView {
    UIImageView *iv = [UIImageView new];
    [iv setImmuneToBeautify:NO];
    XCTAssertFalse([iv isImmuneToBeautify], @"Should not be immune!");
    
    [iv setImmuneToBeautify:YES];
    XCTAssertTrue([iv isImmuneToBeautify], @"Should be immune again!");
}

-(void)testDefaultThenNonImmuneThenImmuneThenNonImmuneImageView {
    UIImageView *iv = [UIImageView new];
    XCTAssertTrue([iv isImmuneToBeautify], @"Should be immune by default!");
    
    [iv setImmuneToBeautify:NO];
    XCTAssertFalse([iv isImmuneToBeautify], @"Should no longer be immune!");
    
    [iv setImmuneToBeautify:YES];
    XCTAssertTrue([iv isImmuneToBeautify], @"Should be immune after being set to YES!");
    
    [iv setImmuneToBeautify:NO];
    XCTAssertFalse([iv isImmuneToBeautify], @"Should no longer be immune!");
}

@end