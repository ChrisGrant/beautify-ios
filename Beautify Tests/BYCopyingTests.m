//
//  BYCopyingTests.m
//  Beautify
//
//  Created by Chris Grant on 23/09/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Beautify.h"
#import "UIColor+Comparison.h"
#import "NSObject+Properties.h"
#import "BYConfigParser_Private.h"
#import "BYStateSetter.h"

@interface BYCopyingTests : XCTestCase
@end

@implementation BYCopyingTests

#pragma mark - Properties

-(void)testBorderCopy {
    BYBorder *border = [[BYBorder alloc] initWithColor:[UIColor redColor] width:2 radius:29];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:border];
}

-(void)testFontCopy {
    BYFont *font = [[BYFont alloc] initWithName:@"HelveticaNeue-Bold" andSize:22.0f];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:font];
}

-(void)testGradientCopy {
    BYGradientStop *stop1 = [[BYGradientStop alloc] initWithColor:[UIColor redColor] at:0.1];
    BYGradientStop *stop2 = [[BYGradientStop alloc] initWithColor:[UIColor greenColor] at:2.0];
    NSArray *stops = @[stop1, stop2];
    BYGradient *gradient = [[BYGradient alloc] initWithStops:stops isRadial:YES radialOffset:CGSizeMake(20, 40)];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:gradient];
}

-(void)testGradientStopCopy {
    BYGradientStop *stop1 = [[BYGradientStop alloc] initWithColor:[UIColor redColor] at:0.5];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:stop1];
}

-(void)testNineBoxedImageCopy {
    BYNineBoxedImage *image = [[BYNineBoxedImage alloc] init];
    image.left = 23;
    image.right = 21;
    image.top = 2;
    image.bottom = 9;
    NSString *base64ImageString = @"data:image/gif;base64,R0lGODlhDwAPAKECAAAAzMzM/////wAAACwAAAAADwAPAAACIISPeQHsrZ5ModrLlN48CXF8m2iQ3YmmKqVlRtW4MLwWACH+H09wdGltaXplZCBieSBVbGVhZCBTbWFydFNhdmVyIQAAOw==";
    UIImage *im = [BYConfigParser imageFromBase64String:base64ImageString];
    image.data = im;
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:image];
}

-(void)testShadowCopy {
    BYShadow *shadow = [[BYShadow alloc] initWithOffset:CGSizeMake(10, 5) radius:4 color:[UIColor blueColor]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:shadow];
}

-(void)testTextCopy {
    BYText *text = [[BYText alloc] initWithFont:[[BYFont alloc] initWithName:@"Helvetica" andSize:24.0f] color:[UIColor orangeColor]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:text];
}

-(void)testSwitchStateCopy {
    BYSwitchState *state = [[BYSwitchState alloc] init];
    state.textStyle = [[BYText alloc] initWithFont:[[BYFont alloc] initWithName:@"ArialMT" andSize:10.0f] color:[UIColor grayColor]];
    state.text = @"Hello Hello";
    state.backgroundColor = [UIColor grayColor];
    state.textShadow = [[BYTextShadow alloc] init];
    state.textShadow.offset = CGSizeMake(23, 1);
    state.textShadow.color = [UIColor redColor];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:state];
}

-(void)testTextShadowCopy {
    BYTextShadow *shadow = [BYTextShadow new];
    shadow.offset = CGSizeMake(1, -20);
    shadow.color = [UIColor greenColor];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:shadow];
}

-(void)testDropShadowCopy {
    BYDropShadow *shadow = [[BYDropShadow alloc] initWithColor:[UIColor blueColor] andHeight:23.0f];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:shadow];
}

#pragma mark - Styles

-(void)testButtonStyleCopy {
    BYButtonStyle *style = [self styleFromDictNamed:@"ValidButtonStyle" andClass:[BYButtonStyle class]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:style];
}

-(void)testImageViewStyleCopy {
    BYImageViewStyle *style = [self styleFromDictNamed:@"ValidImageViewStyle" andClass:[BYImageViewStyle class]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:style];
}

-(void)testLabelStyleCopy {
    BYLabelStyle *style = [self styleFromDictNamed:@"ValidLabelStyle" andClass:[BYLabelStyle class]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:style];
}

-(void)testNavigationBarStyleCopy {
    BYNavigationBarStyle *style = [self styleFromDictNamed:@"ValidNavigationBarStyle" andClass:[BYNavigationBarStyle class]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:style];
}

-(void)testSliderStyleCopy {
    BYSliderStyle *style = [self styleFromDictNamed:@"ValidSliderStyle" andClass:[BYSliderStyle class]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:style];
}

-(void)testSwitchStyleCopy {
    BYSwitchStyle *style = [self styleFromDictNamed:@"ValidSwitchStyle" andClass:[BYSwitchStyle class]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:style];
}

-(void)testTableViewCellStyleCopy {
    BYTableViewCellStyle *style = [self styleFromDictNamed:@"ValidTableViewCellStyle" andClass:[BYTableViewCellStyle class]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:style];
}

-(void)testViewControllerStyleCopy {
    BYViewControllerStyle *style = [self styleFromDictNamed:@"ValidVCStyle" andClass:[BYViewControllerStyle class]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:style];
}

#pragma mark - Theme

-(void)testThemeCopy {
    
}

#pragma mark - Helper methods

-(id)styleFromDictNamed:(NSString*)name andClass:(Class)class {
    NSDictionary *dictionary = [BYCopyingTests dictionaryFromJSONFile:name];
    return [BYConfigParser parseStyleObjectPropertiesOnClass:class fromDict:dictionary];
}

-(void)assertObject:(id)prop withPropertyName:(NSString*)propertyName isEqualToObject:(id)copiedProp {
//    XCTAssert([prop isKindOfClass:[copiedProp class]],
//                   @"Property %@ should have the same class (%@ and %@)", propertyName, [prop class], [copiedProp class]);
    
    if([prop isKindOfClass:[NSNumber class]]) {
        XCTAssertEqual([prop floatValue], [copiedProp floatValue], @"Should have equal %@", propertyName);
    }
    else if ([prop isKindOfClass:[UIColor class]]) {
        XCTAssert([prop isEqualToColor:copiedProp], @"Should have equal %@", propertyName);
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
    else if ([[self allowedClassSet] containsObject:[prop class]]) {
        [self assertObjectOne:prop isEqualToObjectTwo:copiedProp];
    }
    else {
        // If it's not a class we are expecting, then log that we don't know what it is here.
        XCTFail(@"ERROR: Tests did not check %@ on class %@. Unknown class type.", propertyName, [prop class]);
    }
}

NSSet *backingClassSet;
-(NSSet*)allowedClassSet {
    if(!backingClassSet) {
        backingClassSet = [NSSet setWithArray:@[[BYGradientStop class], [BYFont class], [BYTextShadow class],
                                                [BYText class], [BYGradient class], [BYShadow class],
                                                [BYStateSetter class], [BYBorder class], [BYDropShadow class],
                                                [BYSwitchState class], [BYNineBoxedImage class]]];
    }
    return backingClassSet;
}

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

-(void)checkObjectCanBeCopiedAndResultHasEqualProperties:(NSObject<NSCopying>*)object {
    NSObject *object2;
    XCTAssertNoThrow(object2 = [object copy], @"Should be able to create a copy");
    XCTAssertNotNil(object2, @"Copy should not be nil");
    XCTAssertNotEqualObjects(object, object2, @"Should be different objects");
    XCTAssertEqual([object class], [object2 class], @"Should have the same class (%@)", [object class]);
    
    [self assertObjectOne:object isEqualToObjectTwo:object2];
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