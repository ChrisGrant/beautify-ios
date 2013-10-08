//
//  BackgroundImage.m
//  Beautify
//
//  Created by Colin Eberhardt on 27/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYBackgroundImage.h"

@implementation BYBackgroundImage

-(id)copyWithZone:(NSZone *)zone {
    BYBackgroundImage *copy = [[BYBackgroundImage allocWithZone:zone] init];
    copy.data = self.data.copy;
    return copy;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    id style = [super initWithDictionary:dict error:err];
    
    BYBackgroundImage *bgImage = (BYBackgroundImage*)style;
    [bgImage setContentMode:[BYBackgroundImage contentModeFromDict:dict]];
    return style;
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return [[propertyName lowercaseString] isEqualToString:@"contentMode"];
}

-(id)JSONObjectForContentMode {
    switch (self.contentMode) {
        case BYImageContentModeFill:
            return @"fill";
        case BYImageContentModeAspectFill:
            return @"aspectFill";
        case BYImageContentModeTile:
            return @"tile";
        default:
            return @"fill";
    }
}

+(BYImageContentMode)contentModeFromDict:(NSDictionary*)dict {
    if([[dict allKeys] containsObject:@"contentMode"]) {
        NSString *contentString = [dict[@"contentMode"] lowercaseString];
        if([contentString isEqualToString:@"fill"]) {
            return BYImageContentModeFill;
        }
        else if([contentString isEqualToString:@"aspectfill"]) {
            return BYImageContentModeAspectFill;
        }
        else if([contentString isEqualToString:@"tile"]) {
            return BYImageContentModeTile;
        }
    }
    return BYImageContentModeFill; // Default to fill.
}

+(BYBackgroundImage*)backgroundImageWithImage:(UIImage*)image andContentMode:(BYImageContentMode)contentMode {
    BYBackgroundImage *bg = [[self class] new];
    [bg setData:image];
    [bg setContentMode:contentMode];
    return bg;
}

@end