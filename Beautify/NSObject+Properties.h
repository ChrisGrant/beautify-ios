//
//  NSObject+Properties.h
//  Beautify
//
//  Created by Chris Grant on 18/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Properties)

+(NSMutableArray*)propertyNames:(Class)propertyClass;

@end