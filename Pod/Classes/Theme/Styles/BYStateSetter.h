//
//  BYStateSetter.h
//  Beautify
//
//  Created by Colin Eberhardt on 09/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol BYStateSetter
@end

@interface NSArray (StateSetter) <BYStateSetter>
@end

/**
 State setters are used to describe the various visual states affect a style. A state setter
 is associated with a control state and describes the value that will be applied to a given style property
 when the given state is enhanced.
 */
@interface BYStateSetter : JSONModel

@property NSString *propertyName;

@property (nonatomic, strong) id <Ignore> value;
@property (nonatomic) UIControlState state;

@end