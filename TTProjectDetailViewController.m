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
    [[[self.toolbar items] objectAtIndex:2] setEnabled:NO]; // deactivate start button
    [[[self.toolbar items] objectAtIndex:4] setEnabled:NO]; // deactivate finish button
    
    if([self.project.workPeriods count] == 0){
    [[[self.toolbar items] objectAtIndex:6] setEnabled:NO]; // deactivate report button
    };

    
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
    
//    if(textField == self.projectTitle){
//    self.project.projectTitle = self.projectTitle.text;
//    } else if(textField == self.projectDescription){
//        self.project.projectDescription = self.projectDescription.text;
//    }
    
    self.project.projectTitle = self.projectTitle.text;
    self.project.projectDescription = self.projectDescription.text;
    
    [self.workPeriodTableView reloadData];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)addButton:(id)sender {

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
    [[[self.toolbar items] objectAtIndex:2] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:4] setEnabled:NO];
    [[[self.toolbar items] objectAtIndex:6] setEnabled:YES];
    
    [self endCurrentWorkPeriod];
    
    [self.workPeriodTableView reloadData];

}

- (IBAction)reportButton:(id)sender {

    // add e-mail sheet to send current project work periods
    
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc]init];
    
    mailViewController.mailComposeDelegate = self;
    
    NSString *stringFromArray;
    
    for (TTWorkPeriod *workPeriod in self.project.workPeriods) {
        
        if (workPeriod.description) {
            stringFromArray = [NSString stringWithFormat:@"%@\n%@ to %@\n", workPeriod.description, workPeriod.startTime, workPeriod.finishTime];
        } else {
            stringFromArray = [NSString stringWithFormat:@"\n%@ to %@\n", workPeriod.startTime, workPeriod.finishTime];
        }
    }
    
    
    [mailViewController setMessageBody:stringFromArray isHTML:YES];
    
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
    
    [self.workPeriodTableView reloadData];
}

@end
