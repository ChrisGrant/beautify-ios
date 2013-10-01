//
//  BYStateSetter.m
//  Beautify
//
//  Created by Colin Eberhardt on 09/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYStateSetter.h"
#import "BYConfigParser_Private.h"

@implementation BYStateSetter

-(NSString *)description {
    return [NSString stringWithFormat:@"property : %@, value : %@",
            self.propertyName, self.value];
}

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    return [BYConfigParser stateSetterFromDict:dict];
}

@end