//
//  StyleProtocol.h
//  Beautify
//
//  Created by Colin Eberhardt on 10/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

// a protocol which defines the interface for styles
@protocol SCStyleProtocol <NSObject>

-(id)propertyValueForName:(NSString*)name;
    
@end
