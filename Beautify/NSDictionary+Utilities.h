//
//  NSDictionary+Utilities.h
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Utilities)

-(id)objectForMandatoryKey:(NSString*)key;
-(BOOL)boolForMandatoryKey:(NSString*)key;
-(int)intForMandatoryKey:(NSString*)key;
-(float)floatForMandatoryKey:(NSString*)key;

@end