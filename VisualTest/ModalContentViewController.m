//
//  ModalContentViewController.m
//  Beautify
//
//  Created by Chris Grant on 28/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "ModalContentViewController.h"

@implementation ModalContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end