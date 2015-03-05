//
//  EASetUpViewController.m
//  EAResistantScrollView
//
//  Created by Edgar Antunes on 05/03/2015.
//  Copyright (c) 2015 Edgar Antunes. All rights reserved.
//

#import "EASetUpViewController.h"
#import "EAViewController.h"

@interface EASetUpViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *shouldAllowResistanceSwitch;
@property (weak, nonatomic) IBOutlet UITextField *resistanceFactorTextField;
@property (weak, nonatomic) IBOutlet UITextField *resistanceProgressionRatioTextField;

@end

@implementation EASetUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"resistance-scroll-view-segue"]) {
    EAViewController *viewController = segue.destinationViewController;
    
    viewController.shouldAllowResistance = self.shouldAllowResistanceSwitch.on;
    viewController.resistanceFactor = self.resistanceFactorTextField.text.floatValue;
    viewController.resistanceProgressionRatio = self.resistanceProgressionRatioTextField.text.floatValue;
  }
}

@end
