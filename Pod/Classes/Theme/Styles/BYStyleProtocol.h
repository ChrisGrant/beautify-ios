//
//  StyleProtocol.h
//  Beautify
//
//  Created by Colin Eberhardt on 10/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

// a protocol which defines the interface for styles
@protocol BYStyleProtocol <NSObject>

-(id)propertyValueForName:(NSString*)name;
    
@end
