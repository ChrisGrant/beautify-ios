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
//    theme.labelStyle.title = [BYText textWithFont:[BYFont fontWithName:@"Zapfino" andSize:0.0] color:[UIColor redColor]];
    [[BYThemeManager instance] applyTheme:theme];
    
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = CLLocationCoordinate2DMake(54.966404, -1.622422);
    annotation.title = @"Map Annotation Title";
    annotation.subtitle = @"Map Annotation Subtitle";
    [self.map addAnnotation:annotation];
    
    [self.map setRegion:MKCoordinateRegionMake(annotation.coordinate, MKCoordinateSpanMake(0.1, 0.1))];
}

- (IBAction)showAlertView:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert View" message:@"My background should be clear! You should be able to see the view behind this alert view. The view controller background color should not be applied to this view." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end