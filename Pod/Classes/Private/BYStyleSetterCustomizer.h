//
//  BYStyleSetterCustomizer.h
//  Beautify
//
//  Created by Colin Eberhardt on 10/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYStyle.h"

/**
 Utility class that handles customized style properties. This class acts as an adapter to classes
 that implement the BYStyleProtocol protocol. This customizer is used to customize a style based 
 on the style setters that form part of the style itself.
 */
@interface BYStyleSetterCustomizer : NSObject <BYStyleProtocol>

-(id)initWithStyle:(BYStyle*)style forState:(UIControlState)state;

@end