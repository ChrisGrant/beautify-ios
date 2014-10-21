//
//  BYStyle.h
//  Beautify
//
//  Created by Colin Eberhardt on 09/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYStyleProtocol.h"
#import "JSONModel.h"
#import "BYStateSetter.h"

@interface BYStyle : JSONModel <BYStyleProtocol, NSCopying>

@property NSArray<BYStateSetter, Optional> *stateSetters;

-(id)propertyValueForName:(NSString*)name;

@end