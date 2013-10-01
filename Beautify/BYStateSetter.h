//
//  BYStateSetter.h
//  Beautify
//
//  Created by Colin Eberhardt on 09/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@protocol BYStateSetter
@end

@interface NSArray (StateSetter) <BYStateSetter>
@end

/*
 State setters are used to describe hwo various visual states affect a style. A state setter
 is associated with a control state and describes the value that will be applied to a given style property
 when the givestate is entered.
 */
@interface BYStateSetter : JSONModel

@property UIControlState state;

@property NSString *propertyName;

@property id value;

@end