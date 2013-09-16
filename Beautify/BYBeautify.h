//
//  BYBeautify.h
//  Beautify
//
//  Created by Adrian Conlin on 21/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Beautify is a singleton class which is responsible for activating the beautify framework for the current application. On
 activation all the UI controls within your application will have their rendering capabilities be 'enhanced'.
 
 When beautify has been activated, every instance of an 'enhanced' control will have a renderer associated with it. You
 can use the renderer to alter the style of individual UI controls.
 
    // access the renderer for my button
    BYButtonRenderer* renderer = self.myButton.renderer;

    // apply a big fat red border to the normal state
    BYBorder* border = [[BYBorder alloc] initWithColor:[UIColor redColor] width:30.0f radius:15.0f];
    [renderer setBorder:border forState:UIControlStateNormal];
 
 In development you are most likely going to want to activate beautify then connect to a streaming design session. To achieve
 this, add the following to your app delegate's `application:didFinishLaunchingWithOptions:` method:
 
    [[BYBeautify instance] activate];
    [[BYBeautifyStreamer instance] initiateDesignSessionWithUsername:@"test"];
 
 When you application is ready for release, you can save your style as a JSON file, then activate and load the style 
 with the following method:
 
    [[BYBeautify instance] activateWithStyle:@"StyleName"];
 
 */
@interface BYBeautify : NSObject

/*
 Accesses the beautify singleton instance.
 */
+(BYBeautify*)instance;

/*
 Activates the beautify in order to 'enhance' the UI controls of your application.
 */
-(void)activate;

/*
 Activates the beautify and loads a style from a JSON file with the given name.
 */
-(void)activateWithStyle:(NSString*)styleName;

@end
