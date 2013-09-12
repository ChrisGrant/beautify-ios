//
//  Font.h
//  Beautify
//
//  Created by Colin Eberhardt on 21/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 A style property representing the font for the text on a UIView.
 */
@interface SCFont : NSObject

/*
 The font name.
 */
@property NSString* name;

/*
 The font size in points.
 */
@property float size;

/*
 Init with the specified font name.
 */
-(id)initWithName:(NSString*)name;

@end
