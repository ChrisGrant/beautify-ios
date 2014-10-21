//
//  BYViewControllerConfig.m
//  Beautify
//
//  Created by Chris Grant on 06/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "UIColor+HexColors.h"
#import "BYViewControllerStyle.h"

@implementation BYViewControllerStyle

+ (BYViewControllerStyle*)defaultStyle {
    BYViewControllerStyle *style = [BYViewControllerStyle new];
    style.backgroundColor = [UIColor whiteColor];
    style.backgroundImage = nil;
    style.backgroundGradient = nil;
    style.statusBarStyle = UIStatusBarStyleDefault;
    return style;
}

- (id)copyWithZone:(NSZone *)zone {
    BYViewControllerStyle *copy = [[BYViewControllerStyle allocWithZone:zone] init];
    copy.backgroundColor = self.backgroundColor.copy;
    copy.backgroundGradient = self.backgroundGradient.copy;
    copy.backgroundImage = self.backgroundImage.copy;
    copy.statusBarStyle = self.statusBarStyle;
    return copy;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    if(dict.allKeys.count == 0) {
        return nil;
    }

    BYViewControllerStyle *style = [super initWithDictionary:dict error:err];

    if([dict.allKeys containsObject:@"statusBarStyle"] &&
       [[dict[@"statusBarStyle"] lowercaseString] isEqualToString:@"light"]) {
        style.statusBarStyle = UIStatusBarStyleLightContent;
    }
    else {
        style.statusBarStyle = UIStatusBarStyleDefault;
    }
    
    return style;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [[super toDictionary] mutableCopy];
    dict[@"statusBarStyle"] = self.statusBarStyle == UIStatusBarStyleDefault ? @"default" : @"light";
    return dict;
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return [propertyName isEqualToString:@"backgroundImage"] ||
    [propertyName isEqualToString:@"backgroundGradient"] ||
    [propertyName isEqualToString:@"statusBarStyle"];
}

@end