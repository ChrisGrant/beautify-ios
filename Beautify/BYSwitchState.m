//
//  BYSwitchState.m
//  Beautify
//
//  Created by Colin Eberhardt on 28/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYSwitchState.h"

@implementation BYSwitchState

-(id)copyWithZone:(NSZone *)zone {
    BYSwitchState *copy = [[BYSwitchState allocWithZone:zone] init];
    copy.textStyle = self.textStyle.copy;
    copy.text = self.text.copy;
    copy.backgroundColor = self.backgroundColor.copy;
    copy.textShadow = self.textShadow.copy;
    return copy;
}

@end