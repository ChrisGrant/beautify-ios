//
//  BYDelegateMultiplexer.h
//  Beautify
//
//  Created by Colin Eberhardt on 03/06/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYDelegateMultiplexer : NSObject

@property id delegate;
@property id proxiedDelegate;

@end