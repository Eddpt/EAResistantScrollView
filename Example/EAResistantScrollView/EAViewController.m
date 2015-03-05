//
//  EAViewController.m
//  EAResistantScrollView
//
//  Created by Edgar Antunes on 03/05/2015.
//  Copyright (c) 2014 Edgar Antunes. All rights reserved.
//

#import "EAViewController.h"
#import <EAResistantScrollView/EAResistantScrollView.h>

@interface EAViewController ()
@property (weak, nonatomic) IBOutlet EAResistantScrollView *scrollView;
@end

@implementation EAViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.scrollView.shouldApplyResistance = self.shouldAllowResistance;
  self.scrollView.resistanceFactor = self.resistanceFactor;
  self.scrollView.resistanceProgressionRatio = self.resistanceProgressionRatio;
}

- (IBAction)didTapBackButton:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

@end
