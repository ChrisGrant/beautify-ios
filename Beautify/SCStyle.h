//
//  SCStyle.h
//  Beautify
//
//  Created by Colin Eberhardt on 09/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCStyleProtocol.h"

@interface SCStyle : NSObject <SCStyleProtocol>

@property NSArray* stateSetters;

-(id)propertyValueForName:(NSString*)name;

@end
