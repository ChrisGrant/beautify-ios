//
//  BaseStyle.h
//  Beautify
//
//  Created by Adrian Conlin on 07/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYStyleProtocol.h"

/**
 Utility class that handles customized style properties. This class acts as an adapter to classes
 that implement the BYStyleProtocol protocol. This customizer is used to customize a style based on values that the
 user has set for a specific control instance.
 */
@interface BYStyleCustomizer : NSObject <BYStyleProtocol>

-(id)initWithStyle:(id<BYStyleProtocol>)style;

-(void)updateWithStyle:(id<BYStyleProtocol>)style;

-(void)setPropertyValue:(id)value forName:(NSString*)name;

-(void)removePropertyValueForName:(NSString*)name;

-(id)propertyValueForName:(NSString*)name;

@end
