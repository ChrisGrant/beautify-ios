//
//  BYStyle.h
//  Beautify
//
//  Created by Colin Eberhardt on 09/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYStyleProtocol.h"

@interface BYStyle : NSObject <BYStyleProtocol>

@property NSArray* stateSetters;

-(id)propertyValueForName:(NSString*)name;

@end
