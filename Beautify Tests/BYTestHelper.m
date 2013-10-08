//
//  BYTestHelper.m
//  Beautify
//
//  Created by Chris Grant on 08/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+Comparison.h"
#import "NSObject+Properties.h"
#import "BYTestHelper.h"

@implementation BYTestHelper

-(void)assertObjectOne:(NSObject *)object isEqualToObjectTwo:(NSObject *)object2 {
    NSArray *properties = [NSObject propertyNames:[object class]];
    
    for (NSString *propertyName in properties) {
        id prop = [object valueForKey:propertyName];
        id copiedProp = [object2 valueForKey:propertyName];
        if(prop == nil && copiedProp == nil) {
            return;
        }
        [self assertObject:prop withPropertyName:propertyName isEqualToObject:copiedProp];
    }
}

-(void)assertObject:(id)prop withPropertyName:(NSString*)propertyName isEqualToObject:(id)copiedProp {
    
    if([prop isKindOfClass:[NSNumber class]]) {
        XCTAssertEqual([prop floatValue], [copiedProp floatValue], @"Should have equal %@", propertyName);
    }
    else if ([prop isKindOfClass:[UIColor class]]) {
        XCTAssert([prop isEqualToColor:copiedProp], @"Should have equal %@. %@ and %@", propertyName, prop, copiedProp);
    }
    else if ([prop isKindOfClass:[NSString class]]) {
        XCTAssert([prop isEqualToString:copiedProp], @"Strings should be equal!");
    }
    else if ([prop isKindOfClass:[NSArray class]]) {
        NSLog(@"Array");
        NSArray *array = prop;
        NSArray *copiedArray = copiedProp;
        XCTAssertEqual(array.count, copiedArray.count, @"Array for %@ should have the same length", propertyName);
        
        // For arrays, we call this method again, but for each item in the array.
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            // Check obj is equal with its corresponding object in the copied array.
            id copiedObj = copiedArray[idx];
            [self assertObject:copiedObj withPropertyName:propertyName isEqualToObject:copiedObj];
        }];
    }
    else if ([prop isKindOfClass:[NSValue class]]) {
        XCTAssert([prop isEqual:copiedProp], @"Should be equal values");
    }
    else if ([prop isKindOfClass:[UIImage class]]) {
        UIImage *image = prop;
        UIImage *copiedImage = copiedProp;
        XCTAssert([UIImagePNGRepresentation(image) isEqualToData:UIImagePNGRepresentation(copiedImage)], @"Image data should be equal!");
    }
    else {
        [self assertObjectOne:prop isEqualToObjectTwo:copiedProp];
    }
}

@end