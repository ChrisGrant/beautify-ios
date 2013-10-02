//
//  JSONModel+Subclassing.h
//  Beautify
//
//  Created by Chris Grant on 02/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "JSONModel.h"

/*
 This is a necessary because for some unholy reason, in the unit tests asking a
 subclass of JSONModel if it's a subclass of JSONModel returns NO. This solves
 the problem by checking the "name" of the class. Not ideal but it allows the 
 unit tests to work!
 */

@interface JSONModel (Subclassing)

+(BOOL)isSubclassOfClass:(Class)aClass;

@end