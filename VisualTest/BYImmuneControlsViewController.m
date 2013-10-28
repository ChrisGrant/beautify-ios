//
//  BYImmuneControlsViewController.m
//  Beautify
//
//  Created by Chris Grant on 28/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "BYImmuneControlsViewController.h"
#import "Beautify.h"

@implementation BYImmuneControlsViewController

-(void)viewDidLoad {
    [super viewDidLoad];

    BYTheme *theme = [BYTheme fromFile:@"flat"];
    theme.labelStyle.title = [BYText textWithFont:[BYFont fontWithName:@"Zapfino" andSize:14.0f] color:[UIColor redColor]];
    [[BYThemeManager instance] applyTheme:theme];
}

- (IBAction)showAlertView:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert View" message:@"My background should be clear! You should be able to see the view behind this alert view. The view controller background color should not be applied to this view." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end