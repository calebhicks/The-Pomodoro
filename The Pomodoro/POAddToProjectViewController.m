//
//  POAddToProjectViewController.m
//  Wired In
//
//  Created by Caleb Hicks on 6/12/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POAddToProjectViewController.h"
#import "ProjectController.h"

@interface POAddToProjectViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *workPeriodTitleField;
@property (weak, nonatomic) IBOutlet UITextField *workPeriodDescriptionField;

@end

@implementation POAddToProjectViewController

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

//    self.tableView = [[UITableView alloc]init];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    [self registerTableView:self.tableView];
    
    self.workPeriodTitleField.delegate = self;
    self.workPeriodDescriptionField.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Table View Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    Project *project = [ProjectController sharedInstance].projects[indexPath.row];
    cell.textLabel.text = project.projectTitle;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    if (project.projectDescription) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", project.projectDescription];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Project Created: %@", [dateFormatter stringFromDate:project.dateCreated]];
    }
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[ProjectController sharedInstance].projects count];
}


- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.delegate selectorDidSelectProject:[ProjectController sharedInstance].projects[indexPath.row]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    NSString *textFieldValue;
    NSInteger fieldInteger;
    
    if (textField == self.workPeriodTitleField) {
        textFieldValue = self.workPeriodTitleField.text;
        fieldInteger = 0;
    }
    
    if (textField == self.workPeriodDescriptionField){
        textFieldValue = self.workPeriodDescriptionField.text;
        fieldInteger = 1;
    }
    
    
    //[self.delegate selectorDidModifyTextField:textFieldValue fieldModified:fieldInteger];
    
    return YES;
}

//- (NSString *) selectorDidModifyTextField:(NSString *)textFieldValue fieldModified:(NSInteger)fieldInteger{
//    workperiod.periodTitle = textFieldValue;
//    workperiod.description = textFieldValue;
//}

@end
