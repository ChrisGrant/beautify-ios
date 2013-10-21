//
//  BYRendererPrecedenceViewController.m
//  Beautify
//
//  Created by Chris Grant on 21/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "BYRendererPrecedenceViewController.h"
#import "BYButtonRenderer.h"
#import "UIView+Beautify.h"
#import "UIViewController+Beautify.h"
#import "BYText.h"
#import "BYTheme.h"
#import "BYThemeManager.h"

@interface BYRendererPrecedenceViewController ()
@property (weak, nonatomic) IBOutlet UIButton *customFontButton;
@property (weak, nonatomic) IBOutlet UIButton *customBackgroundButton;
@end

@implementation BYRendererPrecedenceViewController {
    NSTimer *timer;
    BOOL _dark;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    [[self renderer] setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0f]];
    
    [[self.customBackgroundButton renderer] setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [[self.customBackgroundButton renderer] setBackgroundColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    [[self.customFontButton renderer] setTitleStyle:[BYText textWithFont:[BYFont fontWithName:@"Zapfino"] color:[UIColor blueColor]]
                                           forState:UIControlStateNormal];
    [[self.customFontButton renderer] setTitleStyle:[BYText textWithFont:[BYFont fontWithName:@"Zapfino"] color:[UIColor redColor]]
                                           forState:UIControlStateHighlighted];
    
    timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(changeTheme) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

-(void)changeTheme {
    BYTheme *theme;
    if(!_dark) {
        theme = [BYTheme fromFile:@"dark"];
        _dark = YES;
    }
    else {
        theme = [BYTheme fromFile:@"flat"];
        _dark = NO;
    }
    [[BYThemeManager instance] applyTheme:theme];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [timer invalidate];
    timer = nil;
}

@end