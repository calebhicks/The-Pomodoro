//
//  TTProjectDetailViewController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTProjectDetailViewController.h"
#import "TTProjectController.h"
#import "TTWorkPeriod.h"

@interface TTProjectDetailViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *projectTitle;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITableView *workPeriodTableView;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *finishButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reportButton;

@end

@implementation TTProjectDetailViewController

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
    // Do any additional setup after loading the view from its nib.
    self.projectTitle.text = self.project.projectTitle;
    
    self.workPeriodTableView.dataSource = self;
    self.workPeriodTableView.delegate = self;
    self.projectTitle.delegate = self;
    
    // Activate/deactive toolbar items
    
    [[[self.toolbar items] objectAtIndex:0] setEnabled:YES]; // activate add button
    [[[self.toolbar items] objectAtIndex:2] setEnabled:NO]; // deactivate start button
    [[[self.toolbar items] objectAtIndex:4] setEnabled:NO]; // deactivate finish button
    [[[self.toolbar items] objectAtIndex:6] setEnabled:NO]; // deactivate report button

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"workperiodcell"];
    
    NSDateFormatter *startDateFormatter = [NSDateFormatter new];
    [startDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [startDateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    NSDateFormatter *endDateFormatter = [NSDateFormatter new];
    [endDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [endDateFormatter setDateStyle:NSDateFormatterNoStyle];
    
    if (self.project.currentWorkPeriod.startTime && self.project.currentWorkPeriod.finishTime) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [startDateFormatter stringFromDate:self.project.currentWorkPeriod.startTime], [endDateFormatter stringFromDate:self.project.currentWorkPeriod.finishTime]];
    } else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - running", [startDateFormatter stringFromDate:self.project.currentWorkPeriod.startTime]];
    }
    
    if(self.project.currentWorkPeriod.duration){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.project.currentWorkPeriod.duration];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.project.workPeriods count];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.project.projectTitle = self.projectTitle.text;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)addButton:(id)sender {
    [self createNewWorkPeriod];
    
    [[[self.toolbar items] objectAtIndex:0] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:2] setEnabled:YES];
    [[[self.toolbar items] objectAtIndex:4] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:6] setEnabled:NO];
    
    [self.workPeriodTableView reloadData];
    
}

- (IBAction)startButton:(id)sender {
    
    [[[self.toolbar items] objectAtIndex:0] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:2] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:4] setEnabled:YES];
    [[[self.toolbar items] objectAtIndex:6] setEnabled:NO];
    
    [self startCurrentWorkPeriod];
    
    [self.workPeriodTableView reloadData];

    
}

- (IBAction)finishButton:(id)sender {
    
    [[[self.toolbar items] objectAtIndex:0] setEnabled:YES];
    [[[self.toolbar items] objectAtIndex:2] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:4] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:6] setEnabled:YES];
    
    [self endCurrentWorkPeriod];
    
    [self.workPeriodTableView reloadData];

}

- (IBAction)reportButton:(id)sender {

    // add e-mail sheet to send current project work periods
    
}

- (void) createNewWorkPeriod{

    
}

- (void) startCurrentWorkPeriod{
    [self.project addWorkPeriod:self.project.currentWorkPeriod toProject:self.project];
    
    [self.workPeriodTableView reloadData];
}

- (void) endCurrentWorkPeriod{
    [self.project endCurrentWorkPeriod];
    
    [self.workPeriodTableView reloadData];
}

@end
