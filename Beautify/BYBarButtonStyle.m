//
//  BYBarButtonStyle.m
//  Beautify
//
//  Created by Chris Grant on 10/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYBarButtonStyle.h"
#import "BYFont.h"
#import "BYVersionUtils.h"
#import "BYGradientStop.h"
#import "UIImage+Base64.h"

@implementation BYBarButtonStyle

+(BYBarButtonStyle*)defaultStyle {
    BYBarButtonStyle *style = [BYBarButtonStyle new];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.title = [BYText textWithFont:[BYFont fontWithName:[UIFont systemFontOfSize:1.0].fontName andSize:15.0f]
                                     color:[UIColor colorWithRed:0 green:122.0f/255.0f blue:1.0f alpha:1.0f]];
    }
    else {
        style.title = [BYText textWithFont:[BYFont fontWithName:[UIFont boldSystemFontOfSize:1.0f].fontName] color:[UIColor whiteColor]];
        style.titleShadow = [BYTextShadow shadowWithOffset:CGSizeMake(0, -1) andColor:[UIColor blackColor]];
        style.border = [BYBorder borderWithColor:[UIColor blackColor] width:0.0f radius:5.0f];
        
        style.backgroundGradient = [BYGradient gradientWithStops:@[[BYGradientStop stopWithColor:[UIColor colorWithWhite:1.0 alpha:0.3] at:0.0],
                                                                        [BYGradientStop stopWithColor:[UIColor colorWithWhite:0.0 alpha:0.3] at:0.5],
                                                                        [BYGradientStop stopWithColor:[UIColor colorWithWhite:0.0 alpha:0.3] at:0.95],
                                                                        [BYGradientStop stopWithColor:[UIColor colorWithWhite:0.9 alpha:0.9] at:1.0]] isRadial:NO radialOffset:CGSizeZero];
        style.backgroundColor = [UIColor blackColor];
        style.innerShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 1) radius:1.0f color:[UIColor colorWithWhite:0.0f alpha:0.9f]];
    }
    return style;
}

+(BYBarButtonStyle*)defaultBackButtonStyle {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        BYBarButtonStyle *backStyle = [BYBarButtonStyle defaultStyle];
        
        BYBackgroundImage *bgImage = [BYBackgroundImage new];

        UIImage *bg;
        if([[UIScreen mainScreen] scale] == 2.0) {
            // Retina back button
            bg = [UIImage imageFromBase64String:@"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABbgAAAA8CAYAAACkRdxLAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyNpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDE0IDc5LjE1MTQ4MSwgMjAxMy8wMy8xMy0xMjowOToxNSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChNYWNpbnRvc2gpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjBCNkYzQUYzMjFEMDExRTM5RDQ1RjdERUQ4OUZGNjczIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjBCNkYzQUY0MjFEMDExRTM5RDQ1RjdERUQ4OUZGNjczIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MEI2RjNBRjEyMUQwMTFFMzlENDVGN0RFRDg5RkY2NzMiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MEI2RjNBRjIyMUQwMTFFMzlENDVGN0RFRDg5RkY2NzMiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz6yNBJZAAAExUlEQVR42uzdTagVZRwG8LmjWNwiQdKFGEHRQigQahH0BX0qlKsUTKEPocg2hS6KorRFi6KgIhLKQnJRWJGWGmK2rFW2qJ2rBFtEQZAuJDk9w5FqcWa8H+85l4HfD56F/t95L/yXD8OcqcFgUAEAAAAAQN9MKbgBAAAAAOgjBTcAAAAAAL2k4AYAAAAAoJcU3AAAAAAA9JKCGwAAAACAXlJwAwAAAADQSwpuAAAAAAB66d+C+6oX/57oHz718mLbBwAAAABgzuox3j2dHEy+SC63agAAAAAAShrXa9SXJAeSuy/8+3CyLjlj5QAAAAAAlDCON7iXJPur/8rtxm3VsOSetnIAAAAAAEooXXAvSj5KHhgxuz1518oBAAAAACihZME9lbyfbOw4c9rKAQAAAAAooVTB3ZTbbyePdJzZl7xg5QAAAAAAlFCq4H41eapj/nk1LL/PWzkAAAAAACWUKLhfSnZ0zI8kmyrlNgAAAAAABc234N6e7OyYf5s8mJyzagAAAAAASppPwf1k8lrH/PtkfXLWmgEAAAAAKG2uBffDyTvV8MclRzmRrE3+smIAAAAAAMZhLgX3hmRP1V5u/5zcl/xpvQAAAAAAjMtsC+77k33Jopb5yeTe5DerBQAAAABgnGZTcN+V7E+WtMxPXThz2loBAAAAABi3mRbctyQHk0tb5r8mdya/WCkAAAAAAJMwk4L7puRQMt0ybz5H0nyW5KR1AgAAAAAwKRcruJu3so8kS1vmzQ9Jrk1+skoAAAAAACapq+B+LDmWXNkyP5OsS36wRgAAAAAAJq2t4H40eS+ZapmfTdYn31khAAAAAAALYVTBvaUalttt5fe5ZENy3PoAAAAAAFgoo0rs55JFHc/sSg5bHQAAAAAAC2lUwf1sNXxLu832ZI3VAQAAAACwkEYV3F8mDyXnW55ZlhxNbrA+AAAAAAAWStt3tj9LNlftJffy5Fiy2goBAAAAAFgIdcfsk2Rr1V5yr6iGJfd11ggAAAAAwKTVF5nvTR5PBi3zlcnx5FqrBAAAAABgkuoZnPkg2Va1l9yrkm+Sq60TAAAAAIBJqWd4bnfydMe8KbebN7lXWSkAAAAAAJNQz+LsW8n2jvk11bDkXmmtAAAAAACMWz3L828kz3fMmx+cbH54coXVAgAAAAAwTvUcnnkl2dkxX10Nv8m93HoBAAAAABiXeo7P7aqGRXeb65OjyTIrBgAAAABgHOp5PNt8quT1jvmaalhyL7VmAAAAAABKq+f5/I7kzY75jcnXlZIbAAAAAIDC6gJ3PJPs7pjfnHyVXGbdAAAAAACUUqLgHiTbkj0dZ25NDiXTVg4AAAAAQAl1oXuakvuJZG/HmTsuMgcAAAAAgBmrC951PtmafNxx5gorBwAAAACghLrwfU3JvSX5dMTsRLLJygEAAAAAKKEew51Nyb05OfC///sxuSf5w8oBAAAAAChh8ZjuPZdsTD5MVlTDN7d/t24AAAAAAEpZPMa7m5J7sxUDAAAAADAOtRUAAAAAANBHU4PBwBYAAAAAAOgdBTcAAAAAAL2k4AYAAAAAoJcU3AAAAAAA9JKCGwAAAACAXlJwAwAAAADQSwpuAAAAAAB6ScENAAAAAEAv/SPAAJLKo0xMYKP5AAAAAElFTkSuQmCC"];
        }
        else {
            // Standard back button
            bg = [UIImage imageFromBase64String:@"data:image/png;base64,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"];
        }
        bgImage.data = bg;
        bgImage.contentMode = BYImageContentModeTile;
        backStyle.backgroundImage = bgImage;
        return backStyle;
    }
    else {
        return [BYBarButtonStyle defaultStyle];
    }
}

@end