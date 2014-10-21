//
//  BYImmuneControlsViewController.m
//  Beautify
//
//  Created by Chris Grant on 28/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "BYImmuneControlsViewController.h"
#import "Beautify.h"
#import <MessageUI/MessageUI.h>
#import "ModalContentViewController.h"

@interface BYImmuneControlsViewController () <MFMailComposeViewControllerDelegate>
@end

@implementation BYImmuneControlsViewController {
}

-(void)viewDidLoad {
    [super viewDidLoad];

    BYTheme *theme = [BYTheme fromFile:@"flat"];
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

- (IBAction)showMailComposeController:(UIButton *)sender {
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mfController = [[MFMailComposeViewController alloc] init];
            [mfController setSubject:@"Beautify Visual Test"];
            [mfController setMailComposeDelegate:self];
            [self presentViewController:mfController animated:YES completion:NULL];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't send email" message:@"Please set up email on this device to be able to send mails" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:[NSString stringWithFormat:@"An error occurred: %@",[error description]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)showModalNavController:(UIButton *)sender {
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[ModalContentViewController new]];
    [self presentViewController:nc animated:YES completion:nil];
}

@end