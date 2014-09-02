//
//  ParserTests.m
//  Beautify
//
//  Created by Chris Grant on 13/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BYButtonStyle.h"
#import "UIColor+Comparison.h"
#import "BYGradientStop.h"
#import "BYStateSetter.h"
#import "BYSwitchState.h"
#import "BYLabelStyle.h"
#import "BYViewControllerStyle.h"
#import "BYTextFieldStyle.h"
#import "BYNavigationBarStyle.h"
#import "BYTableViewCellStyle.h"
#import "BYSliderStyle.h"
#import "BYBarButtonStyle.h"
#import "BYImageViewStyle.h"
#import "BYTheme.h"
#import "BYSwitchStyle.h"
#import "BYTabBarStyle.h"

@interface ConfigParserTests : XCTestCase
@end

// These tests test the public API of BYConfigParser
@implementation ConfigParserTests

#pragma mark - Default / Nil Theme Testing

-(void)testConfigParserWithNilDictionary {
    BYTheme *theme;
    XCTAssertNoThrow(theme = [[BYTheme alloc] initWithDictionary:nil error:nil],
                     @"Shouldn't throw with a nil dictionary");
    XCTAssertNil(theme, @"Theme should be nil");
}

-(void)testConfigParserWithEmptyDictonary {
    BYTheme *theme;
    XCTAssertNoThrow(theme = [[BYTheme alloc] initWithDictionary:@{} error:nil],
                     @"Shouldn't throw with an empty dictionary");
}

-(void)testConfigParserWithInvalidDictionary {
    BYTheme *theme;
    NSDictionary *dict = @{@"invalid": @"dictionary", @"still": @{@"Invalid": @"dict", @"theme": @[]}};
    XCTAssertNoThrow(theme = [[BYTheme alloc] initWithDictionary:dict error:nil],
                     @"Shouldn't throw with an invalid dictionary");
}

#pragma mark - Button Style Testing

-(void)testButtonStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYButtonStyle class]];
}

-(void)testButtonStyleWithEmptyDict {
    [self assertStyleIsNilWithEmptyDictForClass:[BYButtonStyle class]];
}

-(void)testButtonStyleWithValidDict {
    BYButtonStyle *buttonStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidButtonStyle"
                                                                                         andClass:[BYButtonStyle class]];
    
    [self assertText:buttonStyle.title hasName:@"HelveticaNeue-Bold" size:10.0f andColor:[UIColor blackColor]];

    [self assertTextShadow:buttonStyle.titleShadow hasColor:[UIColor blueColor] andOffset:CGSizeMake(2, 5)];
    
    XCTAssert([buttonStyle.backgroundColor isEqualToColor:[UIColor blackColor]], @"Background should be black");
    
    [self assertGradient:buttonStyle.backgroundGradient hasStopOneColor:[UIColor redColor] atPosition:0.1 andStopTwoColor:[UIColor blueColor] atPosition:0.9f andIsRadial:NO withRadialOffset:CGSizeZero];
    
    [self assertBorder:buttonStyle.border hasWidth:1.0f color:[UIColor redColor] andCornerRadius:8.0f];
    
    [self assertShadows:buttonStyle.outerShadow hasOneShadowWithColor:[UIColor greenColor] radius:2.0f andOffset:CGSizeMake(2, 3)];
    
    BYStateSetter *setter = buttonStyle.stateSetters[0];
    XCTAssertEqual(setter.state, UIControlStateHighlighted, @"Should be for the highlighted state");
    XCTAssert([setter.propertyName isEqualToString:@"title"], @"Should be for the title");
    
    BYText *text = setter.value;
    [self assertText:text hasName:@"HelveticaNeue-Bold" size:14.0f andColor:[UIColor whiteColor]];
}

-(void)testButtonStyleWithPartialDict {
    BYButtonStyle *buttonStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialButtonStyle"
                                                                                         andClass:[BYButtonStyle class]];
    
    [self assertText:buttonStyle.title hasName:@"HelveticaNeue" size:11 andColor:[UIColor blackColor]];
    
    XCTAssert([buttonStyle.backgroundColor isEqualToColor:[UIColor whiteColor]], @"Background should be black");
    
    [self assertBorder:buttonStyle.border hasWidth:2 color:[UIColor blackColor] andCornerRadius:9];
}

#pragma mark - Switch Style Testing

-(void)testSwitchStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYSwitchStyle class]];
}

-(void)testSwitchStyleWithEmptyDict {
    [self assertStyleIsNilWithEmptyDictForClass:[BYSwitchStyle class]];
}

-(void)testSwitchStyleWithValidDict {
    BYSwitchStyle *switchStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidSwitchStyle"
                                                                                       andClass:[BYSwitchStyle class]];
    BYSwitchState *onState = switchStyle.onState;
    BYSwitchState *offState = switchStyle.offState;
    
    [self assertSwitchState:onState
               hasTextColor:[UIColor whiteColor] font:@"Helvetica-Bold" size:0
                    andText:@"ON" backgroundColor:[UIColor blackColor]
            textShadowColor:[UIColor blueColor] andTextShadowOffset:CGSizeMake(0, 2)];
    [self assertSwitchState:offState
               hasTextColor:[UIColor redColor] font:@"Helvetica-Neue" size:16
                    andText:@"OFF" backgroundColor:[UIColor whiteColor]
            textShadowColor:[UIColor blackColor] andTextShadowOffset:CGSizeMake(2, 0)];
    
    [self assertBorder:switchStyle.thumbBorder hasWidth:1 color:[UIColor greenColor] andCornerRadius:15.0f];
    
    XCTAssert([switchStyle.highlightColor isEqualToColor:[UIColor whiteColor]], @"Highlight color should be white");
    XCTAssert([switchStyle.thumbBackgroundColor isEqualToColor:[UIColor whiteColor]], @"Background color should be white");
    
    [self assertGradient:switchStyle.thumbBackgroundGradient
         hasStopOneColor:[UIColor whiteColor] atPosition:1.0f
         andStopTwoColor:[UIColor blueColor] atPosition:0.0f andIsRadial:NO withRadialOffset:CGSizeZero];
    
    [self assertShadows:switchStyle.thumbInnerShadow hasOneShadowWithColor:[UIColor whiteColor]
                 radius:2 andOffset:CGSizeMake(2, 2)];
    XCTAssertNil(switchStyle.thumbOuterShadow, @"Should be no outer shadow.");
    
    [self assertShadows:switchStyle.innerShadow hasOneShadowWithColor:[UIColor blackColor]
                 radius:4 andOffset:CGSizeZero];
    [self assertShadows:switchStyle.outerShadow hasOneShadowWithColor:[UIColor redColor]
                 radius:0 andOffset:CGSizeMake(0, -2)];
    
    [self assertBorder:switchStyle.border hasWidth:1 color:[UIColor redColor] andCornerRadius:15];
}

-(void)testSwitchStyleWithPartialDict {
    BYSwitchStyle *switchStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialSwitchStyle"
                                                                                         andClass:[BYSwitchStyle class]];
    BYSwitchState *onState = switchStyle.onState;
    BYSwitchState *offState = switchStyle.offState;
    
    [self assertSwitchState:onState
               hasTextColor:nil font:nil size:0
                    andText:@"YES" backgroundColor:[UIColor blackColor]
            textShadowColor:nil andTextShadowOffset:CGSizeZero];
    [self assertSwitchState:offState
               hasTextColor:[UIColor redColor] font:@"Helvetica-Neue" size:16
                    andText:@"NO" backgroundColor:[UIColor whiteColor]
            textShadowColor:[UIColor blackColor] andTextShadowOffset:CGSizeMake(2, 0)];

    [self assertBorder:switchStyle.border hasWidth:2 color:[UIColor redColor] andCornerRadius:5.0f];
}

-(void)assertSwitchState:(BYSwitchState*)state
            hasTextColor:(UIColor*)textColor font:(NSString*)font size:(float)textSize
                 andText:(NSString*)text
         backgroundColor:(UIColor*)bgColor
         textShadowColor:(UIColor*)textShadowColor andTextShadowOffset:(CGSize)offset {
    
    XCTAssert([state.text isEqualToString:text], @"Text should be equal");
    XCTAssert([state.backgroundColor isEqualToColor:bgColor], @"Background should be equal");
    
    [self assertText:state.textStyle hasName:font size:textSize andColor:textColor];
    [self assertTextShadow:state.textShadow hasColor:textShadowColor andOffset:offset];
}

#pragma mark - Label Style Testing 

-(void)testLabelStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYLabelStyle class]];
}

-(void)testLabelStyleWithEmptyDict {
    [self assertStyleIsNilWithEmptyDictForClass:[BYLabelStyle class]];
}

-(void)testLabelStyleWithValidDict {
    BYLabelStyle *labelStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidLabelStyle"
                                                                                       andClass:[BYLabelStyle class]];
    [self assertText:labelStyle.title hasName:@"HelveticaNeue-Bold" size:29 andColor:[UIColor redColor]];
    [self assertTextShadow:labelStyle.titleShadow hasColor:[UIColor blueColor] andOffset:CGSizeMake(2, 5)];
}

-(void)testLabelStyleWithPartialDict {
    BYLabelStyle *labelStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialLabelStyle"
                                                                                       andClass:[BYLabelStyle class]];
    [self assertText:labelStyle.title hasName:@"HelveticaNeue-Bold" size:10.0f andColor:[UIColor whiteColor]];
    [self assertTextShadow:labelStyle.titleShadow hasColor:[UIColor blueColor] andOffset:CGSizeMake(1, 2)];
}

#pragma mark - View Controller Testing

-(void)testViewControllerStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYLabelStyle class]];
}

-(void)testViewControllerStyleWithEmptyDict {
    [self assertStyleIsNilWithEmptyDictForClass:[BYLabelStyle class]];
}

-(void)testViewControllerStyleWithValidDict {
    BYViewControllerStyle *vcStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidVCStyle"
                                                                                             andClass:[BYViewControllerStyle class]];
    XCTAssert([vcStyle.backgroundColor isEqualToColor:[UIColor whiteColor]], @"Background should be white");
    [self assertGradient:vcStyle.backgroundGradient hasStopOneColor:[UIColor whiteColor] atPosition:1.0f
         andStopTwoColor:[UIColor blueColor] atPosition:0 andIsRadial:NO withRadialOffset:CGSizeZero];
    XCTAssertEqual(UIStatusBarStyleLightContent, vcStyle.statusBarStyle);
}

-(void)testViewControllerStyleWithPartialDict {
    BYViewControllerStyle *vcStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialVCStyle"
                                                                                             andClass:[BYViewControllerStyle class]];
    XCTAssert([vcStyle.backgroundColor isEqualToColor:[UIColor whiteColor]], @"Background should be white");
}

#pragma mark - Text Field Testing

-(void)testTextFieldStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYTextFieldStyle class]];
}

-(void)testTextFieldStyleWithEmptyDict {
    [self assertStyleIsNilWithEmptyDictForClass:[BYTextFieldStyle class]];
}

-(void)testTextFieldStyleWithValidDict {
    BYTextFieldStyle *textStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidTextFieldStyle"
                                                                                          andClass:[BYTextFieldStyle class]];
    
    [self assertText:textStyle.title hasName:@"HelveticaNeue-Medium" size:10.0f andColor:[UIColor blackColor]];
    
    XCTAssert([textStyle.backgroundColor isEqualToColor:[UIColor blackColor]], @"Background should be black");
    
    [self assertGradient:textStyle.backgroundGradient hasStopOneColor:[UIColor redColor] atPosition:0.5
         andStopTwoColor:[UIColor blueColor] atPosition:0.9f andIsRadial:YES withRadialOffset:CGSizeZero];
    
    [self assertBorder:textStyle.border hasWidth:1.0f color:[UIColor redColor] andCornerRadius:8.0f];
    
    [self assertShadows:textStyle.outerShadow hasOneShadowWithColor:[UIColor greenColor] radius:2.0f andOffset:CGSizeMake(2, 3)];
}

-(void)testTextFieldStyleWithPartialDict {
    BYTextFieldStyle *textStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialTextFieldStyle"
                                                                                          andClass:[BYTextFieldStyle class]];
    [self assertText:textStyle.title hasName:@"HelveticaNeue-Bold" size:12.0f andColor:[UIColor redColor]];
    
    XCTAssert([textStyle.backgroundColor isEqualToColor:[UIColor blueColor]], @"Background should be black");
    
    [self assertBorder:textStyle.border hasWidth:1.0f color:nil andCornerRadius:8.0f];
}

#pragma mark - Navigation Bar Testing

-(void)testNavBarStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYNavigationBarStyle class]];
}

-(void)testNavBarStyleWithEmptyDict {
    [self assertStyleIsNilWithEmptyDictForClass:[BYNavigationBarStyle class]];
}

-(void)testNavBarStyleWithValidDict {
    BYNavigationBarStyle *navStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidNavigationBarStyle"
                                                                                             andClass:[BYNavigationBarStyle class]];
    XCTAssert([navStyle.backgroundColor isEqualToColor:[UIColor greenColor]], @"BG color should be green");
    [self assertGradient:navStyle.backgroundGradient
         hasStopOneColor:[UIColor blackColor] atPosition:0
         andStopTwoColor:[UIColor whiteColor] atPosition:1.0
             andIsRadial:NO withRadialOffset:CGSizeZero];
    
    [self assertText:navStyle.title hasName:@"Helvetica-Bold" size:0 andColor:[UIColor whiteColor]];
    [self assertTextShadow:navStyle.titleShadow hasColor:[UIColor blueColor] andOffset:CGSizeMake(10, 10)];
    
    XCTAssert([navStyle.dropShadow.color isEqualToColor:[UIColor blueColor]], @"Drop shadow should be blue");
    XCTAssertEqual(navStyle.dropShadow.height, 12.0f, @"Should be 12px high");
}

-(void)testNavBarStyleWithPartialDict {
    BYTextFieldStyle *navStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialNavigationBarStyle"
                                                                                          andClass:[BYNavigationBarStyle class]];
    XCTAssert([navStyle.backgroundColor isEqualToColor:[UIColor greenColor]], @"BG color should be green");
    [self assertText:navStyle.title hasName:@"Helvetica-Bold" size:0 andColor:[UIColor whiteColor]];
}

#pragma mark - Table View Cell Testing

-(void)testTableCellStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYTableViewCellStyle class]];
}

-(void)testTableCellStyleWithEmptyDict {
    [self assertStyleIsNilWithEmptyDictForClass:[BYTableViewCellStyle class]];
}

-(void)testTableCellStyleWithValidDict {
    BYTableViewCellStyle *tableStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidTableViewCellStyle"
                                                                                             andClass:[BYTableViewCellStyle class]];
    [self assertText:tableStyle.title hasName:@"Arial-BoldMT" size:2 andColor:[UIColor redColor]];
    [self assertTextShadow:tableStyle.titleShadow hasColor:[UIColor blueColor] andOffset:CGSizeMake(2, 5)];
    XCTAssert([tableStyle.backgroundColor isEqualToColor:[UIColor whiteColor]], @"BG should be white");
    [self assertGradient:tableStyle.backgroundGradient
         hasStopOneColor:[UIColor redColor] atPosition:0.1 andStopTwoColor:[UIColor blueColor] atPosition:0.9
             andIsRadial:NO withRadialOffset:CGSizeZero];
    [self assertBorder:tableStyle.border hasWidth:1 color:[UIColor redColor] andCornerRadius:8];
    [self assertShadows:tableStyle.outerShadow hasOneShadowWithColor:[UIColor greenColor] radius:2 andOffset:CGSizeMake(2, 3)];
    [self assertShadows:tableStyle.innerShadow hasOneShadowWithColor:[UIColor redColor] radius:3 andOffset:CGSizeMake(5, 5)];
    XCTAssertNotNil(tableStyle.accessoryViewImage, @"Accessory image should not be nil");
    XCTAssertNotNil(tableStyle.editingAccessoryViewImage, @"Editing accessory image should not be nil");
}

-(void)testTableCellStyleWithPartialDict {
    BYTableViewCellStyle *tableStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialTableViewCellStyle"
                                                                                               andClass:[BYTableViewCellStyle class]];
    [self assertText:tableStyle.title hasName:@"Arial-BoldMT" size:9 andColor:[UIColor blackColor]];
    [self assertGradient:tableStyle.backgroundGradient
         hasStopOneColor:[UIColor greenColor] atPosition:0.1 andStopTwoColor:[UIColor blueColor] atPosition:0.9
             andIsRadial:NO withRadialOffset:CGSizeZero];
    [self assertBorder:tableStyle.border hasWidth:1 color:[UIColor redColor] andCornerRadius:8];
}

#pragma mark - Image View Testing

-(void)testImageViewStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYImageViewStyle class]];
}

// We don't call assertStyleIsNilWithEmptyDictForClass:[BYImageViewStyle class] here because image view style *should* be nil
// with an empty dictionary - all of it's properties are optional and it is also optional on theme.

-(void)testImageViewStyleWithValidDict {
    BYImageViewStyle *imageStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidImageViewStyle"
                                                                                           andClass:[BYImageViewStyle class]];
    [self assertBorder:imageStyle.border hasWidth:53.0f color:[UIColor redColor] andCornerRadius:1];
    [self assertShadows:imageStyle.outerShadow hasOneShadowWithColor:[UIColor greenColor] radius:2.0f andOffset:CGSizeMake(2, 3)];
    [self assertShadows:imageStyle.innerShadow hasOneShadowWithColor:[UIColor whiteColor] radius:5.0f andOffset:CGSizeMake(1, 4)];
}

-(void)testImageViewStyleWithPartialDict {
    BYImageViewStyle *imageStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialImageViewStyle"
                                                                                           andClass:[BYImageViewStyle class]];
    [self assertBorder:imageStyle.border hasWidth:1 color:[UIColor redColor] andCornerRadius:0];
}

#pragma mark - Bar Button Testing

-(void)testBarButtonStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYBarButtonStyle class]];
}

-(void)testBarButtonStyleWithEmptyDict {
    [self assertStyleIsNilWithEmptyDictForClass:[BYBarButtonStyle class]];
}

-(void)testBarButtonStyleWithValidDict {
    BYBarButtonStyle *barStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidBarButtonStyle"
                                                                                         andClass:[BYBarButtonStyle class]];
    [self assertText:barStyle.title hasName:@"HelveticaNeue-Bold" size:10.0f andColor:[UIColor blackColor]];
    
    [self assertTextShadow:barStyle.titleShadow hasColor:[UIColor blueColor] andOffset:CGSizeMake(2, 5)];
    
    XCTAssert([barStyle.backgroundColor isEqualToColor:[UIColor whiteColor]], @"Background should be white");
    
    [self assertGradient:barStyle.backgroundGradient hasStopOneColor:[UIColor redColor] atPosition:0.1
         andStopTwoColor:[UIColor blueColor] atPosition:0.9f andIsRadial:NO withRadialOffset:CGSizeZero];
    
    [self assertBorder:barStyle.border hasWidth:1.0f color:[UIColor redColor] andCornerRadius:8.0f];
    
    [self assertShadows:barStyle.outerShadow hasOneShadowWithColor:[UIColor greenColor] radius:2.0f andOffset:CGSizeMake(2, 3)];
}

-(void)testBarButtonStyleWithPartialDict {
    BYBarButtonStyle *barStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialBarButtonStyle"
                                                                                         andClass:[BYBarButtonStyle class]];
    
    [self assertGradient:barStyle.backgroundGradient hasStopOneColor:[UIColor redColor] atPosition:0.0
         andStopTwoColor:[UIColor blueColor] atPosition:0.5f andIsRadial:NO withRadialOffset:CGSizeZero];
    [self assertBorder:barStyle.border hasWidth:5.0f color:[UIColor redColor] andCornerRadius:1.0f];
}

#pragma mark - Slider Testing

-(void)testSliderStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYSliderStyle class]];
}

-(void)testSliderStyleWithEmptyDict {
    [self assertStyleIsNilWithEmptyDictForClass:[BYSliderStyle class]];
}

-(void)testSliderStyleWithValidDict {
    BYSliderStyle *sliderStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidSliderStyle" andClass:[BYSliderStyle class]];

    [self assertBorder:sliderStyle.barBorder hasWidth:2 color:[UIColor redColor] andCornerRadius:10];
    
    [self assertShadows:sliderStyle.barInnerShadow hasOneShadowWithColor:[UIColor blackColor] radius:4 andOffset:CGSizeZero];
    [self assertShadows:sliderStyle.barOuterShadow hasOneShadowWithColor:[UIColor redColor] radius:0 andOffset:CGSizeMake(0, -2)];
    
    XCTAssertEqual((float)sliderStyle.barHeightFraction, 1.0f, @"Bar Height Fraction should be 1");
    
    XCTAssert([sliderStyle.minimumTrackColor isEqualToColor:[UIColor blackColor]], @"Minimum track should be black");
    [self assertGradient:sliderStyle.minimumTrackBackgroundGradient
         hasStopOneColor:[UIColor redColor] atPosition:0.5 andStopTwoColor:[UIColor blueColor] atPosition:0.6
             andIsRadial:NO withRadialOffset:CGSizeZero];
    
    XCTAssert([sliderStyle.maximumTrackColor isEqualToColor:[UIColor greenColor]], @"Maximum track should be green");
    [self assertGradient:sliderStyle.maximumTrackBackgroundGradient
         hasStopOneColor:[UIColor redColor] atPosition:0.1 andStopTwoColor:[UIColor whiteColor] atPosition:0.5
             andIsRadial:NO withRadialOffset:CGSizeZero];
    
    
    [self assertBorder:sliderStyle.thumbBorder hasWidth:1 color:[UIColor greenColor] andCornerRadius:15.0f];
    
    XCTAssert([sliderStyle.thumbBackgroundColor isEqualToColor:[UIColor whiteColor]], @"Background color should be white");
    
    [self assertGradient:sliderStyle.thumbBackgroundGradient
         hasStopOneColor:[UIColor whiteColor] atPosition:1.0f
         andStopTwoColor:[UIColor blueColor] atPosition:0.0f andIsRadial:NO withRadialOffset:CGSizeZero];
    
    [self assertShadows:sliderStyle.thumbInnerShadow hasOneShadowWithColor:[UIColor whiteColor]
                 radius:2 andOffset:CGSizeMake(2, 2)];
    XCTAssertNil(sliderStyle.thumbOuterShadow, @"Should be no outer shadow");
}

-(void)testSliderStyleWithPartialDict {
    BYSliderStyle *sliderStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialSliderStyle"
                                                                                               andClass:[BYSliderStyle class]];
    XCTAssertEqual(sliderStyle.barHeightFraction, 0.2f, @"Bar Height fraction should be 0.2");
}

#pragma mark - Tab Bar Testing

-(void)testTabBarStyleWithNilDict {
    [self assertStyleIsNilWithNilDictForClass:[BYTabBarStyle class]];
}

-(void)testTabBarStyleWithEmptyDict {
    [self assertStyleIsNilWithEmptyDictForClass:[BYTabBarStyle class]];
}

-(void)testTabBarStyleWithPartialDict {
    BYTabBarStyle *tabBarStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"PartialTabBarStyle"
                                                                                         andClass:[BYTabBarStyle class]];
    XCTAssert([tabBarStyle.backgroundColor isEqualToColor:[UIColor greenColor]], @"Background color should be green");
}

-(void)testTabBarStyleWithValidDict {
    BYTabBarStyle *tabBarStyle = [self assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:@"ValidTabBarStyle" andClass:[BYTabBarStyle class]];

    XCTAssert([tabBarStyle.backgroundColor isEqualToColor:[UIColor blueColor]], @"BG color should be blue");
    
    [self assertGradient:tabBarStyle.backgroundGradient
         hasStopOneColor:[UIColor blackColor] atPosition:0
         andStopTwoColor:[UIColor whiteColor] atPosition:1.0
             andIsRadial:NO withRadialOffset:CGSizeZero];
    
    XCTAssert([tabBarStyle.tintColor isEqualToColor:[UIColor blackColor]], @"Tint color should be black");
    XCTAssert([tabBarStyle.imageTintColor isEqualToColor:[UIColor whiteColor]], @"Image tint color should be white");
    
    [self assertBorder:tabBarStyle.border hasWidth:1.0f color:[UIColor redColor] andCornerRadius:8.0f];
    
    [self assertShadows:tabBarStyle.outerShadow hasOneShadowWithColor:[UIColor greenColor] radius:2.0f andOffset:CGSizeMake(2, 3)];
    
    [self assertShadows:tabBarStyle.innerShadow hasOneShadowWithColor:[UIColor whiteColor] radius:5.0f andOffset:CGSizeMake(1, 4)];
}

#pragma mark - Helper Methods

-(id)assertNotNilAndDoesNotThrowWhileReturningStyleFromJSONFile:(NSString*)fileName andClass:(Class)class {
    NSDictionary *dictionary = [ConfigParserTests dictionaryFromJSONFile:fileName];
    XCTAssertNotNil(dictionary, @"Dictionary should not be nil with valid JSON. Check file name and if the file is in the test bundle");
    
    id style;
    XCTAssertNoThrow(style = [[class alloc] initWithDictionary:dictionary error:nil],
                     @"Shouldn't throw with valid JSON");
    XCTAssertNotNil(style, @"Shouldn't be nil with valid JSON");
    return style;
}

-(void)assertStyleIsNilWithNilDictForClass:(Class)class {
    id style;
    XCTAssertNoThrow(style = [[class alloc] initWithDictionary:nil error:nil], @"Shouldn't throw");
    XCTAssertNil(style, @"Style should be nil for class %@", class);
}

-(void)assertStyleIsNilWithEmptyDictForClass:(Class)class {
    id style;
    XCTAssertNoThrow(style = [[class alloc] initWithDictionary:@{} error:nil], @"Shouldn't throw");
    XCTAssertNil(style, @"Style should be be nil for class %@", class);
}

-(void)assertShadows:(BYShadow*)array hasOneShadowWithColor:(UIColor*)color radius:(float)radius andOffset:(CGSize)offset {
    BYShadow *shadow = array;
    XCTAssert([shadow.color isEqualToColor:color], @"Colors should be equal");
    XCTAssertEqual(shadow.radius, radius, @"Radii should be equal");
    XCTAssertTrue(CGSizeEqualToSize(shadow.offset, offset), @"Offset should be equal");
}

-(void)assertGradient:(BYGradient*)gradient hasStopOneColor:(UIColor*)color1 atPosition:(float)position1
      andStopTwoColor:(UIColor*)color2 atPosition:(float)position2
          andIsRadial:(BOOL)radial withRadialOffset:(CGSize)offset {
                 
    XCTAssertEqual(gradient.stops.count, (NSUInteger)2, @"Should only be 2 stops");
    
    XCTAssertEqual(gradient.radial, radial, @"Radial should be equal");
    if(gradient.radial) {
        XCTAssertTrue(CGSizeEqualToSize(gradient.radialOffset, offset), @"Offsets should be equal");
    }
    
    BYGradientStop *stop1 = gradient.stops[0];
    XCTAssert([stop1.color isEqualToColor:color1], @"Stop 1 color should be equal");
    XCTAssertEqual(stop1.position, position1, @"Position 1 should be equal");

    BYGradientStop *stop2 = gradient.stops[1];
    XCTAssert([stop2.color isEqualToColor:color2], @"Stop 2 color should be equal");
    XCTAssertEqual(stop2.position, position2, @"Position 2 should be equal");
}

-(void)assertBorder:(BYBorder*)border hasWidth:(float)width color:(UIColor*)color andCornerRadius:(float)radius {
    XCTAssertEqual(border.width, width, @"Width should be equal");
    if(color != nil && border.color != nil) {
        XCTAssert([border.color isEqualToColor:color], @"Colors should be equal");
    }
    XCTAssertEqual(border.cornerRadius, radius, @"Corner Radius should be equal");
}

-(void)assertTextShadow:(BYTextShadow*)textShadow hasColor:(UIColor*)color andOffset:(CGSize)size {
    if(!textShadow) {
        return;
    }
    XCTAssertTrue(CGSizeEqualToSize(textShadow.offset, size), @"Text shadow should be equal");
    XCTAssert([textShadow.color isEqualToColor:color], @"Text shadow should be equal");
}

-(void)assertText:(BYText*)text hasName:(NSString*)name size:(float)size andColor:(UIColor*)color {
    if(!text) {
        return;
    }
    XCTAssert([text.color isEqualToColor:color], @"Colors should be equal");
    [self assertFont:text.font hasName:name andSize:size];
}

-(void)assertFont:(BYFont*)font hasName:(NSString*)name andSize:(float)size {
    if(!font) {
        return;
    }
    XCTAssert([font.name isEqualToString:name], @"Font name should be equal");
    XCTAssertEqual(font.size, size, @"Size should be equal");
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