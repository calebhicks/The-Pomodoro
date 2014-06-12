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
#import "TTAddCustomWorkPeriodViewController.h"
@import MessageUI;

@interface TTProjectDetailViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *projectTitle;
@property (weak, nonatomic) IBOutlet UITextField *projectDescription;
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
    self.projectDescription.text = self.project.projectDescription;
    
    self.workPeriodTableView.dataSource = self;
    self.workPeriodTableView.delegate = self;
    self.projectTitle.delegate = self;
    self.projectDescription.delegate = self;
    
    // Activate/deactive toolbar items
    
    [[[self.toolbar items] objectAtIndex:0] setEnabled:YES]; // activate add button
    [[[self.toolbar items] objectAtIndex:2] setEnabled:YES]; // activate start button
    [[[self.toolbar items] objectAtIndex:4] setEnabled:NO]; // deactivate finish button
    
    if([self.project.workPeriods count] == 0){
    [[[self.toolbar items] objectAtIndex:6] setEnabled:NO]; // deactivate report button
    };
    
    [self updateLabel];

    
}

- (void)viewWillAppear:(BOOL)animated{
    [self updateLabel];
    [self.workPeriodTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"workperiodcell"];
    
    TTWorkPeriod *tempWorkPeriod = [self.project.workPeriods objectAtIndex:indexPath.row];
    
    NSDateFormatter *startDateFormatter = [NSDateFormatter new];
    [startDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [startDateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    NSDateFormatter *endDateFormatter = [NSDateFormatter new];
    [endDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [endDateFormatter setDateStyle:NSDateFormatterNoStyle];
    
    if (tempWorkPeriod.startTime && tempWorkPeriod.finishTime) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [startDateFormatter stringFromDate:tempWorkPeriod.startTime], [endDateFormatter stringFromDate:tempWorkPeriod.finishTime]];
    } else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - running", [startDateFormatter stringFromDate:tempWorkPeriod.startTime]];
    }
    
    if(self.project.currentWorkPeriod.duration){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", tempWorkPeriod.duration];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.project.workPeriods count];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    self.project.projectTitle = self.projectTitle.text;
    self.project.projectDescription = self.projectDescription.text;
    
    [self.workPeriodTableView reloadData];
    
    [[TTProjectController sharedInstance]synchronize];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)addButton:(id)sender {
    
    TTAddCustomWorkPeriodViewController *addCustomWorkPeriodViewController = [[TTAddCustomWorkPeriodViewController alloc]init];
    
    TTWorkPeriod *workPeriodToBeAdded = [[TTWorkPeriod alloc]init];
    
    self.project.currentWorkPeriod = workPeriodToBeAdded;
    
    addCustomWorkPeriodViewController.project = self.project;
    

//    [[NSNotificationCenter defaultCenter] addObserver:self.project selector:@selector(addWorkPeriod) name:@"customworkperiod" object:nil];
    
    [self presentViewController:addCustomWorkPeriodViewController animated:YES completion:nil];

    [[[self.toolbar items] objectAtIndex:0] setEnabled:YES];
    [[[self.toolbar items] objectAtIndex:2] setEnabled:YES];
    [[[self.toolbar items] objectAtIndex:4] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:6] setEnabled:YES];
    
    [self.workPeriodTableView reloadData];
    
}

- (IBAction)startButton:(id)sender {
    
    [[[self.toolbar items] objectAtIndex:0] setEnabled:YES];
    [[[self.toolbar items] objectAtIndex:2] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:4] setEnabled:YES];
    [[[self.toolbar items] objectAtIndex:6] setEnabled:NO];
    
    [self startCurrentWorkPeriod];
    
    [self.workPeriodTableView reloadData];

    
}

- (IBAction)finishButton:(id)sender {
    
    [[[self.toolbar items] objectAtIndex:0] setEnabled:YES];
    [[[self.toolbar items] objectAtIndex:2] setEnabled:YES];
    [[[self.toolbar items] objectAtIndex:4] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:6] setEnabled:YES];
    
    [self endCurrentWorkPeriod];
    
    [self.workPeriodTableView reloadData];

}

- (IBAction)reportButton:(id)sender {
    
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc]init];
    
    mailViewController.mailComposeDelegate = self;
    
    NSString *stringFromArray;
    
    NSDateFormatter *emailDateFormatter = [[NSDateFormatter alloc]init];
    
    [emailDateFormatter setDateStyle:NSDateFormatterShortStyle];
    [emailDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    
    for (TTWorkPeriod *workPeriod in self.project.workPeriods) {
        
        if (stringFromArray) {
            if (workPeriod.duration) {
                stringFromArray = [NSString stringWithFormat:@"%@\n %@ to %@\n", stringFromArray, [emailDateFormatter stringFromDate:workPeriod.startTime], [emailDateFormatter stringFromDate:workPeriod.finishTime]];
            } else {
                stringFromArray = [NSString stringWithFormat:@"%@\n%@ to %@\n", stringFromArray, [emailDateFormatter stringFromDate:workPeriod.startTime], [emailDateFormatter stringFromDate:workPeriod.finishTime]];
            }
        } else{
            stringFromArray = [NSString stringWithFormat:@"\n%@ to %@\n", [emailDateFormatter stringFromDate:workPeriod.startTime], [emailDateFormatter stringFromDate:workPeriod.finishTime]];
        }
        
    }
    
    stringFromArray = [NSString stringWithFormat:@"%@\nTotal Time: %@", stringFromArray, self.timeLabel.text];
    
    [mailViewController setMessageBody:stringFromArray isHTML:NO];
    
    [self presentViewController:mailViewController animated:YES completion:nil];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) startCurrentWorkPeriod{
    [self.project startNewWorkPeriod];
    
    [self.workPeriodTableView reloadData];
}

- (void) endCurrentWorkPeriod{
    [self.project endCurrentWorkPeriod];
    
    [self updateLabel];
    
    [self.workPeriodTableView reloadData];
}

- (void)updateLabel {
    
    NSTimeInterval projectDuration = self.project.totalDuration;
    NSInteger projectDurationInteger = projectDuration;
    NSInteger countdown = projectDuration;
    
    NSInteger hours;
    NSInteger minutes;
    NSInteger seconds;

    if(projectDurationInteger > 3600){
        hours = floor(projectDuration/3600);
        countdown -= hours*3600;
    } else{
        hours = 0;
    }
    
    if(countdown > 60){
        minutes = floor(countdown/60);
        countdown -= minutes*60;
    } else{
        minutes = 0;
    }
    
    seconds = countdown % 60; //remainder of timeinterval

    
    if (minutes < 10) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d:0%d", hours, minutes];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentTime" object:self.timeLabel.text userInfo:nil];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%d:%d", hours, minutes];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentTime" object:self.timeLabel.text userInfo:nil];
    }
    
//    if want 00:00:00
//    if (minutes < 10 && seconds < 10){
//        self.timeLabel.text = [NSString stringWithFormat:@"%d:%0d:0%d", hours, minutes, seconds];
//    } else
//    if (minutes < 10) {
//        self.timeLabel.text = [NSString stringWithFormat:@"%d:%0d:0%d", hours, minutes, seconds];
//    } else
//    if (seconds < 10) {
//        self.timeLabel.text = [NSString stringWithFormat:@"%d:%d:0%d", hours, minutes, seconds];
//        //[[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentTime" object:self.timeLabel.text userInfo:nil];
//    } else {
//        self.timeLabel.text = [NSString stringWithFormat:@"%d:%d:%d", hours, minutes, seconds];
//        //[[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentTime" object:self.timeLabel.text userInfo:nil];
//    }
}

@end
