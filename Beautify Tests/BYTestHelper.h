//
//  BYTestHelper.h
//  Beautify
//
//  Created by Chris Grant on 08/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>

@interface BYTestHelper : XCTestCase

-(void)assertObjectOne:(NSObject *)object isEqualToObjectTwo:(NSObject *)object2;
-(void)assertObject:(id)prop withPropertyName:(NSString*)propertyName isEqualToObject:(id)copiedProp;

-(id)styleFromDictNamed:(NSString*)name andClass:(Class)theClass;
-(void)checkObjectCanBeCopiedAndResultHasEqualProperties:(NSObject<NSCopying>*)object;
+(NSDictionary*)dictionaryFromJSONFile:(NSString*)fileName;

@end