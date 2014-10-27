//
//  BYBeautify.h
//  Beautify
//
//  Created by Adrian Conlin on 21/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Beautify is a singleton class which is responsible for activating the beautify framework for the current application. On
 activation all the UI controls within your application will have their rendering capabilities be 'enhanced'.
 
 When beautify has been activated, every instance of an 'enhanced' control will have a renderer associated with it. You
 can use the renderer to alter the style of individual UI controls.
 
    // access the renderer for my button
    BYButtonRenderer* renderer = self.myButton.renderer;

    // apply a big fat red border to the normal state
    BYBorder* border = [[BYBorder alloc] initWithColor:[UIColor redColor] width:30.0f radius:15.0f];
    [renderer setBorder:border forState:UIControlStateNormal];
 
 When you application is ready for release, you can save your style as a JSON file, then activate and load the style 
 with the following method:
 
    [[BYBeautify instance] activateWithStyle:@"StyleName"];
 
 */
@interface BYBeautify : NSObject

/**
 *  Accesses the beautify singleton instance.
 */
+ (BYBeautify *)instance;

/**
 *  Activates beautify in order to 'enhance' the UI controls of your application.
 */
- (void)activate;

/**
 *  Activates beautify and loads a style from a JSON file with the given name.
 *
 *  @param styleName The JSON file name of the style file to load. Note that you do not need to specify the '.json'
 *  file extension.
 */
- (void)activateWithStyle:(NSString *)styleName;

#pragma mark - 
#pragma mark Version Info

/** Returns a string describing the version of the Beautify framework being used. */
+ (NSString*)getInfo;
- (NSString*)getInfo;

@end