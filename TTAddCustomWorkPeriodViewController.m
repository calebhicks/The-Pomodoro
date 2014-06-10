//
//  TTAddCustomWorkPeriodViewController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/9/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTAddCustomWorkPeriodViewController.h"

@interface TTAddCustomWorkPeriodViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *startTimePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *finishTimePicker;
@property (weak, nonatomic) IBOutlet UIButton *addWorkPeriodButton;

@end

@implementation TTAddCustomWorkPeriodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.project.currentWorkPeriod.startTime) {
        [self.startTimePicker setDate:self.project.currentWorkPeriod.startTime animated:YES];
    }
    
    if (self.project.currentWorkPeriod.finishTime) {
        [self.finishTimePicker setDate:self.project.currentWorkPeriod.finishTime animated:YES];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTimePickerChanged:(id)sender {
    self.project.currentWorkPeriod.startTime = self.startTimePicker.date;
}


- (IBAction)finishTimePickerChanged:(id)sender {
    self.project.currentWorkPeriod.finishTime = self.finishTimePicker.date;
}

- (IBAction)addWorkPeriodButtonPressed:(id)sender {
    
    [self.project addWorkPeriod];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
