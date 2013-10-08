//
//  BYCopyingTests.m
//  Beautify
//
//  Created by Chris Grant on 23/09/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "Beautify.h"
#import "UIColor+Comparison.h"
#import "NSObject+Properties.h"
#import "BYStateSetter.h"
#import "JSONValueTransformer+BeautifyExtension.h"
#import "BYTestHelper.h"

@interface BYCopyingTests : BYTestHelper
@end

@implementation BYCopyingTests

#pragma mark - Properties

-(void)testBorderCopy {
    BYBorder *border = [BYBorder borderWithColor:[UIColor redColor] width:2 radius:29];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:border];
}

-(void)testFontCopy {
    BYFont *font = [BYFont fontWithName:@"HelveticaNeue-Bold" andSize:22.0f];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:font];
}

-(void)testGradientCopy {
    BYGradientStop *stop1 = [BYGradientStop stopWithColor:[UIColor redColor] at:0.1];
    BYGradientStop *stop2 = [BYGradientStop stopWithColor:[UIColor greenColor] at:2.0];
    NSArray *stops = @[stop1, stop2];
    BYGradient *gradient = [BYGradient gradientWithStops:stops isRadial:YES radialOffset:CGSizeMake(20, 40)];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:gradient];
}

-(void)testGradientStopCopy {
    BYGradientStop *stop1 = [BYGradientStop stopWithColor:[UIColor redColor] at:0.5];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:stop1];
}

-(void)testBackgroundImageCopy {
    BYBackgroundImage *image = [[BYBackgroundImage alloc] init];
    NSString *base64ImageString = @"data:image/gif;base64,R0lGODlhDwAPAKECAAAAzMzM/////wAAACwAAAAADwAPAAACIISPeQHsrZ5ModrLlN48CXF8m2iQ3YmmKqVlRtW4MLwWACH+H09wdGltaXplZCBieSBVbGVhZCBTbWFydFNhdmVyIQAAOw==";
    JSONValueTransformer *vt = [JSONValueTransformer new];
    UIImage *im = [vt UIImageFromNSString:base64ImageString];
    image.data = im;
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:image];
}

-(void)testShadowCopy {
    BYShadow *shadow = [BYShadow shadowWithOffset:CGSizeMake(10, 5) radius:4 color:[UIColor blueColor]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:shadow];
}

-(void)testTextCopy {
    BYText *text = [BYText textWithFont:[BYFont fontWithName:@"Helvetica" andSize:24.0f] color:[UIColor orangeColor]];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:text];
}

-(void)testSwitchStateCopy {
    BYSwitchState *state = [[BYSwitchState alloc] init];
    state.textStyle = [BYText textWithFont:[BYFont fontWithName:@"ArialMT" andSize:10.0f] color:[UIColor grayColor]];
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
    BYDropShadow *shadow = [BYDropShadow shadowWithColor:[UIColor blueColor] andHeight:23.0f];
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
    BYTheme *theme = [BYTheme new];
    [self checkObjectCanBeCopiedAndResultHasEqualProperties:theme];
}

#pragma mark - Helper methods

-(id)styleFromDictNamed:(NSString*)name andClass:(Class)class {
    NSDictionary *dictionary = [BYCopyingTests dictionaryFromJSONFile:name];
    id style = [[class alloc] initWithDictionary:dictionary error:nil];
    return style;
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