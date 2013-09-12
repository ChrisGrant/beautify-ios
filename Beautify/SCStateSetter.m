//
//  SCStateSetter.m
//  Beautify
//
//  Created by Colin Eberhardt on 09/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCStateSetter.h"

@implementation SCStateSetter

-(NSString *)description {
    return [NSString stringWithFormat:@"property : %@, value : %@",
            self.propertyName, self.value];
}

@end
