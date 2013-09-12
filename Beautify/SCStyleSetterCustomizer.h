//
//  SCStyleSetterCustomizer.h
//  Beautify
//
//  Created by Colin Eberhardt on 10/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCStyle.h"

/**
 Utility class that handles customized style properties. This class acts as an adapter to classes
 that implement the SCStyleProtocol protocol. This customizer is used to customize a style based 
 on the style setters that form part of the style itself.
 */
@interface SCStyleSetterCustomizer : NSObject <SCStyleProtocol>

-(id)initWithStyle:(SCStyle*)style forState:(UIControlState)state;

@end
